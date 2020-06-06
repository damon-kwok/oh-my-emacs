;; -*- lexical-binding: t -*-
;; mod-janet.el --- This is where you apply your OCD.
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
(package-download 'janet-mode)
(package-download-git "ijanet-mode" "https://github.com/SerialDev/ijanet-mode.git")
(package-download-git "inf-janet" "https://github.com/velkyel/inf-janet.git")

(add-to-list 'auto-mode-alist '("\\janet$" . janet-mode))
(add-hook 'janet-mode-hook ;;
  (lambda ()
    (internal-require 'ijanet)
    (define-key janet-mode-map (kbd "C-c C-k") #'ijanet-eval-buffer)
    (define-key janet-mode-map (kbd "C-c C-r") #'ijanet-eval-region)
    (define-key janet-mode-map (kbd "C-x C-e") #'ijanet-eval-line)
    (define-key janet-mode-map (kbd "C-c C-z") #'ijanet)

    (internal-require 'inf-janet)
    (inf-janet-minor-mode)))

(defun show-janet-repl()
  (interactive)
  (setq temp-janet-buffer-name (buffer-name (current-buffer)))
  (ome-show-compilation "*ijanet*")
  (ijanet)
  (switch-to-buffer-other-window temp-janet-buffer-name)
  (ome-show-compilation "*ijanet*" t))

(defun show-janet-workbuffer()
  (interactive)
  (switch-to-buffer-other-window temp-janet-buffer-name)
  (delete-other-windows)
  (show-janet-repl)
  (switch-to-buffer-other-window temp-janet-buffer-name))

;; `automenu:janet'
(defun automenu--janet-mode-menu ()
  '("REPL" "reload" "compile-buffer"))

(defun automenu--janet-mode-func (index)
  (cond ((= 0 index)
          (show-janet-repl))
    ((= 1 index)
      (ijanet-eval-buffer))
    ((= 2 index)
      (buffer-file-name))
    (t (message  "janet-mode menu:%d" index))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-janet)
;; mod-janet.el ends here
