;; -*- lexical-binding: t -*-
;; mod-ui-buffer.el --- This is where you apply your OCD.
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`buffer';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; 保持滚动时一直保持在屏幕中间
(defun hold-line-scroll-up()
  "Scroll the page with the cursor in the same line"
  (interactive)
  ;; move the cursor also
  (let ((tmp (current-column)))
    (scroll-down -1)
    (line-move-to-column tmp)
    (forward-line 1)))

(defun hold-line-scroll-down()
  "Scroll the page with the cursor in the same line"
  (interactive)
  ;; move the cursor also
  (let ((tmp (current-column)))
    (scroll-down 1)
    (line-move-to-column tmp)
    (forward-line -1)))

;; (global-set-key (kbd "C-n") 'hold-line-scroll-up)
;; (global-set-key (kbd "C-p") 'hold-line-scroll-down)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;`line-number'  `column-number' `fill-column';;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 'linum'


;; `display-line-numbers-mode'
(if (version<= "26.0.50" emacs-version )
  (progn
    (require 'display-line-numbers)
    (global-display-line-numbers-mode))
  (progn
    ;; (internal-require 'linum)
    ;; linum-mode
    (setq linum-mode t)
    (setq linum-format "%4d")
    (global-linum-mode)))

;;; `column'
(setq column-number-mode t)

;;; page width
;; (setq fill-column 100)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`cursor';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `mouse-avoidance-mode'
(mouse-avoidance-mode 'none) ;; turn it off
;; (mouse-avoidance-mode 'jump)  ;; jump away randomly when approached
;; (mouse-avoidance-mode 'banish) ;; jump to corner when typing
;; (mouse-avoidance-mode 'exile)  ;; jump to corner when approached
;; (mouse-avoidance-mode 'animate) ;; fru-fru
;; (mouse-avoidance-mode 'cat-and-mouse) ;; same
;; (mouse-avoidance-mode 'proteus)  ;; same + change the pointer shape

;;; set mouse `middle-key' paste pos (t :cursor pos  nil:mouse pos)
(setq mouse-yank-at-point nil)

;;; set cursor type: `line' or `bar'
;; (setq-default cursor-type 'bar);;

;;;  cursor blink
(blink-cursor-mode 1)

;;; when up/down move: if the cursor is 'end of line', keep it 'end of line'
(setq track-eol t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`mini-buffer';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; mini buffer auto resize (t:resize nil:don't resizec)
(setq resize-mini-windows t)

;;; recursive minibuffer (允许递归调用)
(setq enable-recursive-minibuffers t)

;;; max height
(setq max-mini-window-height 0.3)

;;; eldoc and paredit
(add-hook 'eval-expression-minibuffer-setup-hook #'eldoc-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'paredit-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`undo' && `redo';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; max delete history (undo)
(setq kill-ring-max 200)

(package-require 'undo-tree)
;; (package-download-curl "undo-tree-0.6.6" "undo-tree.el"
  ;; "https://raw.githubusercontent.com/emacs-lisp/undo-tree/master/undo-tree.el")
;; (internal-require 'undo-tree)
(global-undo-tree-mode)

(defun show-undo-tree()
  (interactive)
  (ome-show-compilation "*Messages*")
  (delete-other-windows)
  (undo-tree-visualize)
  (if (< (/ (frame-height) 3)
        (window-height))
    (shrink-window (/ (window-height) 2))))

(global-set-key (kbd "C-x u") 'show-undo-tree)
(define-key undo-tree-map (kbd "C-x u")
  '(lambda ()
     (interactive)
     (undo-tree-visualize)
     (undo-tree-visualize-undo)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-ui-buffer)
;; mod-ui-buffer.el ends here
