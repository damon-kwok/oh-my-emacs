;; -*- lexical-binding: t -*-
;; mod-go.el --- This is where you apply your OCD.
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
;; go-mode
(package-download 'go-mode)
;; (autoload 'go-mode "go-mode" nil t)
;; (package-download 'paredit)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; lsp-server
;; (add-hook 'go-mode-hook #'lsp)
(add-hook 'go-mode-hook
  (lambda ()
    ;; (internal-require 'paredit)
    ;; (enable-paredit-mode)
    ;; (define-key paredit-mode-map (kbd "M-;") 'ome-comment-or-uncomment-region-or-line)
    ;; (define-key paredit-mode-map (kbd "C-<left>") 'paredit-backward-slurp-sexp)
    ;; (define-key paredit-mode-map (kbd "C-<right>") 'paredit-forward-slurp-sexp)
    ;; (define-key paredit-mode-map (kbd "C-M-<left>") 'paredit-backward-barf-sexp)
    ;; (define-key paredit-mode-map (kbd "C-M-<right>") 'paredit-forward-barf-sexp)
    ;; (defun no-space-for-delimiter-p (endp delim)
      ;; (not (eq major-mode 'go-mode)))
    ;; (add-to-list 'paredit-space-for-delimiter-predicates 'no-space-for-delimiter-p)
    ;;
    (internal-require 'mod-lsp)
    (lsp)
    (add-hook 'before-save-hook 'gofmt-before-save)
    (setq indent-tabs-mode nil)
    (setq tab-width 4)

    (custom-set-faces
      '(company-preview
         ((t (:foreground "darkgray" :underline t))));;
      '(company-preview-common;;
         ((t (:inherit company-preview))));;
      '(company-tooltip;;
         ((t (:background "lightgray" :foreground "black"))));;
      '(company-tooltip-selection;;
         ((t (:background "steelblue" :foreground "white"))));;
      '(company-tooltip-common;;
         ((((type x)) (:inherit company-tooltip :weight bold));;
           (t (:inherit company-tooltip))));;
      '(company-tooltip-common-selection;;
         ((((type x)) (:inherit company-tooltip-selection :weight bold))
           (t (:inherit company-tooltip-selection)))));;

    (define-key go-mode-map (kbd "C-c C-f")  'gofmt)
    ))

;; `automenu:go'
(defun automenu--go-mode-menu ()
  '("0" "build" "run" "clean" "4" "5" "6" "7" "8" "9"))

(defun automenu--go-mode-func (index)
  (cond ((= 0 index)
          (message  "go menu:%d" index))
    ((= 1 index)
      (if (ome-project-file-exists-p "Makefile")
        (ome-project-run-command "make")
        (ome-project-command "go build")))
    ((= 2 index)
      ;; (ome-run-command (ome-project-dirname))
      (if (ome-project-file-exists-p "Makefile")
        (ome-project-run-command (concat (ome-project-root) "bin/" (ome-buf-dirname)))
        (ome-project-command (concat (ome-buf-dirpath) "/" (ome-buf-dirname)))
        ;;(ome-project-command (ome-project-dirname))
        ))
    ((= 3 index)
      (ome-run-command  "make clean"))
    ((= 4 index)
      (message  "go menu:%d" index))
    ((= 5 index)
      (message  "go menu:%d" index))
    ((= 6 index)
      (message  "go menu:%d" index))
    ((= 7 index)
      (message  "go menu:%d" index))
    ((= 8 index)
      (message  "go menu:%d" index))
    ((= 9 index)
      (message  "go menu:%d" index))
    (t (message  "go menu:%d" index))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-go)
;; mod-go.el ends here
