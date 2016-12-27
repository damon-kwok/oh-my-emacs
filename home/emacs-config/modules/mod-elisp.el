;;; emacs-settings.el --- gww

;; Copyright (C) 2013  gww

;; Author: gww <gww@192.168.0.171>
;; Keywords: lisp

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:
(require 'mod-package)
;;

(package-require-curl "elisp-format" "elisp-format.el" "https://www.emacswiki.org/emacs/download/elisp-format.el")
(require 'elisp-format)

;;(package-require 'paredit)
;;(package-require 'rainbow-delimiters)
;;(global-rainbow-delimiters-mode)
;;(require 'paredit)
;;(require 'rainbow-delimiters)
;;(rainbow-delimiters-mode t)

;;(add-hook 'emacs-lisp-mode-hook 'paredit-mode)
;;(add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)
;;(add-hook 'emacs-lisp-mode-hook 'highlight-parentheses-mode)

;;(add-to-list 'auto-mode-alist '("*scratch*" . emacs-lisp-mode))

;; (package-require 'lispy)
;; (require 'lispy)
;; (add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1)))

(defun elisp-code-format() 
  (interactive) 
  (elisp-format-buffer)
  ;;(setq old-line (line-number-at-pos))
  ;;(goto-char (point-min))
  ;;(if (eq system-type 'windows-nt)
  ;;    (replace-string "
  ;;(goto-line old-line)
  (save-current-buffer)
  ;;(keyboard-quit)
  (message "format complete!"))

(defun show-elisp-repl() 
  (interactive) 
  (setq temp-buffer-name (buffer-name (current-buffer))) 
  (m-show-compilation "*ielm*") 
  (ielm) 
  (switch-to-buffer-other-window temp-buffer-name) 
  (m-show-compilation "*ielm*" t))

(defun show-elisp-workbuffer() 
  (interactive) 
  (switch-to-buffer-other-window temp-buffer-name) 
  (delete-other-windows) 
  (show-elisp-repl) 
  (switch-to-buffer-other-window temp-buffer-name))


(defun compile-current-buffer()
  (interactive)
  (save-buffer)
  (delete-other-windows)
  (byte-compile-file (buffer-file-name))
  (delete-file (concat (buffer-file-name) "c"))

  ;;(m-show-compilation "*Warnings*")
  (m-show-compilation "*Compile-Log*"))

(require 'ielm)
(define-key ielm-map (kbd "C-c C-z") 'show-elisp-workbuffer)

(define-key emacs-lisp-mode-map (kbd "C-c C-z")  'show-elisp-repl)
(define-key emacs-lisp-mode-map (kbd "C-c C-c")  'compile-current-buffer)
(define-key emacs-lisp-mode-map (kbd "C-c C-k")  'eval-buffer)
(define-key emacs-lisp-mode-map (kbd "C-M-\\")  'elisp-code-format)

;;
(provide 'mod-elisp)
;;; emacs-settings.el ends here