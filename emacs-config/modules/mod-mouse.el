;; -*- lexical-binding: t -*-
;; mod-mouse.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2015-2017 damon-kwok
;;
;; Author: Wuyouwofang <damon-kwok@outlook.com>
;; Create: 2017-01-03
;; Modify: 2017-01-03
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
;; along with this program.  If not, see <http:;;www.gnu.org/licenses/>.
;;
;; Code:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'mod-package)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `disable-mouse'
;; (global-set-key [mouse-1] nil)
;; (global-set-key [mouse-2] nil)
;; (global-set-key [mouse-3] nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `disable-mouse-mode'
(define-minor-mode disable-mouse-mode "A minor-mode that disables all mouse keybinds." 
  :global t 
  :lighter " :mouse:" 
  :keymap (make-sparse-keymap))

(dolist (type '(mouse down-mouse drag-mouse double-mouse triple-mouse)) 
  (dolist (prefix '("" C- M- S- M-S- C-M- C-S- C-M-S-))
    ;; Yes, I actually HAD to go up to 7 here.
    (dotimes (n 7) 
      (let ((k (format "%s%s-%s" prefix type n))) 
        (define-key disable-mouse-mode-map (vector (intern k)) #'ignore)))))

(disable-mouse-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-mouse)
;; mod-mouse.el ends here
