;; -*- lexical-binding: t -*-
;; mod-highlight.el --- This is where you apply your OCD.
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
;; `theme'
;; (package-download 'material-theme)
;; (load-theme 'material t)
;;
;; (package-download 'immaterial-theme)
;; (load-theme 'immaterial t)

(load-theme 'ome-material t)
;; (if (display-graphic-p)
;; (load-theme 'ome-material t)
;; (load-theme 'ome-xemacs t))

;; `page-break-lines'
(package-download 'page-break-lines)
(if (display-graphic-p)
  (progn ;;
    (internal-require 'page-break-lines)
    (global-page-break-lines-mode)))

;;; `ANSI-colors' in the compilation buffer output
(internal-require 'ansi-color)
(defun endless/colorize-compilation ()
  "Colorize from `compilation-filter-start' to `point'."
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region compilation-filter-start (point))))

(add-hook 'compilation-filter-hook #'endless/colorize-compilation)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; emojify
(package-require 'emojify)

;; Set emojify to only replace Unicode emoji, and do it everywhere.
(setq emojify-emoji-styles '(unicode) emojify-inhibit-major-modes '())

;; Patch emojify to replace emoji everywhere in programming modes.
(defun emojify-valid-prog-context-p (beg end)
  't)

;; Enable it globally.
(add-hook 'after-init-hook #'global-emojify-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; `whitespace-mode'
(internal-require 'whitespace)

;; (set-face-attribute 'whitespace-space nil :background "gray70" :foreground "lightgray")
;; (set-face-attribute 'whitespace-tab nil :background "gray70" :foreground "lightgray")

(define-globalized-minor-mode ome-global-whitespace-mode whitespace-mode
  (lambda ()
    ;; Make whitespace-mode with very basic background coloring for whitespaces.
    ;; http://ergoemacs.org/emacs/whitespace-mode.html
    (setq whitespace-style (quote (face spaces tabs newline space-mark tab-mark newline-mark )))

    ;; Make whitespace-mode and whitespace-newline-mode use “¶” for end of line char and “▷” for tab.
    (setq whitespace-display-mappings
      ;; all numbers are unicode codepoint in decimal. e.g. (insert-char 182 1)
      '((space-mark 32 [183]
          [46])       ; SPACE 32 「 」, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
         ;;
         (newline-mark 10 [182 10])     ; LINE FEED,
         ;;
         (tab-mark 9 [9655 9]
           [92 9])                      ; tab
         ;;
         ))
    (if (and (not (string-match "^\*.*\*$" (buffer-name)))
          (not (eq major-mode 'ponylang-mode))
          (not (eq major-mode 'dired-mode))
          (not (eq major-mode 'treemacs-mode))
          (not (eq major-mode 'neotree-mode))
          (not (eq major-mode 'fundamental-mode))
          (not (eq major-mode 'minibuffer-inactive-mode))
          (not (eq major-mode 'speedbar-mode)))
      (progn
        ;; (message (symbol-name major-mode))
	      (whitespace-mode 1)))))
(if window-system (ome-global-whitespace-mode t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (package-require 'highlight-parentheses)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (package-require 'symbol-overlay)
;; (define-globalized-minor-mode global-symbol-overlay-mode symbol-overlay-mode
;; (lambda ()
;; (symbol-overlay-mode 1)))
;; (global-symbol-overlay-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; `hl-todo
(package-require 'hl-todo)
(define-key hl-todo-mode-map (kbd "C-c p") 'hl-todo-previous)
(define-key hl-todo-mode-map (kbd "C-c n") 'hl-todo-next)
(define-key hl-todo-mode-map (kbd "C-c o") 'hl-todo-occur)
(global-hl-todo-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `fci-mode'
(package-require 'fill-column-indicator)
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
          (not (eq major-mode 'fundamental-mode))
          (not (eq major-mode 'speedbar-mode)))
      (fci-mode 1))))

(global-fci-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `indent-guide'
;; (package-require 'indent-guide)
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

(if (display-graphic-p)
  (progn ;;
    (package-require 'highlight-indent-guides)
    (setq highlight-indent-guides-method 'character)
    (setq highlight-indent-guides-character ?\|)
    ;; (setq highlight-indent-guides-character "|")

    ;; (define-globalized-minor-mode global-highlight-indent-guides-mode
    highlight-indent-guides-mode
    ;; (lambda ()
    ;; (highlight-indent-guides-mode 1)))
    (define-globalized-minor-mode global-highlight-indent-guides-mode highlight-indent-guides-mode
      (lambda ()
        (if (and (not (string-match "^\*.*\*$" (buffer-name)))
              (not (eq major-mode 'dired-mode))
              (not (eq major-mode 'speedbar-mode)))
          (highlight-indent-guides-mode 1))))
    (global-highlight-indent-guides-mode 1)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; `highlight-doxygen'
;; (package-require 'highlight-doxygen)
;; (highlight-doxygen-global-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`highlight';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `dimmer' Visually highlight the selected buffer.
(package-require 'dimmer)
;; (setq dimmer-use-colorspace :hsl)
(defcustom dimmer-use-colorspace
  :rgb ""
  :type '(radio (const :tag "Interpolate in CIELAB 1976"
                  :cielab)
           (const :tag "Interpolate in HSL"
             :hsl)
           (const :tag "Interpolate in RGB"
             :rgb))
  :group 'dimmer)
(dimmer-mode)

;;; for lisp (elisp) : `lambda' to 入
;; (prettify-symbols-mode)
;; (global-prettify-symbols-mode 1)

;;; Syntax highlighting
(global-font-lock-mode nil)

;;; Syntax highlighting select area
(transient-mark-mode nil)

;;; more highlights
(internal-require 'generic-x)

;;; highlight current line (0:close 1:open)
(global-hl-line-mode 0)

;;; set `hitghligth' with: () [] {}
;;(electric-pair-mode)
;;(show-paren-mode nil) ;;(show-paren-mode 1)
;;(setq show-paren-style 'parentheses)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Sexy tail
;; (package-require 'highlight-tail)
;; (package-require-curl "highlight-tail" "highlight-tail.el" "http://www.emacswiki.org/emacs-en/download/highlight-tail.el")
;; (highlight-tail-mode)

;;; 1. -----
;; (setq highlight-tail-colors '(("#119911" . 0)
;; ("#bc2525" . 25)
;; ("#991199" . 60)))
;; (setq highlight-tail-colors '(("black" . 0)
;; ("#bc2525" . 25)
;; ("black" . 66)))
;; (setq highlight-tail-colors '(("#c1e156" . 0)
;; ("#b8ff07" . 25)
;; ("#00c377" . 60)))
;;; 2. -----
;; (setq highlight-tail-steps 14 highlight-tail-timer 1)

;;; 3. highlight-tail-posterior-type控制渐变的方式
;; (setq highlight-tail-const-width 7)
;; (setq highlight-tail-posterior-type 'const)
;;const :渐变highlight-tail-const-width指定固定长度 t:渐变所有修改

;; (message "Highlight-tail loaded - now your Emacs will be even more sexy!")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-highlight)
;; mod-highlight.el ends here
