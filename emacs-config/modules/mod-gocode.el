;; -*- lexical-binding: t -*-
;; mod-gocode.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2018 damon-kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2018-08-31
;; Modify: 2018-08-31
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
;; `gomode'
(package-require 'go-mode)
(require 'go-mode)
;; (autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

;; `company'
(package-require 'company)
(require 'company)

;; company-go
;;(add-to-list 'load-path (concat (getenv "GOPATH") "/src/github.com/mdempsky/gocode/emacs-company"))
(package-require 'company-go)
(require 'company-go)

(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
(setq company-echo-delay 0)                          ; remove annoying blinking
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

;;https://coderwall.com/p/kpp6ta/nice-emacs-go-mode-indenting-and-autoformat
(add-hook 'go-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)
                          (add-hook 'before-save-hook 'gofmt-before-save)
                          (setq indent-tabs-mode t)
                          (setq tab-width 4)))

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
(provide 'mod-gocode)
;; mod-gocode.el ends here
