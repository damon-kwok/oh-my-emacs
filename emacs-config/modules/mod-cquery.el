;; -*- lexical-binding: t -*-
;; mod-cquery.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2018 damon-kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2018-01-15
;; Modify: 2018-01-15
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;
;; Code:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'mod-package)
;;
(package-require 'lsp-mode)
(require 'lsp-mode)

;; `company'
(package-require 'company-lsp)
(require 'company-lsp)
(push 'company-lsp company-backends)

;; `lsp-ui'
(package-require 'lsp-ui)
(require 'lsp-ui)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)

(package-require 'helm-xref)
(require 'helm-xref)
(setq xref-show-xrefs-function 'helm-xref-show-xrefs)

(add-to-list 'load-path "~/dev/cquery/emacs")
(require 'cquery)

(setq cquery-executable "~/.local/stow/cquery/bin/cquery")
(setq cquery-resource-dir (expand-file-name
			   "~/.local/stow/cquery/lib/clang+llvm-5.0.1-x86_64-linux-gnu-ubuntu-14.04"))
(setq cquery-extra-init-params 
      '(:enableComments 2 
			:cacheFormat "msgpack"))



(defun cquery-setup () 
  (interactive) 
  (lsp-cquery-enable) 
  (cquery-xref-find-custom "$cquery/base") 
  (cquery-xref-find-custom "$cquery/callers") 
  (cquery-xref-find-custom "$cquery/derived") 
  (cquery-xref-find-custom "$cquery/vars")

  ;; Alternatively, use lsp-ui-peek interface
  (lsp-ui-peek-find-custom 'base "$cquery/base") 
  (lsp-ui-peek-find-custom 'callers "$cquery/callers") 
  (lsp-ui-peek-find-custom "$cquery/derived") 
  (lsp-ui-peek-find-custom "$cquery/vars")
  ;; ......
  ;; don't include type signature in the child frame
  (setq lsp-ui-doc-include-signature nil)

  ;; don't show symbol on the right of info
  (setq lsp-ui-sideline-show-symbol nil))

(add-hook 'c-mode-hook 'cquery-setup)
(add-hook 'c++-mode-hook 'cquery-setup)
(add-hook 'objc-mode-hook 'cquery-setup)



;;;;;;;;;;;;;;;;;;;;;;;;;
;; cmake `font-lock'
(package-require 'cmake-font-lock)
(autoload 'cmake-font-lock-activate "cmake-font-lock" nil t)
(add-hook 'cmake-mode-hook 'cmake-font-lock-activate)

;; `create-or-open-cmake-file'
(defun m-search-file (filename &optional path) 
  (let ((from (if path path (m-buf-dirpath)))) 
    (message (concat "check:" from)) 
    (if (file-exists-p (concat from filename)) 
	(progn (message from) from) 
      (progn 
	(setq parent (m-parent-dirpath from)) 
	(if (or (eq parent nil) 
		(string= parent "/")) nil (m-search-file filename parent))))))

(defun m-smart-find-file (filename &optional create) 
  " create cmake file with current directory!" 
  (interactive) 
  (setq dir (m-buf-dirpath)) 
  (setq cmake-dir (m-search-file filename dir)) 
  (if (eq cmake-dir nil) 
      (if create (find-file filename)) 
    (find-file (concat cmake-dir filename))))

;; switch 'cmake buffer' and 'code buffer'
(defun m-open-or-close-cmakefile () 
  (interactive) 
  (if (or (eq major-mode 'c-mode) 
	  (eq major-mode 'c++-mode)) 
      (m-smart-find-file "CMakeLists.txt" t) 
    (if (eq major-mode 'cmake-mode) ;;(if (equal buffer-name "CMakeLists.txt")
	(kill-this-buffer))))

;; switch 'package-xml buffer' and 'code buffer'
(defun m-open-or-close-packagexml () 
  (interactive) 
  (if (or (eq major-mode 'c-mode) 
	  (eq major-mode 'c++-mode)) 
      (m-smart-find-file "package.xml") 
    (if (eq major-mode 'nxml-mode) 
	(kill-this-buffer))))

(defun find-cc-file (dir basename ext) 
  (let ((filename (concat dir "/" basename "." ext))) 
    (if (file-exists-p filename) 
	(find-file filename)
      ;; (progn (message "not found:%s" filename) nil)
      nil				;
      )))

(defun check-header (dir basename) 
  (cond ((find-cc-file dir basename "h") t) 
	((find-cc-file dir basename "H") t) 
	((find-cc-file dir basename "hh") t) 
	((find-cc-file dir basename "hpp") t) 
	((find-cc-file dir basename "h++") t) 
	((find-cc-file dir basename "hxx") t)))

(defun check-source (dir basename) 
  (cond ((find-cc-file dir basename "c") t) 
	((find-cc-file dir basename "C") t) 
	((find-cc-file dir basename "cc") t) 
	((find-cc-file dir basename "cpp") t) 
	((find-cc-file dir basename "c++") t) 
	((find-cc-file dir basename "cxx") t)))

(defun m-switch-cc-source-and-header () 
  (interactive) 
  (setq basename (m-bufname-no-ext)) 
  (setq dir0 (m-buf-dirpath)) 
  (setq dir0-name (m-buf-dirname)) 
  (setq extname (m-buf-ext)) 
  (concat (m-parent-dirpath dir0) dir0-name)
  ;; (setq postfixes '(".." "include" "src" "Classes" "Public" "Private" "../include" "../src" "../Classes" "../Public" "../Private"))
  (setq postfixes '("include" "src" "Classes" "Public" "Private")) 
  (setq dirs ()) 
  (add-to-list 'dirs dir0) 
  (dolist (postfix postfixes) 
    (add-to-list 'dirs (concat (m-parent-dirpath dir0) postfix)) 
    (add-to-list 'dirs (concat (m-parent-dirpath dir0) dir0-name)) 
    (add-to-list 'dirs (concat (m-parent-dirpath dir0) postfix "/" dir0-name)) 
    (add-to-list 'dirs (concat (m-parent-dirpath dir0) "../" postfix)) 
    (add-to-list 'dirs (concat (m-parent-dirpath dir0) "../" dir0-name)) 
    (add-to-list 'dirs (concat (m-parent-dirpath dir0) "../" postfix "/" dir0-name))
    ;;
    ) 
  (if (s-contains? "h" extname) 
      (dolist (dir dirs) 
	(check-source dir basename)) 
    (dolist (dir dirs) 
      (check-header dir basename))))

(require 'cmake-mode)
(define-key c-mode-map [f6] 'm-open-or-close-cmakefile)
(define-key c++-mode-map [f6] 'm-open-or-close-cmakefile)
(define-key cmake-mode-map [f6] 'm-open-or-close-cmakefile)

(define-key c-mode-map [f7] 'm-open-or-close-packagexml)
(define-key c++-mode-map [f7] 'm-open-or-close-packagexml)

(define-key c-mode-map [f12] 'm-switch-cc-source-and-header)
(define-key c++-mode-map [f12] 'm-switch-cc-source-and-header)

(define-key c++-mode-map [f5] 
  '(lambda () 
     (interactive) 
     (m-run-command "/home/damon/catkin_ws/bin/build_adsim")))

(require 'nxml-mode)
(define-key nxml-mode-map [f7] 'm-open-or-close-packagexml)


;;; Syntax highlighting support for "`Modern.C++'" - until `C++17' and Technical Specification.
(package-require 'modern-cpp-font-lock)
(require 'modern-cpp-font-lock)
(modern-c++-font-lock-global-mode t)


;; `format'
(package-require 'clang-format)
(require 'clang-format)
;; (define-key c++-mode-map (kbd "C-M-") 'clang-format-region)
(define-key c-mode-map (kbd "C-c C-f")  'clang-format-buffer)
(define-key c++-mode-map (kbd "C-c C-f")  'clang-format-buffer)
(define-key objc-mode-map (kbd "C-c C-f")  'clang-format-buffer)

(define-key c-mode-map (kbd "C-M-\\")  'clang-format-region)
(define-key c++-mode-map (kbd "C-M-\\")  'clang-format-region)
(define-key objc-mode-map (kbd "C-M-\\")  'clang-format-region)

(setq-default c-basic-offset 4 tab-width 4 indent-tabs-mode t)
(setq c-default-style "linux")
;; (package-require 'google-c-style)
;; (require 'google-c-style)
;; (setq indent-tabs-mode nil)
;; (setq default-tab-width 4)
;; (setq tab-width 4)

;; (add-hook 'c-mode-common-hook 'google-set-c-style)


;; (define-key c-mode-base-map (kbd "M-.") 'lsp-ui-peek-find-definitions)
;; (define-key c-mode-base-map (kbd "M-,") 'lsp-ui-peek-find-references)

;; xref-find-definitions xref-find-references,xref-find-apropos.
(define-key c-mode-base-map (kbd "M-.") 'xref-find-definitions)
(define-key c-mode-base-map (kbd "M-,") 'xref-find-references)
(define-key c-mode-base-map (kbd "M-?") 'xref-find-apropos)

;; (define-key c-mode-base-map (kbd "M-.") 'rtags-find-symbol-at-point)
;; (define-key c-mode-base-map (kbd "M-,") 'rtags-find-references-at-point)
;; (define-key c-mode-base-map (kbd "M-?") 'rtags-find-file)
;; (define-key c-mode-base-map (kbd "M-i") 'rtags-imenu)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-cquery)
;; mod-cquery.el ends here
