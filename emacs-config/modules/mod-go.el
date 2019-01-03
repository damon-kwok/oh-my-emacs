;; -*- lexical-binding: t -*-
;; mod-go.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2018 damon-kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2018-05-22
;; Modify: 2018-05-22
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
(package-require 'go-mode)
(require 'go-mode)
;; (autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; lsp-server
(require 'mod-lsp)
;; (add-hook 'go-mode-hook #'lsp)
(add-hook 'go-mode-hook (lambda ()
                          (lsp)
                          (add-hook 'before-save-hook 'gofmt-before-save)
                          (setq indent-tabs-mode nil)
                          (setq tab-width 4)))

;; (package-require 'lsp-go)
;; (require 'lsp-go)

;; (defun company-lsp--go-completion-snippet (item) 
;;   "Function providing snippet with the go language.
;; It parses the function's signature in ITEM (a CompletionItem)
;; to expand its arguments."
;;   ;; (yas-expand-snippet item)
;;   (message "msg:%s" item))

;; (add-hook 'go-mode-hook (lambda ()
;;                           (lsp-go-enable)
;;                           (add-to-list 'company-lsp--snippet-functions '("go" . company-lsp--go-completion-snippet))
;;                           (add-hook 'before-save-hook 'gofmt-before-save)
;;                           (setq indent-tabs-mode nil)
;;                           (setq tab-width 4)))

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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-go)
;; mod-go.el ends here
