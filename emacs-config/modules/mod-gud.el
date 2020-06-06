;; -*- lexical-binding: t -*-
;; mod-gud.el --- This is where you apply your OCD.
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
(package-require 'realgud)
(internal-require 'gud)
;;;; set gdb multi-windows when open
(setq gdb-many-windows t)

;;;; customize the gdb multi-windows
;; (defadvice gdb-setup-windows (after my-setup-gdb-windows activate)
;;   "my gdb UI"
;;   (gdb-get-buffer-create 'gdb-stack-buffer)
;;   (set-window-dedicated-p (selected-window) nil)
;;   (switch-to-buffer gud-comint-buffer)
;;   (delete-other-windows)
;;   (let ((win0 (selected-window))
;; 		(win1 (split-window nil nil 'left))	;; code and output
;;         (win2 (split-window-below (/ (* (window-height) 3) 4)))	;; stack
;;         )
;; 	(select-window win2)
;; 	(gdb-set-window-buffer (gdb-stack-buffer-name))
;; 	(select-window win1)
;; 	(set-window-buffer win1 (if gud-last-last-frame (gud-find-file (car gud-last-last-frame))
;; 							  (if gdb-main-file (gud-find-file gdb-main-file)
;; 								;; Put buffer list in window if we
;; 								;; can't find a source file.
;; 								(list-buffers-noselect))))
;; 	(setq gdb-source-window (selected-window))
;; 	(let ((win3 (split-window nil (/ (* (window-height) 3) 4)))) ;; io
;;       (gdb-set-window-buffer (gdb-get-buffer-create 'gdb-inferior-io) nil win3))
;; 	(select-window win0)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-gud)
;; mod-gud.el ends here
