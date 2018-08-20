;; -*- lexical-binding: t -*-
;; mod-csharp.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2018 damon-kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2018-08-05
;; Modify: 2018-08-05
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
(package-require 'omnisharp)
(require 'omnisharp)

;; (add-hook 'csharp-mode-hook 'omnisharp-mode)

;; `auto-complete'
;; (eval-after-load
;; 'company
;; '(add-to-list 'company-backends 'company-omnisharp))

;; (add-hook 'csharp-mode-hook #'company-mode)

;; `flycheck'
;; (add-hook 'csharp-mode-hook #'flycheck-mode)

(eval-after-load 'company '(add-to-list 'company-backends #'company-omnisharp))

;; `setup'
(defun my-csharp-mode-setup () 
  (omnisharp-mode) 
  (company-mode) 
  (flycheck-mode)
  (setq indent-tabs-mode nil) 
  (setq c-syntactic-indentation t) 
  (c-set-style "ellemtel") 
  (setq c-basic-offset 4) 
  (setq truncate-lines t) 
  (setq tab-width 4) 
  (setq evil-shift-width 4)

                                        ;csharp-mode README.md recommends this too
                                        ;(electric-pair-mode 1)       ;; Emacs 24
                                        ;(electric-pair-local-mode 1) ;; Emacs 25
  (local-set-key (kbd "C-c r r") 'omnisharp-run-code-action-refactoring) 
  (local-set-key (kbd "C-c C-c") 'recompile))

(add-hook 'csharp-mode-hook 'my-csharp-mode-setup t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-csharp)
;; mod-csharp.el ends here
