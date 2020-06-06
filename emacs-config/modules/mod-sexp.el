;; -*- lexical-binding: t -*-
;; mod-sexp.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2020 Damon Kwok
;;
;; Author: damon <damon-kwok@outlook.com>
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
(package-download 'rainbow-mode)
(package-download 'rainbow-delimiters)
(package-download 'persistent-scratch)
(package-download 'highlight-defined)
(package-download 'paredit)
(package-download 'macrostep)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `rainbow-mode'
;; (package-require 'rainbow-mode)
;; (define-globalized-minor-mode global-rainbow-mode rainbow-mode
;; (lambda ()
;; (rainbow-mode 1)))
;; (global-rainbow-mode t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `highlight-parentheses'
;; (package-require 'highlight-parentheses)

;; (defcustom hl-paren-colors
;;   '("firebrick1" "IndianRed1" "IndianRed3" "IndianRed4")

;; (setq hl-paren-colors `("DeepPink" "SpringGreen" "yellow" "cyan" "HotPink" "green" "red" "DeepSkyBlue" "violet" "turquoise" "orange" "blue")) ;;turquoise orange DarkGreen LightGreen SpringGreen chartreuse LightGoldenrod navy

;; (define-globalized-minor-mode global-highlight-parentheses-mode highlight-parentheses-mode
;; (lambda ()
;; (highlight-parentheses-mode t)))
;; (global-highlight-parentheses-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `rainbow-delimiters'
;; (add-hook 'lisp-mode-hook #'rainbow-delimiters-mode)
;; (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
;; (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  '(rainbow-delimiters-depth-1-face ((t
                                       (:foreground "white"))))
  '(rainbow-delimiters-depth-2-face ((t
                                       (:foreground "LightGreen"))))
  '(rainbow-delimiters-depth-3-face ((t
                                       (:foreground "SlateGray"))))
  '(rainbow-delimiters-depth-4-face ((t
                                       (:foreground "khaki"))))
  '(rainbow-delimiters-depth-5-face ((t
                                       (:foreground "HotPink2"))))
  '(rainbow-delimiters-depth-6-face ((t
                                       (:foreground "DarkGreen"))))
  '(rainbow-delimiters-depth-7-face ((t
                                       (:foreground "DodgerBlue"))))
  '(rainbow-delimiters-depth-8-face ((t
                                       (:foreground "orange"))))
  '(rainbow-delimiters-depth-9-face ((t
                                       (:foreground "brown")))))
;;
;;
;; (use-package smartparens-config
;; :ensure smartparens
;; :config
;; (progn
;; (show-smartparens-global-mode t)))

;; (add-hook 'prog-mode-hook 'turn-on-smartparens-strict-mode)
;; (add-hook 'markdown-mode-hook 'turn-on-smartparens-strict-mode)

;; (defmacro def-pairs (pairs)
;; `(progn
;; ,@(loop for (key . val) in pairs
;; collect
;; `(defun ,(read (concat
;; "wrap-with-"
;; (prin1-to-string key)
;; "s"))
;; (&optional arg)
;; (interactive "p")
;; (sp-wrap-with-pair ,val)))))

;; (def-pairs ((paren . "(")
;; (bracket . "[")
;; (brace . "{")
;; (single-quote . "'")
;; (double-quote . "\"")
;; (back-quote . "`")))

;;
(defun switch-to-smart-scratch-buffer ()
  "Toggle between *scratch* buffer and the current buffer.
     If the *scratch* buffer does not exist, create it."
  (interactive)
  (let ((scratch-buffer-name  "*scratch*")
         (prev-major-mode major-mode))
    (if (equal (buffer-name (current-buffer)) scratch-buffer-name)
      (switch-to-buffer (other-buffer))
      (with-current-buffer (switch-to-buffer  scratch-buffer-name)
        (when (functionp prev-major-mode)
          (funcall prev-major-mode ))
        (when (equal major-mode 'fundamental-mode )
          (emacs-lisp-mode))
        (goto-char (point-max))))))

(defun switch-to-scratch-buffer ()
  "Toggle between *scratch* buffer and the current buffer.
     If the *scratch* buffer does not exist, create it."
  (interactive)
  (let ((scratch-buffer-name  "*scratch*")
         (prev-major-mode major-mode))
    (if (equal (buffer-name (current-buffer)) scratch-buffer-name)
      (switch-to-buffer (other-buffer))
      (with-current-buffer (switch-to-buffer  scratch-buffer-name)
        (emacs-lisp-mode)
        (goto-char (point-max))))))

;;
(defun ome-sexp-lang-init()
  (interactive)
  (message "ome-sexp-lang-init with buffer:%s mode:%s" (buffer-name) (symbol-name major-mode))
  ;; `rainbow'
  (internal-require 'rainbow-mode)
  (rainbow-mode)
  ;; `rainbow-delimiters'
  (internal-require 'rainbow-delimiters)
  (rainbow-delimiters-mode t)
  ;; `highlight-defined'
  (internal-require 'highlight-defined)
  (highlight-defined-mode)
  ;;
  ;; scratch settings
  (internal-require 'persistent-scratch)
  ;;
  ;; (package-require 'lispy)
  ;; (add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1))
  ;;
  (internal-require 'paredit)
  (enable-paredit-mode)
  (define-key paredit-mode-map (kbd "M-;") 'ome-comment-or-uncomment-region-or-line)
  (define-key paredit-mode-map (kbd "C-<left>") 'paredit-backward-slurp-sexp)
  (define-key paredit-mode-map (kbd "C-<right>") 'paredit-forward-slurp-sexp)
  (define-key paredit-mode-map (kbd "C-M-<left>") 'paredit-backward-barf-sexp)
  (define-key paredit-mode-map (kbd "C-M-<right>") 'paredit-forward-barf-sexp)
  ;;
  (internal-require 'macrostep)
  (define-key paredit-mode-map (kbd "C-c e") 'macrostep-expand))

(add-hook 'eval-expression-minibuffer-setup-hook #'ome-sexp-lang-init)
(add-hook 'lisp-interaction-mode-hook #'ome-sexp-lang-init)
(add-hook 'emacs-lisp-mode-hook      #'ome-sexp-lang-init)
(add-hook 'ielm-mode-hook             #'ome-sexp-lang-init)
;; (add-hook 'inferior-emacs-mode-hook   #'ome-sexp-lang-init)
(add-hook 'lisp-mode-hook             #'ome-sexp-lang-init)
(add-hook 'common-lisp-mode-hook      #'ome-sexp-lang-init)
(add-hook 'scheme-mode-hook           #'ome-sexp-lang-init)
(add-hook 'racket-mode-hook           #'ome-sexp-lang-init)
(add-hook 'hy-mode-hook               #'ome-sexp-lang-init)
(add-hook 'newlisp-mode-hook          #'ome-sexp-lang-init)
(add-hook 'hy-mode-hook               #'ome-sexp-lang-init)
(add-hook 'carp-mode-hook             #'ome-sexp-lang-init)
(add-hook 'slime-mode-hook            #'ome-sexp-lang-init)
(add-hook 'cider-mode-hook            #'ome-sexp-lang-init)
(add-hook 'cider-repl-mode-hook       #'ome-sexp-lang-init)
(add-hook 'clojure-mode-hook          #'ome-sexp-lang-init)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-sexp)
;; mod-sexp.el ends here
