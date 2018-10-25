;; -*- lexical-binding: t -*-
;; mod-carp.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2018 damon-kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2018-10-25
;; Modify: 2018-10-25
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
(add-to-list 'load-path "~/your/path/to/Carp/emacs")

(require 'carp-mode)
(require 'inf-carp-mode)

(add-to-list 'auto-mode-alist '("\\.carp\\'" . carp-mode))

(require 'carp-flycheck)

(add-hook 'carp-mode-hook
          (lambda ()
            (flycheck-mode 1)))




(defun show-carp-repl() 
  (interactive) 
  (setq temp-carp-buffer-name (buffer-name (current-buffer))) 
  (ome-show-compilation "*ielm*") 
  (run-carp) 
  (switch-to-buffer-other-window temp-carp-buffer-name) 
  (ome-show-compilation "*ielm*" t))

(defun show-carp-workbuffer() 
  (interactive) 
  (switch-to-buffer-other-window temp-carp-buffer-name) 
  (delete-other-windows) 
  (show-carp-repl) 
  (switch-to-buffer-other-window temp-carp-buffer-name))

(define-key carp-mode-map (kbd "C-c C-z")  'show-carp-repl)
(define-key carp-mode-map (kbd "C-c C-z")  'show-carp-workbuffer)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-carp)
;; mod-carp.el ends here
