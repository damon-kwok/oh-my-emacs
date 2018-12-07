;; -*- lexical-binding: t -*-
;; mod-cc.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2018 damon-kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2018-08-03
;; Modify: 2018-08-03
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
;; Put c-mode as default for *.h files (improves parsing):
(add-to-list 'auto-mode-alist '("\\.h\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.c\\'" . c-mode))

;; Put c++-mode as default for *.h files (improves parsing):
(add-to-list 'auto-mode-alist '("\\.hh\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cc\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hxx\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cxx\\'" . c++-mode))

;; Enable case-insensitive searching:
;; (set-default 'semantic-case-fold t)

;; `shader-mode'
(package-require 'shader-mode)
(autoload 'shader-mode "shader" nil t) ;;(require 'shader-mode)
(add-to-list 'auto-mode-alist '("\\.shader$" . shader-mode))

;; `company'
;; (package-require 'company-c-headers)
;; (add-to-list 'company-backends 'company-c-headers)


;;; Syntax highlighting support for "`Modern.C++'" - until `C++17' and Technical Specification.
(package-require 'modern-cpp-font-lock)
(require 'modern-cpp-font-lock)
;; (add-hook 'c++-mode-hook #'modern-c++-font-lock-mode)
;; or
(modern-c++-font-lock-global-mode t)

;; `create-or-open-cmake-file'
(defun ome-search-file (filename &optional path) 
  (let ((from (if path path (ome-buf-dirpath)))) 
    (message (concat "check:" from)) 
    (if (file-exists-p (concat from filename)) 
        (progn (message from) from) 
      (progn 
        (setq parent (ome-parent-dirpath from)) 
        (if (or (eq parent nil) 
                (string= parent "/")) nil (ome-search-file filename parent))))))

(defun ome-smart-find-file (filename &optional create) 
  " create cmake file with current directory!" 
  (interactive) 
  (setq dir (ome-buf-dirpath)) 
  (setq cmake-dir (ome-search-file filename dir)) 
  (if (eq cmake-dir nil) 
      (if create (find-file filename)) 
    (find-file (concat cmake-dir filename))))

;; switch 'cmake buffer' and 'code buffer'
(defun ome-open-or-close-cmakefile () 
  (interactive) 
  (if (or (eq major-mode 'c-mode) 
          (eq major-mode 'c++-mode)) 
      (ome-smart-find-file "CMakeLists.txt" t) 
    (if (eq major-mode 'cmake-mode) ;;(if (equal buffer-name "CMakeLists.txt")
	    (kill-this-buffer))))

;; switch 'package-xml buffer' and 'code buffer'
(defun ome-open-or-close-packagexml () 
  (interactive) 
  (if (or (eq major-mode 'c-mode) 
          (eq major-mode 'c++-mode)) 
      (ome-smart-find-file "package.xml") 
    (if (eq major-mode 'nxml-mode) 
        (kill-this-buffer))))

(defun find-cc-file (dir basename ext) 
  (let ((filename (concat dir "/" basename "." ext))) 
    (if (file-exists-p filename) 
        (find-file filename)
      ;; (progn (message "not found:%s" filename) nil)
      nil                               ;
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

(defun ome-switch-cc-source-and-header () 
  (interactive) 
  (setq basename (ome-bufname-no-ext)) 
  (setq buf-dir (ome-buf-dirpath)) 
  (setq buf-dir-name (ome-buf-dirname)) 
  (setq extname (ome-buf-ext)) 
  (concat (ome-parent-dirpath buf-dir) buf-dir-name)
  ;; (setq postfixes '(".." "include" "src" "Classes" "Public" "Private" "../include" "../src" "../Classes" "../Public" "../Private"))
  (setq postfixes '("inc" "src" "include" "source" "Classes" "Public" "Private")) 
  (setq dirs ()) 
  (add-to-list 'dirs buf-dir) 
  (dolist (postfix postfixes) 
    (add-to-list 'dirs (concat (ome-parent-dirpath buf-dir) postfix)) 
    (add-to-list 'dirs (concat (ome-parent-dirpath buf-dir) buf-dir-name)) 
    (add-to-list 'dirs (concat (ome-parent-dirpath buf-dir) postfix "/" buf-dir-name)) 
    (add-to-list 'dirs (concat (ome-parent-dirpath buf-dir) "../" postfix)) 
    (add-to-list 'dirs (concat (ome-parent-dirpath buf-dir) "../" buf-dir-name)) 
    (add-to-list 'dirs (concat (ome-parent-dirpath buf-dir) "../" postfix "/" buf-dir-name)) 
    (add-to-list 'dirs (concat (ome-parent-dirpath buf-dir) "../../" postfix)) 
    (add-to-list 'dirs (concat (ome-parent-dirpath buf-dir) "../../" buf-dir-name)) 
    (add-to-list 'dirs (concat (ome-parent-dirpath buf-dir) "../../" postfix "/" buf-dir-name))
    ;;
    ) 
  (if (s-contains? "h" extname) 
      (dolist (dir dirs) 
        (check-source dir basename)) 
    (dolist (dir dirs) 
      (check-header dir basename))))

(package-require 'cmake-mode)
(require 'cmake-mode)
(define-key c-mode-map [f6] 'ome-open-or-close-cmakefile)
(define-key c++-mode-map [f6] 'ome-open-or-close-cmakefile)
(define-key objc-mode-map [f6] 'ome-open-or-close-cmakefile)
(define-key cmake-mode-map [f6] 'ome-open-or-close-cmakefile)

(require 'nxml-mode)
(define-key c-mode-map [f7] 'ome-open-or-close-packagexml)
(define-key c++-mode-map [f7] 'ome-open-or-close-packagexml)
(define-key objc-mode-map [f7] 'ome-open-or-close-packagexml)
(define-key nxml-mode-map [f7] 'ome-open-or-close-packagexml)

;; (define-key c-mode-map [f12] 'ome-switch-cc-source-and-header)
;; (define-key c++-mode-map [f12] 'ome-switch-cc-source-and-header)

(define-key c-mode-map [f12] 'projectile-find-other-file)
(define-key c++-mode-map [f12] 'projectile-find-other-file)
(define-key objc-mode-map [f12] 'projectile-find-other-file)

;; (define-key c++-mode-map [f5]
;; '(lambda ()
;; (interactive)
;; (ome-run-command "/home/damon/catkin_ws/bin/build_adsim")))


;; `format'
(package-require 'clang-format)
(require 'clang-format)

(define-key c-mode-map (kbd "C-c C-f")  'clang-format-buffer)
(define-key c++-mode-map (kbd "C-c C-f")  'clang-format-buffer)
(define-key objc-mode-map (kbd "C-c C-f")  'clang-format-buffer)

(define-key c-mode-map (kbd "C-M-\\")  'clang-format-region)
(define-key c++-mode-map (kbd "C-M-\\")  'clang-format-region)
(define-key objc-mode-map (kbd "C-M-\\")  'clang-format-region)

;; `cmake-font-lock'
(package-require 'cmake-font-lock)
(autoload 'cmake-font-lock-activate "cmake-font-lock" nil t)
(add-hook 'cmake-mode-hook 'cmake-font-lock-activate)

;; `cmake-file'
(defun gen-cmake-file () 
  (if (string= (ome-project-root) "") 
      (message "project root not found!") 
    (shell-command (concat "gen_cmake_file " (ome-project-root)))))

;; (add-hook 'c-mode-hook 'gen-cmake-file)
;; (add-hook 'c++-mode-hook 'gen-cmake-file)
;; (add-hook 'objc-mode-hook 'gen-cmake-file)

;; `cmake-ide'
;; (package-require 'cmake-ide)
;; (cmake-ide-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (define-key run-mode-map (kbd "RET") '(lambda (&optional EVENT)
;; (interactive)
;; (delete-other-windows)
;; (compile-goto-error EVENT)
;; ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Some code that will make it so the background color of the lines
;; that gcc found errors on, should be in another color.
(require 'custom)
(defvar all-overlays ())
(defun delete-this-overlay(overlay is-after begin end &optional len) 
  (delete-overlay overlay))
(defun highlight-current-line() 
  (interactive) 
  (setq current-point (point)) 
  (beginning-of-line) 
  (setq beg (point)) 
  (forward-line 1) 
  (setq end (point))
  ;; Create and place the overlay
  (setq error-line-overlay (make-overlay 1 1))

  ;; Append to list of all overlays
  (setq all-overlays (cons error-line-overlay all-overlays)) 
  (overlay-put error-line-overlay 'face '(background-color . "pink")) 
  (overlay-put error-line-overlay 'modification-hooks (list 'delete-this-overlay)) 
  (move-overlay error-line-overlay beg end) 
  (goto-char current-point))
(defun delete-all-overlays() 
  (while all-overlays (delete-overlay (car all-overlays)) 
         (setq all-overlays (cdr all-overlays))))
(defun highlight-error-lines(compilation-buffer process-result) 
  (interactive) 
  (delete-all-overlays) 
  (condition-case nil (while t (next-error) 
                             (highlight-current-line)) 
    (error 
     nil)))

;; (setq compilation-finish-function 'highlight-error-lines)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; `disaster'
(package-require 'disaster)
(require 'disaster)
(define-key c-mode-map (kbd "C-c d") 'disaster)
(define-key c++-mode-map (kbd "C-c d") 'disaster)
(define-key objc-mode-map (kbd "C-c d") 'disaster)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; `auto-menu'
(defun c-mode-menu ()
  '("gen-cmake" "cmake-build" "open:CMakeLists.txt"))

(defun c-mode-func (index)
  (cond ((= 0 index) 
         (gen-cmake-file)) 
        ((= 1 index) 
         (ome-cmake-build))
        ((= 2 index)
         (ome-open-or-close-cmakefile))
        (t (message  "c-mode menu:%d" index))))

;; `auto-menu'
(defun cmake-mode-menu ()
  '("0" "1" "close" "3" "4" "5" "6" "7" "8" "9"))

(defun cmake-mode-func (index)
  (cond ((= 0 index) 
         (message  "cmake-mode menu:%d" index)) 
        ((= 1 index) 
         (message  "cmake-mode menu:%d" index))
        ((= 2 index) 
         (ome-open-or-close-cmakefile))
        ((= 3 index) 
         (message  "cmake-mode menu:%d" index))
        ((= 4 index) 
         (message  "cmake-mode menu:%d" index))
        ((= 5 index) 
         (message  "cmake-mode menu:%d" index))
        ((= 6 index) 
         (message  "cmake-mode menu:%d" index))
        ((= 7 index) 
         (message  "cmake-mode menu:%d" index))
        ((= 8 index) 
         (message  "cmake-mode menu:%d" index))
        ((= 9 index) 
         (message  "cmake-mode menu:%d" index))
        (t (message  "cmake-mode menu:%d" index))))

(defun c++-mode-menu () (c-mode-menu))
(defun c++-mode-func (index) (c-mode-func index))

(defun objc-mode-menu () (c-mode-menu))
(defun objc-mode-func (index) (c-mode-func index))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-cc)
;; mod-cc.el ends here
