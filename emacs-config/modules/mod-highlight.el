;; -*- lexical-binding: t -*-
;; mod-highlight.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2018 damon-kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2018-08-08
;; Modify: 2018-08-08
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (package-require 'highlight-parentheses)
;; (require 'highlight-parentheses)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(package-require 'symbol-overlay)
(require 'symbol-overlay)

(define-globalized-minor-mode global-symbol-overlay-mode symbol-overlay-mode 
  (lambda () 
	(symbol-overlay-mode 1)))

(global-symbol-overlay-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; `hl-todo
;; (package-require 'hl-todo)
;; (require 'hl-todo)

;; (define-key hl-todo-mode-map (kbd "C-c p") 'hl-todo-previous)
;; (define-key hl-todo-mode-map (kbd "C-c n") 'hl-todo-next)
;; (define-key hl-todo-mode-map (kbd "C-c o") 'hl-todo-occur)
;; (global-hl-todo-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; `highlight-indent-guides'
(package-require 'highlight-indent-guides)
(require 'highlight-indent-guides)
(setq highlight-indent-guides-method 'character)
(setq highlight-indent-guides-character ?\|)
;; (setq highlight-indent-guides-character "|")

;; (define-globalized-minor-mode global-highlight-indent-guides-mode highlight-indent-guides-mode 
  ;; (lambda () 
	;; (highlight-indent-guides-mode 1)))

(define-globalized-minor-mode global-highlight-indent-guides-mode highlight-indent-guides-mode
  (lambda ()
	(if (and (not (string-match "^\*.*\*$" (buffer-name)))
			 (not (eq major-mode 'dired-mode))
			 (not (eq major-mode 'speedbar-mode)))
		(highlight-indent-guides-mode 1))))

(global-highlight-indent-guides-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `fci-mode'
(package-require 'fill-column-indicator)
(require 'fill-column-indicator)
(setq whitespace-style '(face trailing))
(setq fci-rule-column 80)
(setq fci-handle-truncate-lines nil)
(setq fci-rule-width 1)
(setq fci-rule-color "grey30") ;; "white" "grey30"

;;-- (setq fci-rule-use-dashes 111)
;;-- (setq fci-dash-pattern 111)
;;-- (setq fci-rule-character "%")
;;-- (setq fci-rule-cinharacter-color "DarkBlue")

;;; define `global-fci-mode'
;; (define-globalized-minor-mode global-fci-mode fci-mode
;; (lambda ()
;; (fci-mode 1)))

(define-globalized-minor-mode global-fci-mode fci-mode 
  (lambda () 
	(if (and (not (string-match "^\*.*\*$" (buffer-name))) 
			 (not (eq major-mode 'dired-mode)) 
			 (not (eq major-mode 'speedbar-mode))) 
		(fci-mode 1))))

(global-fci-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `indent-guide'
;; (package-require 'indent-guide)
;; (require 'indent-guide)

;; and call command “M-x indent-guide-mode”.

;; If you want to enable indent-guide-mode in all buffers, call function indent-guide-global-mode.
;; (indent-guide-global-mode)

;; Column lines are propertized with “indent-guide-face”. So you may configure this face to make lines more pretty in your colorscheme.
;; (set-face-background 'indent-guide-face "dimgray")

;; If you want indent-guide to show guide lines only in idle-time, you can set delay.
;; (setq indent-guide-delay 0.1)

;; To show not only one guide line but all guide lines recursively, set “indent-guide-recursive” non-nil.
;; (setq indent-guide-recursive t)

;; You may also change the character for guides.
;; (setq indent-guide-char "|")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-highlight)
;; mod-highlight.el ends here
