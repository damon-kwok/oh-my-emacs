;;; -*- lexical-binding: t -*-
;;; mod-basic.el --- This is where you apply your OCD.
;;;
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
;;----------------------------------------------------------------------------
;; Temporarily reduce garbage collection during startup
;;----------------------------------------------------------------------------
;; (defconst sanityinc/initial-gc-cons-threshold gc-cons-threshold
;;   "Initial value of `gc-cons-threshold' at start-up time.")
;; (setq gc-cons-threshold (* 256 1024 1024))
;; (add-hook 'after-init-hook (lambda ()
;; 			     (setq gc-cons-threshold sanityinc/initial-gc-cons-threshold)))

(defun my-optimize-gc (NUM PER) 
  "By default Emacs will initiate GC every 0.76 MB allocated (gc-cons-threshold == 800000).
@see http://www.gnu.org/software/emacs/manual/html_node/elisp/Garbage-Collection.html
We increase this to 16MB by `(my-optimize-gc 16 0.5)` "
  (setq-default gc-cons-threshold (* 1024 1024 NUM) gc-cons-percentage PER))

;;(message (concat "gc:" gc-cons-threshold " pre:" gc-cons-percentage))
(my-optimize-gc 512 0.2)
(add-hook 'after-init-hook (lambda () 
			     (my-optimize-gc 8 0.2)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`frame';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;(bgex-set-image-default "~/gnuemacsref.png" nil)

;;; open file (don't in new frame)
(setq ns-pop-up-frames nil)

(setq default-frame-alist '((height . 40) 
			    (width . 130) 
			    (top . 25) 
			    (left . 18) 
			    (menu-bar-lines . 0) 
			    (tool-bar-lines . 0)))

;;; set tool bar to text style (need emacs24)
(setq tool-bar-style 'both) ;;opt:text image both

;; toolbar (0:disable 1:show) (0:disable 1:show)
					;(tool-bar-mode 0)

;;; menu-bar (0:disable 1:show)
					;(menu-bar-mode 0)

;;; scroll setttings (nil:disable 1:show)
(require 'scroll-bar)
(set-scroll-bar-mode nil)
;;(set-scroll-bar-mode 'right); (nil:disable right left)

;;; The effect is that (however it is moved) the cursor is always given 3 lines
;;; of context before the top or bottom of the window, which I find very useful.
(setq scroll-margin 3)

;;; set background alpha
;; (set-frame-parameter (selected-frame) 'alpha '(90 85))
;; (add-to-list 'default-frame-alist '(alpha 80 75))

;;; maxframe
;;(require 'maxframe)
;;(add-hook 'window-setup-hook 'maximize-frame t)

;;; `scroll'
;;; page smooth scrolling
;; (setq scroll-margin 1 scroll-conservatively 10000)
(setq scroll-step 1 scroll-margin 3 scroll-conservatively 10000)

;;; set scroll speed (mormal:3 line | shift:1 line |control:1 page)
(setq mouse-wheel-scroll-amount '(3 ((shift) . 1) 
				    ((control))) mouse-wheel-progressive-speed nil scroll-step 1)

;;; when up/down move: if the cursor is 'end of line', keep it 'end of line'
(setq track-eol t)

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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`Theme';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (package-require 'django-theme)
;;  (when  (package-installed-p 'django-theme)
;;    (require 'django-theme))

;; (if (display-graphic-p)
;;     (require 'django-theme)
;; (load-theme 'deeper-blue))

;; (load-theme 'wombat)

;; (load-theme 'deeper-blue)

;; (package-require 'sublime-themes)
;; ;;(require 'sublime-themes)
;; (load-theme 'granger t t)
;; (enable-theme 'granger)

(package-require 'color-theme-modern)

(if (display-graphic-p) 
    (progn ;;
      ;;(load-theme 'gray30 t t)
      ;;(enable-theme 'gray30)
      (load-theme 'deeper-blue) 
      (enable-theme 'deeper-blue)
      ;;
      ) 
  (progn
    ;;
    ;;(load-theme 'xemacs t t)
    ;;(enable-theme 'xemacs)
    (load-theme 'deeper-blue) 
    (enable-theme 'deeper-blue)
    ;;
    )
  ;;
  )

;;; shaman
;;(load-theme 'shaman t t)
;;(enable-theme 'shaman)

;;; jazz
;; (package-require 'jazz-theme)
;; (load-theme 'jazz t t)
;; (enable-theme 'jazz)

;;; leuven
;; (package-require 'leuven-theme)
;; (load-theme 'leuven t t)
;; (enable-theme 'leuven)

;;; django
;;(load-theme 'django t t)
;;(enable-theme 'django)

;;; xemacs
;;(load-theme 'm-xemacs t t)
;;(enable-theme 'm-xemacs)

;;(package-require 'monokai-theme)
;;(load-theme 'monokai t t)
;;(enable-theme 'monokai)

;; (load-theme 'fischmeister t t)
;; (enable-theme 'fischmeister)

;; (require 'pink-bliss)
;; (pink-bliss)

;; (load-theme 'jedit-grey t t)
;; (enable-theme 'jedit-grey)

;; (load-theme 'xemacs t t)
;; (enable-theme 'xemacs)

;;; other
;; (load-theme 'oswald t t)
;; (enable-theme 'oswald)

;; (load-theme 'charcoal-black t t)
;; (enable-theme 'charcoal-black)

;; (load-theme 'ld-dark t t)
;; (enable-theme 'ld-dark)



;;; dos
;; (load-theme 'parus t t)
;; (enable-theme 'parus)

;;; gnome
;; (load-theme 'pok-wog t t)
;; (enable-theme 'pok-wog)

;; (load-theme 'jonadabian-slate t t)
;; (enable-theme 'jonadabian-slate)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`base-config';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; '`error'
(setq debug-on-error t) ;; M-x toggle-debug-on-error
;; (typo-err)

;; overflow of stack
;; (setq kill-ring-max 1024)		;用一个很大的kill ring. 这样防止我不小心删掉重要的东西
;; (setq max-lisp-eval-depth 900000)       ;lisp最大执行深度
;; (setq max-specpdl-size 900000)          ;最大容量
;; (setq undo-outer-limit 9000000)         ;撤销限制
;; (setq message-log-max t)                ;设置message记录全部消息, 而不用截去
;; (setq eval-expression-print-length nil) ;设置执行表达式的长度没有限制
;; (setq eval-expression-print-level nil)  ;设置执行表达式的深度没有限制
;; (setq global-mark-ring-max 1024)        ;设置最大的全局标记容量
;; (setq history-delete-duplicates t)      ;删除minibuffer的重复历史

;;; enable/disable loading page (t:disable nil:enable)
(setq inhibit-startup-message t)

;;; `'default-mode'
(setq major-mode 'text-mode) ;;set default major mode {sh-mode | text-mode}

;;; set font 1 : look:http://www.linuxsir.org/bbs/thread326299.html
;; (set-default-font "-unknown-DejaVu Sans Mono-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")
;; (add-to-list 'default-frame-alist '(font, "-unknown-DejaVu Sans Mono-normal-normal-normal-*-15-*-*-*-m-0-iso10646-1"))

;;; set font 2:
(set-frame-font "Bitstream Vera Sans Mono-9")
;; (set-frame-font "翩翩体-简-11")

;;; `tip'
;;; set error tips:blink or beep ?(t:blink nil:beep)
(setq visible-bell nil)
;;; remove 'bell beep function'
;; (setq ring-bell-function (lambda () (message "*beep*")))
(setq ring-bell-function (lambda ()))

;;; y-or-n-p
(fset 'yes-or-no-p 'y-or-n-p)

;;; show error message to tip area
;;(condition-case err
;;	(progn
;;		(require 'xxx) )
;;    (error
;;    (message "Can't load xxx-mode %s" (cdr err))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`title';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; time
(display-time)

;;; time format
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(setq display-time-interval 10)

;;; title
(setq frame-title-format '("%Z  - " 
			   (:eval (cond (buffer-read-only "(Read-Only)"))) 
			   (:eval (cond ((buffer-modified-p) "*")))
			   "%b" "  | (%m) |  %f"))

;; (setq frame-title-format '("[%Z]    %m    "
;; 			   (:eval (cond (buffer-read-only "%%")
;; 					((buffer-modified-p) "*")))
;; 			   "%f  (" invocation-name "@" system-name ")   " global-mode-string ))
;;user-login-name
;;(setq frame-title-format '("" invocation-name "@" system-name "     " global-mode-string "     %f"))

;; See also:  `display-time-format' and `mode-line-format'

;; `mode-line-format'
;; ‘display-time-mode’ – Enable the display of the current time, see DisplayTime
;; ‘line-number-mode’ – Enable or disable the display of the current line number, see also LineNumbers
;; ‘column-number-mode’ – Enable or disable the display of the current column number
;; ‘size-indication-mode’ (for Emacs 22 and up) – Enable or disable the current buffer size, Emacs 22 and later, see size-indication-mode
;; ‘display-battery-mode’ – Enable or disable laptop battery information, see DisplayBatteryMode.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`tabbar';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (package-require 'tabbar-ruler)

;; (setq tabbar-ruler-global-tabbar t)	; get tabbar
;; (setq tabbar-ruler-global-ruler nil)	; get global ruler
;; (setq tabbar-ruler-popup-menu nil)	; get popup menu.
;; (setq tabbar-ruler-popup-toolbar nil)	; get popup toolbar
;; (setq tabbar-ruler-popup-scrollbar nil)	; show scroll-bar on mouse-move
;; (require 'tabbar-ruler)

;;; The default behavior for tabbar-ruler is to group the tabs by frame. You can change this back to the old-behavior by:
;;-- (tabbar-ruler-group-buffer-groups)

;;; or by issuing the following code:
;;-- (setq tabbar-buffer-groups-function 'tabbar-buffer-groups)

;;; In addition, you can also group by projectile project easily by:
;; (tabbar-ruler-group-by-projectile-project)

;; (global-set-key (kbd "M-]") 'tabbar-ruler-forward)
;; (global-set-key (kbd "M-[") 'tabbar-ruler-backward)
;; (global-set-key (kbd "C-M-]") 'tabbar-ruler-tabbar-forward-group)
;; (global-set-key (kbd "C-M-[") 'tabbar-ruler-tabbar-backward-group)

;;-- (global-set-key (kbd "C-c t") 'tabbar-ruler-move)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`modeline';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

;;; `'tdd-status-mode-line'
;; (package-require 'tdd-status-mode-line)
;; (require 'tdd-status-mode-line)
;; (make-variable-buffer-local 'tdd-status/current-status-index)
;; (tdd-status-global-mode)

;;; `mode-icons'
(package-require 'mode-icons)
(require 'mode-icons)
(mode-icons-mode)

;;; `nyan-mode'
(package-require 'nyan-mode)
(if (display-graphic-p) 
    (progn 
      (require 'nyan-mode) 
      (nyan-start-animation) 
      (nyan-mode 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`buffer';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; when file modify with other program: auto update buffer
(global-auto-revert-mode 1)
(setq view-read-only t)

;;replace selected context
(delete-selection-mode t)

;;; set word wrap
(global-visual-line-mode t)

;;; set line space(pixel)
(setq line-spacing 2)

;;; empty line with file
(setq require-final-newline t)

;;; clipboard X clipboard
(setq select-enable-clipboard t) ;; (setq x-select-enable-clipboard t)

;;; ANSI-colors in the compilation buffer output
(require 'ansi-color)
(defun endless/colorize-compilation () 
  "Colorize from `compilation-filter-start' to `point'."
  (let ((inhibit-read-only t)) 
    (ansi-color-apply-on-region compilation-filter-start (point))))

(add-hook 'compilation-filter-hook #'endless/colorize-compilation)
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
(require 'undo-tree)
(global-undo-tree-mode)

(defun show-undo-tree() 
  (interactive) 
  (m-show-compilation "*Messages*") 
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
;;;;;;;;;;;;;;;;;;;;`line-number'  `column-number' `fill-column';;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 'linum'
;; (require 'linum)
(setq linum-mode t)
(setq linum-format "%4d")
(global-linum-mode)

;;; `column'
(setq column-number-mode t)

;;; page width
;; (setq fill-column 100)

;;; fci-mode
(package-require 'fill-column-indicator)
(require 'fill-column-indicator)
(setq whitespace-style '(face trailing))
(setq fci-rule-column 80)
(setq fci-rule-width 1)
(setq fci-rule-color "grey30") ;; "white" "grey30"

;;-- (setq fci-rule-use-dashes 111)
;;-- (setq fci-dash-pattern 111)
;;-- (setq fci-rule-character "%")
;;-- (setq fci-rule-cinharacter-color "DarkBlue")

;;; define `global-fci-mode'
(define-globalized-minor-mode global-fci-mode fci-mode 
  (lambda () 
    (fci-mode 1)))

;;; open global-fci-mode
(global-fci-mode 0)


;;; indent-guide
(package-require 'indent-guide)
(require 'indent-guide)

;; and call command “M-x indent-guide-mode”.

;; If you want to enable indent-guide-mode in all buffers, call function indent-guide-global-mode.
(indent-guide-global-mode)

;; Column lines are propertized with “indent-guide-face”. So you may configure this face to make lines more pretty in your colorscheme.
;; (set-face-background 'indent-guide-face "dimgray")

;; If you want indent-guide to show guide lines only in idle-time, you can set delay.
;; (setq indent-guide-delay 0.1)

;; To show not only one guide line but all guide lines recursively, set “indent-guide-recursive” non-nil.
(setq indent-guide-recursive t)

;; You may also change the character for guides.
;; (setq indent-guide-char "|")

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`highlight';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; for lisp (elisp) : `lambda' to 入
;; (prettify-symbols-mode)
;; (global-prettify-symbols-mode 1)

;;; Syntax highlighting
(global-font-lock-mode t)

;;; Syntax highlighting select area
(transient-mark-mode t)

;;; more highlights
(require 'generic-x)

;;; highlight current line (0:close 1:open)
(global-hl-line-mode 0)

;;; set `hitghligth' with: () [] {}
;;(electric-pair-mode)
;;(show-paren-mode nil) ;;(show-paren-mode 1)
;;(setq show-paren-style 'parentheses)

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

;; (defcustom hl-paren-colors
;;   '("firebrick1" "IndianRed1" "IndianRed3" "IndianRed4")

(setq hl-paren-colors `("DeepPink" "SpringGreen" "yellow" "cyan" "HotPink" "green" "red"
			"DeepSkyBlue" "violet" "turquoise" "orange" "blue")) ;;turquoise orange DarkGreen LightGreen SpringGreen

(define-globalized-minor-mode global-highlight-parentheses-mode highlight-parentheses-mode 
  (lambda () 
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; emojify
;; (package-require 'emojify)
;; (require 'emojify)

;; Set emojify to only replace Unicode emoji, and do it everywhere.
;; (setq emojify-emoji-styles '(unicode) emojify-inhibit-major-modes '())

;; Patch emojify to replace emoji everywhere in programming modes.
;; (defun emojify-valid-prog-context-p (beg end) 't)

;; Enable it globally.
;; (add-hook 'after-init-hook #'global-emojify-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`folding';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (package-require 'vimish-fold)
;; (require 'vimish-fold)
;; (vimish-fold-global-mode 1)

(package-require 'yafolding)
(require 'yafolding)

(global-set-key (kbd "C-M-`") 'yafolding-toggle-all)
(global-set-key (kbd "C-~") 'yafolding-hide-parent-element)
(global-set-key (kbd "C-`") 'yafolding-toggle-element)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`indent';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (package-require 'indent-guide)
;; (require 'indent-guide)

;;; Column lines are propertized with “indent-guide-face”. So you may configure this face to make liens more pretty in your colorscheme.
;; (set-face-background 'indent-guide-face "dimgray")
;;; If you want indent-guide to show guide lines only in idle-time, you can set delay.

;; (setq indent-guide-delay 0.1)

;;; To show not only one guide line but all guide lines recursively, set “indent-guide-recursive” non-nil.
;; (setq indent-guide-recursive t)

;;; You may also change the character for guides.
;; (setq indent-guide-char ":")

;; (indent-guide-global-mode)

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

;;; 2 backup
;;(setq version-control t) ;open version control
;;(setq kept-old-versions 2) ;bcakup raw file number:2
;;(setq kept-new-versions 200) ;backup modify number: 200
;;(setq delete-old-versions t) ;delete old version backup file (file version > 200)
;;(setq backup-directory-alist '(("." . "~/.nextide/.backup"))) ;set backup dir

;;; auto save(t:open nil:close)
(setq auto-save-mode nil)

;;; don't create #filename# temp file
(setq auto-save-default nil)

;;; delete file to:Recycle Bin (emacs24)
(setq delete-by-moving-to-trash t)

;;; set highlight rendering mode: only current screen
(setq lazy-lock-defer-on-scrolling t)
;; (setq font-lock-support-mode 'lazy-lock-mode) ; tip: error
(setq font-lock-maximum-decoration t)

;;; set file save dir
;; (setq bm-repository-file "~/.emacs.d/.bm-repository")
;; (setq bookmark-default-file "~/.emacs.d/.bookmark")
;; (setq desktop-base-file-name "~/.emacs.d/.desktop")
;; (setq desktop-base-lock-name "~/.emacs.d/.desktop.lock")
;; (setq save-place-file "~/.emacs.d/.emacs-places")
;; (setq smex-save-file "~/.emacs.d/.smex-items")
;; (setq mail-personal-alias-file "~/.emacs.d/.mailrc")
;; (setq recentf-save-file "~/.emacs.d/.recentf")
;; (setq diary-file "~/.emacs.d/diary")
;; (setq smex-save-file "~/.emacs.d/.smex-items")
;; (setq ido-save-directory-list-file "~/.emacs.d/.ido.last")
;; (setq slime-repl-history-file "~/.emacs.d/.slime-history.eld")

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
(provide 'mod-basic)
;;; mod-basic.el ends here
