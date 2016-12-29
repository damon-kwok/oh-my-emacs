;;; -*- lexical-binding: t -*-
;;; mod-complete.el --- This is where you apply your OCD.
;;;
;;; Copyright (C) 2015-2016 Damon Kwok
;;;
;;; Author: gww <DamonKwok@msn.com>
;;; Date: 2016-01-19
;;;
;;; This program is free software; you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation, either version 3 of the License, or
;;; (at your option) any later version.
;;;
;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this program.  If not, see <http:;;www.gnu.org/licenses/>.
;;;
;;; Code:
;;;
(require 'mod-package)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(package-require 'popup)
(require 'popup)

;;(message projectile-project-root)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (package-require 'ido)
;; (require 'ido)
;; (ido-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `flycheck'
;;(package-require 'flycheck)
;;(add-hook 'after-init-hook #'global-flycheck-mode)
;;(setq flycheck-idle-change-delay 2) ; in seconds

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `auto-complete'
;;-(package-require 'auto-complete)
;;-(require 'auto-complete)
;;-(require 'auto-complete-config)

;;; `pos-tip'
;;-(package-require 'pos-tip)
;;-(require 'pos-tip)
;;-(setq ac-quick-help-prefer-pos-tip t)

;;; `ac-default'
;;-(ac-config-default)
;;-(global-auto-complete-mode t)
;;(setq-default ac-sources '(ac-source-words-in-same-mode-buffers))
;;(add-hook 'emacs-lisp-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-symbols)))
;;(add-hook 'auto-complete-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-filename)))

;; ac keybind settings

;;-(define-key ac-complete-mode-map (kbd "TAB") 'ac-next)
;;-(define-key ac-complete-mode-map (kbd "S-TAB") 'ac-previous)
;;-(define-key ac-complete-mode-map "\C-n" 'ac-next)
;;-(define-key ac-complete-mode-map "\C-p" 'ac-previous)
;; (define-key ac-complete-mode-map (kbd "SPC") nil)'ac-complete)
;; (define-key ac-menu-map "\C-n" 'ac-next)
;; (define-key ac-menu-map "\C-p" 'ac-previous)
;; (define-key ac-menu-map (kbd "TAB") 'ac-next)
;; (define-key ac-menu-map (kbd "S-TAB") 'ac-previous)
;; ;;(define-key ac-menu-map (kbd "SPC") 'ac-complete)

;; (set-face-background 'ac-candidate-face "LightGray")
;; (set-face-underline 'ac-candidate-face "DarkGray")
;; (set-face-background 'ac-selection-face "SteelBlue")

;;-(set-face-background 'ac-candidate-face "gray80")
;;-(set-face-underline 'ac-candidate-face "#330000")
;;-(set-face-background 'ac-selection-face "DarkBlue")

;;-(setq ac-use-menu-map t)
;;-(setq ac-auto-start 3)
;; (setq ac-dwim t)

;;-(global-set-key "\M-/" 'auto-complete)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `company'
(package-require 'company)
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(global-set-key (kbd "<M-/>") 'company-complete)
(global-set-key (kbd "<C-M-i>") 'company-complete)

(define-key company-active-map (kbd "C-n")  'company-select-next)
(define-key company-active-map (kbd "C-p")  'company-select-previous)

(package-require 'company-quickhelp)
(company-quickhelp-mode 1)

;;; `helm-company'
(package-require 'helm-company)
(autoload 'helm-company "helm-company") ;; Not necessary if using ELPA package
(eval-after-load 'company
  '(progn
     (define-key company-mode-map (kbd "C-:") 'helm-company)
     (define-key company-active-map (kbd "C-:") 'helm-company)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `yasnippet'
(package-require 'yasnippet)
(require 'yasnippet)

;; (setq yas-snippet-dirs '(yas-installed-snippets-dir (expand-file-name "~/config/snippets/")))
;; (setq yas-snippet-dirs (expand-file-name "~/emacs-config/snippets/"))
;;(setq yas-snippet-dirs (expand-file-name "~/emacs-config/snippets/"))

(setq dir-medusa-snippets "~/emacs-config/snippets/")
(setq dir-medusa-snippets2 "~/my-emacs-config/emacs-config/snippets/")
(add-to-list 'yas-snippet-dirs (expand-file-name dir-medusa-snippets))
(add-to-list 'yas-snippet-dirs (expand-file-name dir-medusa-snippets2))

(yas-global-mode 1)

(defun yas-open-snippet-file(file-name) 
  (interactive "sEnter snippet file name:") 
  (find-file (concat dir-medusa-snippets (symbol-name major-mode)"/"file-name)))

(defun yas-open-snippet-template() 
  (interactive) 
  (find-file (concat dir-medusa-snippets (symbol-name major-mode) "/auto-insert")))

;; (define-key yas-minor-mode-map (kbd "TAB") nil)
;; (define-key yas-minor-mode-map [backtab] 'yas-expand)
(global-set-key (kbd "C-x y f") 'yas-open-snippet-file)
(global-set-key (kbd "C-x y a") 'yas-open-snippet-template)

(defun yasnippet-current-line () ;; C-c TAB
  (interactive) 
  (let ((current-line (string-trim-right (thing-at-point 'line t)))) 
    (end-of-line) 
    (newline-and-indent) 
    (yas-expand-snippet (yasnippet-string-to-template (string-trim current-line)))))

(defun yasnippet-string-to-template (string) 
  (let ((count 1)) 
    (cl-labels ((rep (text) 
		     (let ((replace (format "${%d:%s}" count text))) 
		       (incf count) replace))) 
      (replace-regexp-in-string "[a-zA-Z0-9]+" #'rep string))))

(global-set-key (kbd "C-c TAB") 'yasnippet-current-line)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `auto-insert-mode'
(setq-default auto-insert-directory dir-medusa-snippets)
(auto-insert-mode)
(setq auto-insert-query nil) ;;don't ask me "R U want insert?"

(define-auto-insert "\\.org" "org-mode/auto-insert")

(define-auto-insert "\\.c" "cc-mode/auto-insert.c")
(define-auto-insert "\\.cpp" "cc-mode/auto-insert.c")
(define-auto-insert "\\.cxx" "cc-mode/auto-insert.c")

(define-auto-insert "\\.h" "cc-mode/auto-insert.h")
(define-auto-insert "\\.hpp" "cc-mode/auto-insert.hpp")
(define-auto-insert "\\.hxx" "cc-mode/auto-insert.hpp")

(define-auto-insert "\\.el" "emacs-lisp-mode/auto-insert")
(define-auto-insert "\\.els" "emacs-lisp-mode/auto-insert.els")
(define-auto-insert "\\.clj" "clojure-mode/auto-insert")
(define-auto-insert "\\.lsp" "new-lispmode/auto-insert")
(define-auto-insert "\\.erl" "erlang-mode/auto-insert")
(define-auto-insert "\\.hs" "haskell-mode/auto-insert")
(define-auto-insert "\\.py" "python-mode/auto-insert")
(define-auto-insert "\\.js" "js-mode/auto-insert")
(define-auto-insert "\\.cs" "csharp-mode/auto-insert")

(defadvice auto-insert  (around yasnippet-expand-after-auto-insert activate) 
  "expand auto-inserted content as yasnippet templete,
  so that we could use yasnippet in autoinsert mode"
  (let ((is-new-file (and (not buffer-read-only) 
			  (or (eq this-command 'auto-insert) 
			      (and auto-insert 
				   (bobp) 
				   (eobp)))))) ad-do-it (let ((old-point-max (point-max))) 
					 (when is-new-file (goto-char old-point-max) 
					       (yas-expand-snippet 
						(buffer-substring-no-properties 
						 (point-min) 
						 (point-max))) 
					       (delete-region (point-min) old-point-max) 
					       (elisp-code-format)))))
;;;
(provide 'mod-complete)
;;; mod-complete.el ends here
