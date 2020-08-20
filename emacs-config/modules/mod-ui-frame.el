;; -*- lexical-binding: t -*-
;; mod-ui-frame.el --- This is where you apply your OCD.
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
;;; `mini-frame'
;; (package-require 'mini-frame)
;; (custom-set-variables
 ;; '(mini-frame-show-parameters
   ;; '((top . 0)
     ;; (width . 1.0)
     ;; (left . 0.5)
;; (height . 15))))
;;
;;; `title'
(setq frame-title-format '("[%Z]    [%m]    "
                            (:eval (if (ome-project-name)
                                     (concat "<project: " (ome-project-name) ">    ")))
                            (:eval (cond (buffer-read-only " (readonly)")))
                            " %b"
                            (:eval (cond ((buffer-modified-p) " *")))
                            "    %f"))
;;"%b" " (%m) %f"

;; (setq frame-title-format '("[%Z]    %m    "
;; 			   (:eval (cond (buffer-read-only "%%")
;; 					((buffer-modified-p) "*")))
;; 			   "%f  (" invocation-name "@" system-name ")   " global-mode-string ))
;;user-login-name
;;(setq frame-title-format '("" invocation-name "@" system-name "     " global-mode-string "     %f"))
;;
(set-window-dedicated-p (selected-window) nil)
;; (bgex-set-image-default "~/gnuemacsref.png" nil)
;; (bgex-set-image-default "~/.oh-my-emacs/logo.png" nil)

;;; `open-file' (don't in new frame)
(setq ns-pop-up-frames nil)
(setq default-frame-alist '((height . 40)
                             (width . 130)
                             (top . 25)
                             (left . 18)
                             (menu-bar-lines . 0)
                             (tool-bar-lines . 0)))

;;; `maxframe'
;;(internal-require 'maxframe)
;;(add-hook 'window-setup-hook 'maximize-frame t)

;;; set background `alpha'
(setq alpha-list ;;
  '((100 100)
     (95 75)
     (90 70)
     (85 65)
     (80 60)
     (75 55)
     (70 50)
     (65 55)))

(defun loop-alpha ()
  (interactive)
  (let ((h (car alpha-list))) ;; head value will set to
    ((lambda (a ab)
       (set-frame-parameter (selected-frame) 'alpha (list a ab))
       (add-to-list 'default-frame-alist (cons 'alpha (list a ab))))
      (car h)
      (car (cdr h)))
    (setq alpha-list (cdr (append alpha-list (list h))))))
(set-frame-parameter (selected-frame) 'alpha '(95 75))
(add-to-list 'default-frame-alist '(alpha 95 75))
(global-set-key [(f8)] 'loop-alpha)

;;; set tool bar to text style (need emacs24)
(setq tool-bar-style 'both) ;;opt:text image both

;; toolbar (0:disable 1:show) (0:disable 1:show)
(tool-bar-mode 0)

;;; menu-bar (0:disable 1:show)
(menu-bar-mode 0)

;;; scroll setttings (nil 'left 'right)
(internal-require 'scroll-bar)
;;(set-scroll-bar-mode 'right); (nil:disable right left)
(set-scroll-bar-mode nil)

;;; The effect is that (however it is moved) the cursor is always given 3 lines
;;; of context before the top or bottom of the window, which I find very useful.
(setq scroll-margin 3)

;;; `scroll'
;;; page smooth scrolling
;; (setq scroll-margin 1 scroll-conservatively 10000)
(setq scroll-step 1 scroll-margin 3 scroll-conservatively 10000)

;;; set scroll `speed' (mormal:3 line | shift:1 line |control:1 page)
(setq mouse-wheel-scroll-amount '(3 ((shift) . 1)
                                   ((control))) mouse-wheel-progressive-speed nil scroll-step 1)


;;; set font 1 : look:http://www.linuxsir.org/bmkbs/thread326299.html
;; (set-default-font "-unknown-DejaVu Sans Mono-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")
;; (add-to-list 'default-frame-alist '(font, "-unknown-DejaVu Sans Mono-normal-normal-normal-*-15-*-*-*-m-0-iso10646-1"))

;;; set font 2:
;; (set-frame-font "Bitstream Vera Sans Mono-9")
;; (set-frame-font "翩翩体-简-11")
;; (set-frame-font "Microsoft Yahei 10")
;; (set-frame-font "宋体 10")

;; ============================================================

(defun ome-set-font(font size)
  ;; set a default font
  (when (member font (font-family-list))
    (let ((font-info(concat font "-" (number-to-string size))))
      (set-face-attribute 'default nil
        :font font-info)
      ;; set font for all windows. don't keep window size fixed
      ;; (set-frame-font font-info nil t)
      (set-frame-font font-info nil t)))
  ;;
  ;; set chinese Font
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font) charset (font-spec :family "Microsoft Yahei"
                                                            :size 12))))
;;
;; lookup: |1iljg9q0oO
;; (if window-system (ome-set-font "Bitstream Vera Sans Mono" 10))
;; (if window-system (ome-set-font "DejaVu Sans Mono" 10))
;; (if window-system (ome-set-font "ibm3270" 11))
;; (if window-system (ome-set-font "Hack" 10))
;; (if window-system (ome-set-font "Fira Code" 10))
(if window-system (ome-set-font "JetBrains Mono" 10))
;; (if window-system (ome-set-font "Fantasque Sans Mono" 11))

;;; `tip'
;;; set error tips:blink or beep ?(t:blink nil:beep)
(setq visible-bell nil)
;;; remove 'bell beep function'
;; (setq ring-bell-function (lambda () (message "*beep*")))
(setq ring-bell-function (lambda ()))

;;; y-or-n-p
(fset 'yes-or-no-p 'y-or-n-p)


;;; `nyan-mode'
(package-download 'nyan-mode)
(if (display-graphic-p)
  (progn
    (require 'nyan-mode)
    (nyan-start-animation)
    (nyan-mode 1)))

;;; `all-the-icons'
(package-require 'all-the-icons)
(package-require 'spaceline-all-the-icons)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-ui-frame)
;; mod-ui.el ends here
