;;; -*- lexical-binding: t -*-
;;; mod-tabbar.el --- This is where you apply your OCD.
;;;
;;; Copyright (C) 2015-2016 Damon Kwok
;;;
;;; Author: gww <DamonKwok@msn.com>
;;; Date: 2016-01-05
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
(require 'mod-package)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; tabbar
(package-require 'tabbar)
(require 'tabbar)
(tabbar-mode t)

(keymap-unset-key (kbd "C-c C-<home>") "tabbar-mode")
(keymap-unset-key (kbd "C-c <C-f10>") "tabbar-mode")
(keymap-unset-key (kbd "C-c <C-left>") "tabbar-mode")
(keymap-unset-key (kbd "C-c <C-right>") "tabbar-mode")
(keymap-unset-key (kbd "C-c <C-up>") "tabbar-mode")
(keymap-unset-key (kbd "C-c <C-down>") "tabbar-mode")
(keymap-unset-key (kbd "C-c <C-prior>") "tabbar-mode")
(keymap-unset-key (kbd "C-c <C-next>") "tabbar-mode")

(global-set-key (kbd "M-]") 'tabbar-forward)
(global-set-key (kbd "M-[") 'tabbar-backward)
(global-set-key (kbd "C-M-]") 'tabbar-forward-group)
(global-set-key (kbd "C-M-[") 'tabbar-backward-group)

(global-set-key (kbd "<backtab>") #'(lambda () 
				      (interactive) 
				      (switch-to-buffer (other-buffer (current-buffer) 1))))

;; (set-face-attribute 'tabbar-default nil
;; 		    ;; :family "DejaVu Sans Mono"
;; 		    ;;:inherit 'tabbar-default
;; 		    :background "#383838"
;; 		    :foreground "#383838"
;; 		    :box '(:line-width 2
;; 				       :color "#330000") ; "#00B2BF"
;; 		    :overline "#330000"
;; 		    :underline "#330000"
;; 		    :height 1.0)

;; (set-face-attribute 'tabbar-button nil
;; 		    :inherit 'tabbar-default
;; 		    :foreground "#330000" ;;"DarkGreen"
;; 		    :background "gray60"  ;;LightGoldenrod
;; 		    :box '(:line-width 1
;; 				       :color "#330000")
;; 		    :overline "#330000"
;; 		    :underline "#330000")

;; (set-face-attribute 'tabbar-selected nil
;; 		    :inherit 'tabbar-default
;; 		    :foreground "gold"	 ;;"DarkGreen"
;; 		    :background "#383838" ;;LightGoldenrod
;; 		    :box '(:line-width 1 ;;
;; 				       :color "DarkGoldenrod") ;DarkGoldenrod gray30 DarkGreen ;yellow70
;; 		    :overline "gold"
;; 		    :underline "#383838"
;; 		    :weight 'bold)

;; (set-face-attribute 'tabbar-unselected nil
;; 		    :inherit 'tabbar-default
;; 		    :foreground "#330000" ;;"DarkGreen"
;; 		    :background "gray60"  ;;LightGoldenrod
;; 		    :box '(:line-width 1
;; 				       :color "#330000") ;00B2BF
;; 		    :overline "#330000"
;; 		    :underline "#330000" ;;down
;; 		    :weight 'bold)

(set-face-attribute 'tabbar-default nil
		    ;; :family "DejaVu Sans Mono"
		    ;;:inherit 'tabbar-default
		    :background "#181A26" 
		    :foreground "#181A26" 
		    :box '(:line-width 2 
				       :color "#181A26") ; "#00B2BF"
		    :height 1.0)

(set-face-attribute 'tabbar-button nil 
		    :inherit 'tabbar-default 
		    :foreground "#181A26" 
		    :background "#181A26" 
		    :box '(:line-width 1 
				       :color "#181A26") 
		    :overline "#181A26" 
		    :underline "#181A26")

(set-face-attribute 'tabbar-selected nil 
		    :inherit 'tabbar-default 
		    :foreground "gold" 
		    :background "#181A26" 
		    :box '(:line-width 1 ;;
				       :color "DarkGoldenrod") 
		    :overline "gold" 
		    :underline "#383838" 
		    :weight 'bold)

(set-face-attribute 'tabbar-unselected nil 
		    :inherit 'tabbar-default 
		    :foreground "gray60"  ;;"DarkGreen"
		    :background "#181A26" ;;LightGoldenrod
		    :box '(:line-width 1 
				       :color "#330000") ;#00B2BF
		    :overline "gray60" 
		    :underline "gray60" ;;down
		    :weight 'bold)

(setq tabbar-buffer-groups-function nil)
(defun tabbar-buffer-groups () 
  "Return the list of group names the current buffer belongs to.
     Return a list of one element based on major mode."
  (list (cond
	 ;;------------------------------------------------
	 ;; ((or (get-buffer-process (current-buffer))
	 ;;      ;; Check if the major mode derives from `comint-mode' or
	 ;;      ;; `compilation-mode'.
	 ;;      (tabbar-buffer-mode-derived-p
	 ;;       major-mode '(comint-mode compilation-mode)))
	 ;;  "Process"
	 ;;  )
	 ;;------------------------------------------------
	 ;; ((member (buffer-name)
	 ;;          '("*scratch*" "*Messages*" "*Help*"))
	 ;;  "Common"
	 ;;  )
	 ((string-equal "*" (substring (buffer-name) 0 1)) "Common") 
	 ((member (buffer-name) 
		  '("xyz" "day" "m3" "abi" "for" "nws" "eng" "f_g" "tim" "tmp")) "Main") 
	 ((eq major-mode 'dired-mode) "Dired") 
	 ((memq major-mode '(help-mode apropos-mode Info-mode Man-mode)) "Common") 
	 ((memq major-mode '(rmail-mode rmail-edit-mode vm-summary-mode vm-mode mail-mode
					mh-letter-mode mh-show-mode mh-folder-mode gnus-summary-mode
					message-mode gnus-group-mode gnus-article-mode score-mode
					gnus-browse-killed-mode)) "Mail") 
	 (t
	  ;; Return `mode-name' if not blank, `major-mode' otherwise.
	  (if (and (stringp mode-name)
		   ;; Take care of preserving the match-data because this
		   ;; function is called when updating the header line.
		   (save-match-data (string-match "[^ ]" mode-name))) mode-name (symbol-name major-mode))))))

(setq tabbar-buffer-groups-function 'tabbar-buffer-groups)
;;;
(provide 'mod-tabbar)
