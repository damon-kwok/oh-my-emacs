;;; emacs-settings.el --- damon-kwok
;;
;; Copyright (C) 2013  damon-kwok
;;
;; Author: damon-kwok <damon-kwok@outlook.com>
;; Keywords: lisp
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
;; Commentary:
;;
;; Code:
(require 'mod-package)
;;
(require 'ielm)
;;
(add-to-list 'auto-mode-alist '("\\.els\\'" . emacs-lisp-mode))
(add-to-list 'auto-mode-alist '("\\.els.el\\'" . emacs-lisp-mode))
;;
(package-require 'elisp-slime-nav)
(require 'elisp-slime-nav)
(dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook)) 
  (add-hook hook 'elisp-slime-nav-mode))
;;
;; (package-require 'el-spice)
;; (require 'el-spice)
;; (dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook lisp-interaction-mode-hook))
;; (add-hook hook 'el-spice-mode))


;; scratch settings
(package-require 'persistent-scratch)
(require 'persistent-scratch)
;;
(setq initial-major-mode 'emacs-lisp-mode)
;; (add-to-list 'auto-mode-alist '("*scratch*" . emacs-lisp-mode))
(setq initial-scratch-message "\
;;                          !!!Oh My Emacs!!!
;; This buffer is for notes you don't want to save, and for Elisp code.
;; If you want to create a file, visit that file with C-x C-f,
;; then enter the text in that file's own buffer.

")
;;


;; `highlight-defined'
(package-require 'highlight-defined)
(require 'highlight-defined)
(add-hook 'emacs-lisp-mode-hook 'highlight-defined-mode)
;;


;; (package-require 'suggest)
;; (require 'suggest)


;;(package-require 'rainbow-delimiters)
;;(global-rainbow-delimiters-mode)
;;(require 'rainbow-delimiters)
;;(rainbow-delimiters-mode t)

;;(add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)
;;(add-hook 'emacs-lisp-mode-hook 'highlight-parentheses-mode)


;;


;; (package-require 'lispy)
;; (require 'lispy)
;; (add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1)))


;; (package-require-curl "elisp-format" "elisp-format.el"
;; "https://www.emacswiki.org/emacs/download/elisp-format.el")
(package-require 'elisp-format)
(require 'elisp-format)

(defun elisp-code-format() 
  (interactive) 
  (elisp-format-buffer) 
  (save-current-buffer) 
  (message "format complete!"))

(define-key emacs-lisp-mode-map (kbd "C-M-\\")  'elisp-code-format)
(define-key emacs-lisp-mode-map (kbd "C-c C-f")  'elisp-code-format)


(defun show-elisp-repl() 
  (interactive) 
  (setq temp-elisp-buffer-name (buffer-name (current-buffer))) 
  (ome-show-compilation "*ielm*") 
  (ielm) 
  (switch-to-buffer-other-window temp-elisp-buffer-name) 
  (ome-show-compilation "*ielm*" t))

(defun show-elisp-workbuffer() 
  (interactive) 
  (switch-to-buffer-other-window temp-elisp-buffer-name) 
  (delete-other-windows) 
  (show-elisp-repl) 
  (switch-to-buffer-other-window temp-elisp-buffer-name))

;;
(defun compile-current-buffer() 
  (interactive) 
  (kill-buffer (get-buffer "*Compile-Log*")) 
  (save-buffer) 
  (delete-other-windows) 
  (byte-compile-file (buffer-file-name)) 
  (delete-file (concat (buffer-file-name) "c"))
  ;;(ome-show-compilation "*Warnings*")
  (ome-show-compilation "*Compile-Log*"))

(define-key ielm-map (kbd "C-c C-z") 'show-elisp-workbuffer)

(define-key el-spice-mode-map (kbd "C-c C-z")  'show-elisp-repl)
(define-key emacs-lisp-mode-map (kbd "C-c C-z")  'show-elisp-repl)
(define-key emacs-lisp-mode-map (kbd "C-c C-c")  'compile-current-buffer)
;; (define-key emacs-lisp-mode-map (kbd "C-c C-k")  'eval-buffer)


;; (package-require 'elisp-refs)
;; (require 'elisp-refs)
;; (define-key emacs-lisp-mode-map (kbd "M-.")  'elisp-refs-function)

(package-require 'macrostep)
(require 'macrostep)
(define-key emacs-lisp-mode-map (kbd "C-c e") 'macrostep-expand)
;;

;; `automenu'
(defun automenu--emacs-lisp-mode-menu () 
  '("REPL" "reload" "compile-buffer"))
;; (emacs-lisp-mode-menu)
;; (macroexpand '("REPL" "compile-buffer" (concat "reload:" (buffer-name))))
(defun automenu--emacs-lisp-mode-func (index) 
  (cond ((= 0 index) 
         (show-elisp-repl)) 
        ((= 1 index) 
         (load (buffer-file-name))) 
        ((= 2 index) 
         (compile-current-buffer)) 
        (t (message  "emacs-lisp-mode menu:%d" index))))


;;
(provide 'mod-elisp)
;; emacs-settings.el ends here
