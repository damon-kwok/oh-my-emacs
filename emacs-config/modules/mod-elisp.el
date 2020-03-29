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
(package-download 'elisp-slime-nav)
;; (package-download 'el-spice)
(package-download 'persistent-scratch)
(package-download 'highlight-defined)
;; (package-download 'suggest)
;;(package-download 'rainbow-delimiters)
(package-download 'macrostep)
(package-download 'elisp-format)
;; (package-download-curl "elisp-format" "elisp-format.el" "https://www.emacswiki.org/emacs/download/elisp-format.el")
;;
(add-to-list 'auto-mode-alist '("\\.el\\.els\\.els.el\\'" . emacs-lisp-mode))


;;
;; (setq initial-major-mode 'emacs-lisp-mode)
;; (add-to-list 'auto-mode-alist '("*scratch*" . emacs-lisp-mode))
(setq initial-scratch-message "\
;;                          !!!Oh My Emacs!!!
;; This buffer is for notes you don't want to save, and for Elisp code.
;; If you want to create a file, visit that file with C-x C-f,
;; then enter the text in that file's own buffer.
")
;;

(add-hook 'emacs-lisp-mode-hook ;;
  (lambda ()
    (internal-require 'ielm)
    (define-key ielm-map (kbd "C-c C-z") 'show-elisp-workbuffer)
    ;;
    (internal-require 'elisp-slime-nav)
    (elisp-slime-nav-mode)
    (dolist (hook '(ielm-mode-hook lisp-interaction-mode-hook))
      (internal-require 'elisp-slime-nav)
      (add-hook hook 'elisp-slime-nav-mode))
    ;;
    (define-key emacs-lisp-mode-map (kbd "C-M-\\")
      (lambda()
        (interactive)
        (internal-require 'elisp-format)
        (elisp-code-format)))
    (define-key emacs-lisp-mode-map (kbd "C-c C-f")
      (lambda()
        (interactive)
        (internal-require 'elisp-format)
        (elisp-code-format)))
    ;;
    ;; (internal-require 'el-spice)
    ;; (el-spice-mode)
    ;; (dolist (hook '(ielm-mode-hook lisp-interaction-mode-hook))
    ;; (add-hook hook 'el-spice-mode))
    ;;
    ;; `highlight-defined'
    ;;(internal-require 'highlight-defined)
    ;;(highlight-defined-mode)
    ;;
    ;; scratch settings
    ;;(internal-require 'persistent-scratch)
    ;;
    ;; (package-require 'suggest)
    ;;
    ;;(internal-require 'rainbow-delimiters)
    ;;(global-rainbow-delimiters-mode)
    ;;(rainbow-delimiters-mode t)
    ;;(add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)
    ;;(add-hook 'emacs-lisp-mode-hook 'highlight-parentheses-mode)
    ;;
    ;;(define-key el-spice-mode-map (kbd "C-c C-z")  'show-elisp-repl)
    (define-key emacs-lisp-mode-map (kbd "C-c C-z")  'show-elisp-repl)
    (define-key emacs-lisp-mode-map (kbd "C-c C-c") 'compile-current-buffer)
    ;; (define-key emacs-lisp-mode-map (kbd "C-c C-k")  'eval-buffer)
    ;;
    ;; (package-require 'elisp-refs)
    ;; (define-key emacs-lisp-mode-map (kbd "M-.")  'elisp-refs-function)
    ;;
    (internal-require 'mod-sexp)
    (ome-sexp-lang-init)))

(defun elisp-code-format()
  (interactive)
  (elisp-format-buffer)
  (save-current-buffer)
  (message "format complete!"))




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
