;; -*- lexical-binding: t -*-
;; mod-js.el --- This is where you apply your OCD.
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
(package-download 'js2-mode)
(package-download 'skewer-mode)
(package-download 'js2-refactor)
(package-download 'nodejs-repl)

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;;
;; (add-hook 'js-mode-hook #'lsp)
;; (add-hook 'typescript-mode-hook #'lsp) ;; for typescript support
;; (add-hook 'js2-mode-hook #'lsp)        ;; for js2-mode support
;; (add-hook 'js3-mode-hook #'lsp)        ;; for js3-mode support
;; (add-hook 'rjsx-mode #'lsp)            ;; for rjsx-mode support
;; (add-hook 'css-mode #'lsp)             ;; for css-mode support
;; (add-hook 'html-mode #'lsp)            ;; for html-mode support

;; (package-require 'vue-mode)
;; (add-hook 'vue-mode #'lsp)             ;; for vue-mode support

(defun my-company-transformer (candidates)
  (let ((completion-ignore-case t))
    (all-completions (company-grab-symbol) candidates)))

(add-hook 'js2-mode-hook (lambda ()
                           ;; `nodejs-repl'
                           (internal-require 'nodejs-repl)
                           (define-key js-mode-map (kbd "C-x C-e")
                             'nodejs-repl-send-last-expression)
                           (define-key js-mode-map (kbd "C-c C-j") 'nodejs-repl-send-line)
                           (define-key js-mode-map (kbd "C-c C-r") 'nodejs-repl-send-region)
                           (define-key js-mode-map (kbd "C-c C-l") 'nodejs-repl-load-file)
                           (define-key js-mode-map (kbd "C-c C-z") 'nodejs-repl-switch-to-repl)
                           ;; `company'
                           (make-local-variable 'company-transformers)
                           (push 'my-company-transformer company-transformers)
                           ;;
                           ;; `js2-refactor'
                           (internal-require 'js2-refactor)
                           (setq js2-skip-preprocessor-directives t)
                           (js2-refactor-mode)
                           (js2r-add-keybindings-with-prefix "C-c C-m")
                           ;; eg. extract function with `C-c C-m ef`.
                           (js2r-add-keybindings-with-modifier "C-s-")
                           ;; eg. extract function with `C-s-e C-s-f`.
                           (define-key js2-refactor-mode-map (kbd "C-c C-e C-f")
                             'js2r-extract-function)
                           ;;
                           ;; `skewer-mode'
                           (internal-require 'skewer-mode)
                           (skewer-mode)
                           ;; `indium'
                           ;; (package-require 'indium)
                           ;;
                           (internal-require 'mod-lsp)
                           (lsp)))


;; `automenu:js'
(defun automenu--js-mode-menu ()
  '("0" "npm start" "2" "3" "4" "5" "6" "7" "8" "9"))

(defun automenu--js-mode-func (index)
  (cond ((= 0 index)
          (message  "js menu:%d" index))
    ((= 1 index)
      (ome-run-command "bash -c \"npm start\""))
    ((= 2 index)
      (message  "js menu:%d" index))
    ((= 3 index)
      (message  "js menu:%d" index))
    ((= 4 index)
      (message  "js menu:%d" index))
    ((= 5 index)
      (message  "js menu:%d" index))
    ((= 6 index)
      (message  "js menu:%d" index))
    ((= 7 index)
      (message  "js menu:%d" index))
    ((= 8 index)
      (message  "js menu:%d" index))
    ((= 9 index)
      (message  "js menu:%d" index))
    (t (message  "js menu:%d" index))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-js)
;; mod-js.el ends here
