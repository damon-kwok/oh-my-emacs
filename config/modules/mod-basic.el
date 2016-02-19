;;; -*- lexical-binding: t -*-
;;; mod-basic.el --- This is where you apply your OCD.
;;;
;;; Author     : Dylan R. E. Moonfire (original)
;;; Maintainer : Jostein Kjønigsen <jostein@gmail.com>
;;; Created    : Feburary 2005
;;; Modified   : November 2015
;;; Version    : 0.8.12
;;; Keywords   : emacs elisp
;;; Package-Version: 20160117.1321
;;; X-URL      : https://github.com/josteink/csharp-mode
;;; Last-saved : 2016-Jan-06
;;; Copyright (C) 2015-2016 Damon Kwok
;;;
;;; Author: gww <damon-kwok@outlook.com>
;;; Date: 2016-02-16
;;;
;;; This program is free software; you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation, either version 3 of the License, or
;;; (at your option) any later version.
;;;
;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this program.  If not, see <http:;;www.gnu.org/licenses/>.
;;;						 
;;; Code:
;;;
(require 'mod-package)   
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`base-config';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; enable/disable loading page
(setq inhibit-startup-message t)

;;default mode
(setq major-mode 'text-mode) ;;set default major mode

;;; set font 1 : look:http://www.linuxsir.org/bbs/thread326299.html
;; (set-default-font "-unknown-DejaVu Sans Mono-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")
;; (add-to-list 'default-frame-alist '(font, "-unknown-DejaVu Sans Mono-normal-normal-normal-*-15-*-*-*-m-0-iso10646-1"))

;; set font 2:
(set-default-font "Bitstream Vera Sans Mono-9")
;; (set-default-font "翩翩体-简-11")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`Frame';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;(bgex-set-image-default "~/gnuemacsref.png" nil)

;;; open file (don't in new frame)
(setq ns-pop-up-frames nil)

;; (setq default-frame-alist '((height . 40) (width . 120) (top . 25) (left . 18) (menu-bar-lines . 0) (tool-bar-lines . 0)))

;;; set tool bar to text style (need emacs24)
(setq tool-bar-style 'both) ;;opt:text image both
;; toolbar (0:disable 1:show) (0disable 1show)
(tool-bar-mode 0)

;;; menu-bar (0:disable 1:show)
(menu-bar-mode 1)

;;; scroll setttings
(scroll-bar-mode 0) ;; (0:disable 1:show)
;;(set-scroll-bar-mode 'right); (nil:disable right left)

;;; set background alpha
;; (set-frame-parameter (selected-frame) 'alpha '(90 85))
;; (add-to-list 'default-frame-alist '(alpha 80 75))

;; maxframe
;;(require 'maxframe)
;;(add-hook 'window-setup-hook 'maximize-frame t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`buffer';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; when file modify with other program: auto update buffer
(global-auto-revert-mode 1)
(setq view-read-only t)

;;replace selected context
(delete-selection-mode t)

;;; set word wrap
;;(global-visual-line-mode t)

;;set line space(pixel)
(setq line-spacing 2)

;;empty line with file
(setq require-final-newline t)

;;clipboard X clipboard
(setq select-enable-clipboard t)
;;set clipboard format: Firefox
(set-clipboard-coding-system 'ctext)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`mini-buffer';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; mini buffer auto resize (t:resize nil:don't resizec)
(setq resize-mini-windows t)

;;; recursive minibuffer (允许递归调用)
(setq enable-recursive-minibuffers t)

;;; max height
(setq max-mini-window-height 0.3)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`undo' && `redo';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; max delete history (undo)
(setq kill-ring-max 200)

(package-require 'undo-tree)
(require 'undo-tree)
(global-undo-tree-mode)

(defun show-undo-tree() 
  (interactive) 
  (show-output-window "*Messages*") 
  (delete-other-windows) 
  (undo-tree-visualize) 
  (if (< (/ (frame-height) 3) 
	 (window-height)) 
      (shrink-window (/ (window-height) 2))))

(global-set-key (kbd "C-x u") 'show-undo-tree)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;`line-number'  `column-number' `fill-column';;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'linum)
(global-linum-mode 1)
(setq column-number-mode t)

;;; page width
(setq fill-column 120)

;;print margin column
(package-require 'fill-column-indicator)
(require 'fill-column-indicator)
(setq whitespace-style '(face trailing))
(setq fci-rule-column 120)
(setq fci-rule-width 1)
(setq fci-rule-color "grey30") ;; DarkBlue white
;; (setq fci-rule-use-dashes 111)
;; (setq fci-dash-pattern 111)
;; (setq fci-rule-character "%")
;; (setq fci-rule-character-color 111)

;;; define-globalized-minor-mode 1:
;; (define-globalized-minor-mode global-fci-mode fci-mode
;;   (lambda ()
;;    (fci-mode 1)))

;;; define-globalized-minor-mode 2:
(define-globalized-minor-mode global-fci-mode fci-mode 
  (lambda () 
    (if (and (not (string-match "^\*.*\*$" (buffer-name))) 
	     (not (eq major-mode 'dired-mode))) 
	(fci-mode 1))))

;; open global-fci-mode
(global-fci-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`scroll';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;page smooth scrolling
;;(setq scroll-margin 1 scroll-conservatively 10000)
(setq scroll-step 1 scroll-margin 3 scroll-conservatively 10000)

;;set scroll speed (mormal:3 line | shift:1 line |control:1 page)
(setq mouse-wheel-scroll-amount '(3 ((shift) . 1) 
				    ((control))) mouse-wheel-progressive-speed nil scroll-step 1)

;;when up/down move: if the cursor is 'end of line', keep it 'end of line'
(setq track-eol t)

;; Á¬Ðø¹öÆÁ
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`cursor';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mouse avoidance cursor
;;(mouse-avoidance-mode 'animate)

;;set paste pos:cursor (not mouse)
(setq mouse-yank-at-point t)

;;(setq-default cursor-type 'bar);; set cursor is line

(blink-cursor-mode -1) ;;set cursor don't blink

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`highlighting';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Syntax highlighting
(global-font-lock-mode t)

;;; Syntax highlighting select area
(transient-mark-mode t)

;;; more highlights
(require 'generic-x)

;;; highlight current line (0:close 1:open)
(global-hl-line-mode 0)

;;; set `hitghligth' with: () [] {} 
(show-paren-mode t) ;;(show-paren-mode 1)
(setq show-paren-style 'parentheses)

;;; rainbow-mode
(package-require 'rainbow-mode)
(require 'rainbow-mode)
(define-globalized-minor-mode global-rainbow-mode rainbow-mode 
  (lambda () 
    (rainbow-mode 1)))
(global-rainbow-mode t)

;;; highlight-parentheses
(package-require 'highlight-parentheses)
(require 'highlight-parentheses)
(define-globalized-minor-mode global-highlight-parentheses-mode highlight-parentheses-mode 
  (lambda () 
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`tip';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;set error tips:blink or beep ?(t:blink nil:beep)
(setq visible-bell nil)
;;remove 'bell beep function'
;;(setq ring-bell-function (lambda () (message "*beep*")))
(setq ring-bell-function (lambda ()))

;;y-or-n-p
(fset 'yes-or-no-p 'y-or-n-p)

;;show error message to tip area
;;(condition-case err
;;	(progn
;;		(require 'xxx) )
;;    (error
;;    (message "Can't load xxx-mode %s" (cdr err))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`mode-line';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; show current function name on the mode-line
;; (which-function-mode)

;;; Show the current function name in the header line
;; (which-function-mode)
;; (setq-default header-line-format
;;               '((which-func-mode ("" which-func-format " "))))
;; (setq mode-line-misc-info
;;             ;; We remove Which Function Mode from the mode line, because it's mostly
;;             ;; invisible here anyway.
;;             (assq-delete-all 'which-func-mode mode-line-misc-info))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `smart-mode-line'
(package-require 'smart-mode-line)
(require 'smart-mode-line)
(setq sml/no-confirm-load-theme t)

(setq sml/theme 'dark)
;; (setq sml/theme 'light)
;; (setq sml/theme 'respectful)

;; (package-require 'smart-mode-line-powerline-theme)
;; (require 'smart-mode-line-powerline-theme)
;; (setq sml/theme 'powerline)

(sml/setup)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `mode-line': ocodo-svg-modelines
;; (package-require 'ocodo-svg-modelines)
;; (ocodo-svg-modelines-init)

;; (smt/set-theme 'ocodo-mesh-retro-aqua-smt)
;; (smt/set-theme 'ocodo-geometry-flakes-smt)
;; (smt/set-theme 'ocodo-kawaii-light-smt)
;; (smt/set-theme 'ocodo-minimal-light-smt)
;; (smt/set-theme 'ocodo-minimal-dark-smt)
;; (smt/set-theme 'ocodo-mesh-grass-smt)
;; (smt/set-theme 'ocodo-mesh-aqua-smt)
;; (smt/set-theme 'ocodo-steps-grass-smt)
;; (smt/set-theme 'ocodo-steps-aqua-smt)


;;; `powerline'
;; (package-require'powerline)
;; (require 'powerline)
;; (powerline-default-theme)

;;; `spaceline'
;; (package-require 'spaceline)
;; (require 'spaceline-config)

;; (spaceline-spacemacs-theme)
;; (spaceline-emacs-theme)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`title';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; time
(display-time)

;;; time format
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(setq display-time-interval 10)
;;(coding-system-get buffer-file-coding-system 'mime-charset)

;;%f%p%l
;;; title
;; (setq frame-title-format `(,(user-login-name) "#" ,(system-name) "---["  "]---- " global-mode-string " ---- %f" ))
(setq frame-title-format `(,(user-login-name) "#" ,(system-name) " [",'(coding-system-get
									buffer-file-coding-system
									'mime-charset) "]      %f"))
;; (setq frame-title-format `(,(user-login-name) "#" ,(system-name) "---[" ,(coding-system-get buffer-file-coding-system 'mime-charset) "]---- " global-mode-string " ---- %f" ))
;; (setq frame-title-format `(,(user-login-name) "#" ,(system-name) "---[" ,(coding-system-get buffer-file-coding-system 'mime-charset) "]---- " global-mode-string " ---- %f" ))

(setq frame-title-format '("" invocation-name "@" system-name "     " global-mode-string "     %f"))
;; See also:  `display-time-format' and `mode-line-format'

;; `mode-line-format'
;; ‘display-time-mode’ – Enable the display of the current time, see DisplayTime
;; ‘line-number-mode’ – Enable or disable the display of the current line number, see also LineNumbers
;; ‘column-number-mode’ – Enable or disable the display of the current column number
;; ‘size-indication-mode’ (for Emacs 22 and up) – Enable or disable the current buffer size, Emacs 22 and later, see size-indication-mode
;; ‘display-battery-mode’ – Enable or disable laptop battery information, see DisplayBatteryMode.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`ido';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;ido mode
;;(require 'ido)
;;(ido-mode 1)

;;(setq ido-confirm-unique-completion t)
;;(setq ido-default-buffer-method 'samewindow)
;;(setq ido-use-filename-at-point t)
;;(setq ido-enable-flex-matching t)
;;(ido-mode t)
;;(ido-everywhere t)
;;(set-face-background 'ido-first-match "green")
;;(set-face-foreground 'ido-subdir "blue3")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;`desktop' && `session' && `recentf';;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; session
;; (package-require 'session)
;; (require 'session)
;; (add-hook 'after-init-hook 'session-initialize)

;;; desktop
(desktop-save-mode 1) ;;(require 'desktop-settings)

;;; recentf file list
(recentf-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; `backup-settings';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; file time stamp
(setq time-stamp-active t)
(setq time-stamp-warn-inactive t)

;;; i don't make backup file
;;(setq-default make-backup-files nil)
(setq make-backup-files nil)

;;2 backup
;;(setq version-control t) ;open version control
;;(setq kept-old-versions 2) ;bcakup raw file number:2
;;(setq kept-new-versions 200) ;backup modify number: 200
;;(setq delete-old-versions t) ;delete old version backup file (file version > 200)
;;(setq backup-directory-alist '(("." . "~/.nextide/.backup"))) ;set backup dir

;;; auto save(t:open nil:close)
;;(setq auto-save-mode nil)

;;; don't create #filename# temp file
(setq auto-save-default nil)

;;; delete file to:Recycle Bin (emacs24)
(setq delete-by-moving-to-trash t)

;;; set highlight rendering mode: only current screen
(setq lazy-lock-defer-on-scrolling t)
;; (setq font-lock-support-mode 'lazy-lock-mode) ; tip: error
(setq font-lock-maximum-decoration t)

;;; set file save dir
(setq bm-repository-file "~/.emacs.d/.bm-repository")
(setq bookmark-default-file "~/.emacs.d/.bookmark")
(setq desktop-base-file-name "~/.emacs.d/.desktop")
(setq desktop-base-lock-name "~/.emacs.d/.desktop.lock")
(setq save-place-file "~/.emacs.d/.emacs-places")
(setq smex-save-file "~/.emacs.d/.smex-items")
(setq mail-personal-alias-file "~/.emacs.d/.mailrc")
(setq recentf-save-file "~/.emacs.d/.recentf")
(setq diary-file "~/.emacs.d/diary")
(setq smex-save-file "~/.emacs.d/.smex-items")
(setq ido-save-directory-list-file "~/.emacs.d/.ido.last")
(setq slime-repl-history-file "~/.emacs.d/.slime-history.eld")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`other-setting';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; image mode
(auto-image-file-mode t)
(setq mm-inline-large-images t)
;; (add-to-list 'mm-attachment-override-types "/image/*")
(autoload 'thumbs "thumbs" "Preview images in a directory." t) ;;thumbs-mode

;;; pdf
(require 'doc-view)

;;; shell keybind: WIN+s
;; (global-set-key (kbd "s-s") 'shell)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
(provide 'mod-basic)
;;; mod-basic.el ends here
