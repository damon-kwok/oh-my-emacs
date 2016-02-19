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
;;; `yasnippet'
(package-require 'yasnippet)
(require 'yasnippet)
;; (setq yas-snippet-dirs '(yas-installed-snippets-dir (expand-file-name "~/../config/templates/snippets/")))
;; (setq yas-snippet-dirs (expand-file-name "~/../config/templates/snippets/"))
(add-to-list 'yas-snippet-dirs (expand-file-name "~/../config/templates/snippets/"))
(yas-global-mode 1)

(global-set-key (kbd "C-x y a") 
		'(lambda() 
		   (interactive) 
		   (find-file (concat "~/../config/templates/snippets/" (symbol-name major-mode)
				      "/auto-insert"))))

(global-set-key (kbd "C-x y f") 
		'(lambda(filename) 
		   (interactive "sEnter snippet file name:")
		   ;;(interactive (concat "sEnter yas file name(" (symbol-name major-mode) "):"))
		   (find-file (concat "~/../config/templates/snippets/" (symbol-name major-mode)"/"
				      filename))))

;;(define-key yas-minor-mode-map (kbd "TAB") nil)
;;(define-key yas-minor-mode-map [backtab] 'yas-expand)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `auto-complete'
(package-require 'auto-complete)
(require 'auto-complete)
(require 'auto-complete-config)

;;; `pos-tip' plus
(package-require 'pos-tip)
(require 'pos-tip)
(setq ac-quick-help-prefer-pos-tip t)

;;; `ac-default' setting
(ac-config-default)
(auto-complete-mode 1)

;; (define-key ac-complete-mode-map (kbd "TAB") nil)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)
(define-key ac-complete-mode-map (kbd "SPC") 'ac-complete)

;; (defface ac-yasnippet-candidate-face
;;   '((t (:background "sandybrown" :foreground "black")))
;;   "Face for yasnippet candidate.")
 
;; (defface ac-yasnippet-selection-face
;;   '((t (:background "coral3" :foreground "white")))
;;   "Face for the yasnippet selected candidate.")
 
;; (defvar ac-source-yasnippet
;;   '((candidates . ac-yasnippet-candidate)
;;     (action . yas/expand)
;;     (candidate-face . ac-yasnippet-candidate-face)
;;     (selection-face . ac-yasnippet-selection-face))
;;   "Source for Yasnippet.")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `company'
;; (package-require 'company)
;; (require 'company)
;; (add-hook 'after-init-hook 'global-company-mode)

;; (global-set-key (kbd "<M-/>") 'company-complete)
;; (global-set-key (kbd "<C-M-i>") 'company-complete)

;; (define-key company-active-map (kbd "C-n")  'company-select-next)
;; (define-key company-active-map (kbd "C-p")  'company-select-previous)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `auto-insert-mode'
(setq-default auto-insert-directory "~/../config/templates/snippets/")
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
