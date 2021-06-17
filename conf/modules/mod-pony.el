;; -*- lexical-binding: t -*-
;; mod-pony.el --- This is where you apply your OCD.
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
(package-download 'ponylang-mode)
(package-download 'flycheck-pony)
(package-download 'pony-snippets)
;; (package-download-git "pony-snippets" "https://github.com/damon-kwok/pony-snippets.git")
;; (package-download 'smartparens)
(package-download 'paredit)
(add-to-list 'auto-mode-alist '("\\.pony$" . ponylang-mode))

(add-hook 'ponylang-mode-hook ;;
  (lambda ()
    (require 'ponylang-mode)
    ;; (set-variable 'indent-tabs-mode nil)
    ;; (set-variable 'tab-width 2)
    ;;
    ;; (require 'smartparens-config)
    ;; (smartparens-mode)
    (substitute-key-definition 'ponylang-menu nil ponylang-mode-map)
    (define-key ponylang-mode-map (kbd "<f6>")  'ponylang-menu)
    (setq ponylang-banner "
             _|\\ _/|_,
           ,((\\\\``-\\\\\\\\_
         ,(())      `))\\
       ,(()))       ,_ \\
      ((())'   |        \\
      )))))     >.__     \\
      ((('     /    `-. .c|
              /        `-`'")
    ;;
    (internal-require 'helm-xref)
    ;;
    ;; (internal-require 'paredit)
    ;; (enable-paredit-mode)
    ;; (define-key paredit-mode-map (kbd "M-;") 'ome-comment-or-uncomment-region-or-line)
    ;; (define-key paredit-mode-map (kbd "C-<left>") 'paredit-backward-slurp-sexp)
    ;; (define-key paredit-mode-map (kbd "C-<right>") 'paredit-forward-slurp-sexp)
    ;; (define-key paredit-mode-map (kbd "C-M-<left>") 'paredit-backward-barf-sexp)
    ;; (define-key paredit-mode-map (kbd "C-M-<right>") 'paredit-forward-barf-sexp)
    ;; (defun no-space-for-delimiter-p (endp delim)
      ;; (not (eq major-mode 'ponylang-mode)))
    ;; (add-to-list 'paredit-space-for-delimiter-predicates 'no-space-for-delimiter-p)
    ;;
    (internal-require 'flycheck-pony)
    ;;
    (internal-require 'pony-snippets)))

;; `automenu:ponylang'
(defun automenu--ponylang-mode-menu ()
  '("0" "build" "run" "clean" "4" "5" "6" "7" "8" "9"))

(defun automenu--ponylang-mode-func (index)
  (cond;;
    ((= 0 index)
      (message  "ponylang menu:%d" index))
    ((= 1 index)
      (ponylang-project-build))
    ((= 2 index)
      (ponylang-project-run))
    ((= 3 index)
      (ponylang-project-clean))
    ((= 4 index)
      (message  "ponylang menu:%d" index))
    ((= 5 index)
      (message  "ponylang menu:%d" index))
    ((= 6 index)
      (message  "ponylang menu:%d" index))
    ((= 7 index)
      (message  "ponylang menu:%d" index))
    ((= 8 index)
      (message  "ponylang menu:%d" index))
    ((= 9 index)
      (message  "ponylang menu:%d" index))
    (t (message  "ponylang menu:%d" index))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-pony)
;; mod-pony.el ends here
