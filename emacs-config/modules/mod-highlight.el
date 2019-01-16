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
;; `whitespace-mode'
(require 'whitespace)

(define-globalized-minor-mode ome-global-whitespace-mode whitespace-mode 
  (lambda ()
    ;; Make whitespace-mode with very basic background coloring for whitespaces.
    ;; http://ergoemacs.org/emacs/whitespace-mode.html
    (setq whitespace-style (quote (face spaces tabs newline space-mark tab-mark newline-mark )))

    ;; Make whitespace-mode and whitespace-newline-mode use “¶” for end of line char and “▷” for tab.
    (setq whitespace-display-mappings
          ;; all numbers are unicode codepoint in decimal. e.g. (insert-char 182 1)
          '((space-mark 32 [183] 
                        [46]) ; SPACE 32 「 」, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
	        ;;
            (newline-mark 10 [182 10])  ; LINE FEED,
	        ;;
            (tab-mark 9 [9655 9] 
                      [92 9])           ; tab
	        ;;
            )) 
    (if (and (not (string-match "^\*.*\*$" (buffer-name))) 
             (not (eq major-mode 'dired-mode)) 
             (not (eq major-mode 'minibuffer-inactive-mode)) 
             (not (eq major-mode 'speedbar-mode))) 
        (progn
          ;; (message (symbol-name major-mode))
	      (whitespace-mode 1)))))
(if window-system (ome-global-whitespace-mode t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (package-require 'highlight-parentheses)
;; (require 'highlight-parentheses)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(package-require 'symbol-overlay)
(require 'symbol-overlay)

(define-globalized-minor-mode global-symbol-overlay-mode symbol-overlay-mode 
  (lambda () 
    (symbol-overlay-mode 1)))

(global-symbol-overlay-mode nil)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; `hl-todo
;; (package-require 'hl-todo)
;; (require 'hl-todo)

;; (define-key hl-todo-mode-map (kbd "C-c p") 'hl-todo-previous)
;; (define-key hl-todo-mode-map (kbd "C-c n") 'hl-todo-next)
;; (define-key hl-todo-mode-map (kbd "C-c o") 'hl-todo-occur)
;; (global-hl-todo-mode 1)

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
;; `highlight-doxygen'
(package-require 'highlight-doxygen)
(require 'highlight-doxygen)

(highlight-doxygen-global-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`highlight';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(package-require 'dimmer)
(require 'dimmer)
(dimmer-mode)
;;; for lisp (elisp) : `lambda' to 入
;; (prettify-symbols-mode)
;; (global-prettify-symbols-mode 1)

;;; Syntax highlighting
(global-font-lock-mode nil)

;;; Syntax highlighting select area
(transient-mark-mode nil)

;;; more highlights
(require 'generic-x)

;;; highlight current line (0:close 1:open)
(global-hl-line-mode 0)

;;; set `hitghligth' with: () [] {}
;;(electric-pair-mode)
;;(show-paren-mode nil) ;;(show-paren-mode 1)
;;(setq show-paren-style 'parentheses)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `rainbow-mode'
(package-require 'rainbow-mode)
(require 'rainbow-mode)
(define-globalized-minor-mode global-rainbow-mode rainbow-mode 
  (lambda () 
    (rainbow-mode 1)))
(global-rainbow-mode t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `highlight-parentheses'
;; (package-require 'highlight-parentheses)
;; (require 'highlight-parentheses)

;; (defcustom hl-paren-colors
;;   '("firebrick1" "IndianRed1" "IndianRed3" "IndianRed4")

;; (setq hl-paren-colors `("DeepPink" "SpringGreen" "yellow" "cyan" "HotPink" "green" "red" "DeepSkyBlue" "violet" "turquoise" "orange" "blue")) ;;turquoise orange DarkGreen LightGreen SpringGreen chartreuse LightGoldenrod navy

;; (define-globalized-minor-mode global-highlight-parentheses-mode highlight-parentheses-mode
;; (lambda ()
;; (highlight-parentheses-mode t)))
;; (global-highlight-parentheses-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `rainbow-delimiters'
(package-require 'rainbow-delimiters)
(require 'rainbow-delimiters)

(add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
(add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rainbow-delimiters-depth-1-face ((t 
                                     (:foreground "white")))) 
 '(rainbow-delimiters-depth-2-face ((t 
                                     (:foreground "LightGreen")))) 
 '(rainbow-delimiters-depth-3-face ((t 
                                     (:foreground "SlateGray")))) 
 '(rainbow-delimiters-depth-4-face ((t 
                                     (:foreground "khaki")))) 
 '(rainbow-delimiters-depth-5-face ((t 
                                     (:foreground "HotPink2")))) 
 '(rainbow-delimiters-depth-6-face ((t 
                                     (:foreground "DarkGreen")))) 
 '(rainbow-delimiters-depth-7-face ((t 
                                     (:foreground "DodgerBlue")))) 
 '(rainbow-delimiters-depth-8-face ((t 
                                     (:foreground "orange")))) 
 '(rainbow-delimiters-depth-9-face ((t 
                                     (:foreground "brown")))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Sexy tail
;; (package-require 'highlight-tail)
;; (require 'highlight-tail)
;; (highlight-tail-mode)

;;; 1. -----
;; (setq highlight-tail-colors '(("black" . 0)
;; 			      ("#bc2525" . 25)
;; 			      ("black" . 66)))

;; (setq highlight-tail-colors '(("#c1e156" . 0)
;; 			      ("#b8ff07" . 25)
;; 			      ("#00c377" . 60)))
;;; 2. -----
;; (setq highlight-tail-steps 14 highlight-tail-timer 1)

;;; 3. highlight-tail-posterior-type控制渐变的方式
;; (setq highlight-tail-const-width 5)
;; (setq highlight-tail-posterior-type 'const)
                                        ;const :渐变highlight-tail-const-width指定固定长度 t:渐变所有修改
;; (message "Highlight-tail loaded - now your Emacs will be even more sexy!")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-highlight)
;; mod-highlight.el ends here
