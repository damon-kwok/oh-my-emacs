;; -*- lexical-binding: t -*-
;; mod-tabbar.el --- This is where you apply your OCD.
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
(require 'mod-package)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`tabbar';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (package-download 'tabbar-ruler)

;; (setq tabbar-ruler-global-tabbar t)	; get tabbar
;; (setq tabbar-ruler-global-ruler nil)	; get global ruler
;; (setq tabbar-ruler-popup-menu nil)	; get popup menu.
;; (setq tabbar-ruler-popup-toolbar nil)	; get popup toolbar
;; (setq tabbar-ruler-popup-scrollbar nil)	; show scroll-bar on mouse-move
;; (internal-require 'tabbar-ruler)

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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; tabbar
(package-require 'tabbar)
(tabbar-mode t)

;;; cycle: `tabs' `groups' `default'
(setq tabbar-cycle-scope 'tabs)

;;(ome-keymap-unset-key (kbd "C-c C-<home>") "tabbar-mode")
;;(ome-keymap-unset-key (kbd "C-c <C-f10>") "tabbar-mode")
;;(ome-keymap-unset-key (kbd "C-c <C-left>") "tabbar-mode")
;;(ome-keymap-unset-key (kbd "C-c <C-right>") "tabbar-mode")
;;(ome-keymap-unset-key (kbd "C-c <C-up>") "tabbar-mode")
;;(ome-keymap-unset-key (kbd "C-c <C-down>") "tabbar-mode")
;;(ome-keymap-unset-key (kbd "C-c <C-prior>") "tabbar-mode")
;;(ome-keymap-unset-key (kbd "C-c <C-next>") "tabbar-mode")

(defun ome-number
    (&optional
     num)
  (if (numberp num) num 0))

(defun ome-inc
    (&optional
     num)
  (if (numberp num)
      (+ 1 num) 1))

(defun ome-dec
    (&optional
     num)
  (if (numberp num)
      (- num 1) -1))

(defun ome-tabbar-forward
    (&optional
     num)
  (interactive)
  (tabbar-forward)
  ;; (message (concat "--group:" (ome-number num)))
  (if (and (or (s-match "^*" (buffer-name))
               (s-match "^:" (buffer-name)))
           (< (ome-number num) 5))
      (ome-tabbar-forward (ome-inc num))))

(defun ome-tabbar-backward
    (&optional
     num)
  (interactive)
  (tabbar-backward)
  (if (and (or (s-match "^*" (buffer-name))
               (s-match "^:" (buffer-name)))
           (< (ome-number num) 5))
      (ome-tabbar-backward (ome-inc num))))

(defun ome-tabbar-forward-group
    (&optional
     num)
  (interactive)
  (tabbar-forward-group)
  ;; (message (concat "--group:" (ome-number num)))
  (if (and (or (s-match "^*" (buffer-name))
               (s-match "^:" (buffer-name)))
           (< (ome-number num) 5))
      (ome-tabbar-forward-group (ome-inc num))))

(defun ome-tabbar-backward-group
    (&optional
     num)
  (interactive)
  (tabbar-backward-group)
  (if (and (or (s-match "^*" (buffer-name))
               (s-match "^:" (buffer-name)))
           (< (ome-number num) 5))
      (ome-tabbar-backward-group (ome-inc num))))

(global-set-key (kbd "C-M-'") 'tabbar-forward)
(global-set-key (kbd "C-M-;") 'tabbar-backward)

(global-set-key (kbd "C-M-[") 'ome-tabbar-forward-group)
(global-set-key (kbd "C-M-/") 'ome-tabbar-backward-group)

;; DarkGreen LightGoldenrod DarkGoldenrod gold DarkGreen #00B2BF #330000 gray60 grey gray #383838

;;; DarkBlue
;; (set-face-attribute 'tabbar-default nil
;; 		    ;; :family "DejaVu Sans Mono"
;; 		    ;;:inherit 'tabbar-default
;; 		    :background "#1A1A2A"
;; 		    :height 1.0)

;; (set-face-attribute 'tabbar-button nil
;; 		    :inherit 'tabbar-default
;; 		    :background "#181A26"
;; 		    :box '(:line-width 1
;; 				       :color "gray")
;; 		    :overline "gray"
;; 		    :underline "#181A26") ;;down

;; (set-face-attribute 'tabbar-unselected nil
;; 		    :inherit 'tabbar-default
;; 		    :foreground "gray"  ;;"DarkGreen"
;; 		    :background "#181A26" ;;LightGoldenrod
;; 		    :box '(:line-width 1
;; 				       :color "gray") ;#00B2BF
;; 		    :overline "gray"
;; 		    :underline "#181A26" ;;down
;; 		    :weight 'bold)

;; (set-face-attribute 'tabbar-selected nil
;; 		    :inherit 'tabbar-default
;; 		    :foreground "gold"
;; 		    :background "#181A26"
;; 		    :box '(:line-width 1 ;;
;; 				       :color "#181A26")
;; 		    :overline "gray"
;; 		    :underline "#181A26" ;;down
;; 		    :weight 'bold)

;;; pink-bliss
;; (setq ome-color-bg-s "deep pink")
;; (setq ome-color-fg-s "pink")
;; (setq ome-color-bg "pink")
;; (setq ome-color-fg "deep pink")
;; (set-face-attribute 'tabbar-default nil
;; 		    ;; :family "DejaVu Sans Mono"
;; 		    ;;:inherit 'tabbar-default
;; 		    :background ome-color-bg
;; 		    :height 1.0)

;; (set-face-attribute 'tabbar-button nil
;; 		    :inherit 'tabbar-default
;; 		    :background ome-color-bg
;; 		    :box '(:line-width 1
;; 				       :color ome-color-fg)
;; 		    :overline ome-color-fg
;; 		    :underline ome-color-bg) ;;down

;; (set-face-attribute 'tabbar-unselected nil
;; 		    :inherit 'tabbar-default
;; 		    :foreground ome-color-fg
;; 		    :background ome-color-bg
;; 		    :box '(:line-width 1
;; 				       :color ome-color-bg)
;; 		    :overline ome-color-fg
;; 		    :underline ome-color-fg ;;down
;; 		    :weight 'bold)

;; (set-face-attribute 'tabbar-selected nil
;; 		    :inherit 'tabbar-default
;; 		    :foreground ome-color-fg-s
;; 		    :background ome-color-bg-s
;; 		    :box '(:line-width 1 ;;
;; 				       :color ome-color-bg-s)
;; 		    :overline ome-color-fg-s
;; 		    :underline ome-color-bg-s
;; 		    :weight 'bold)

;;; xemacs
;; (set-face-attribute 'tabbar-default nil
;; 		    ;; :family "DejaVu Sans Mono"
;; 		    ;;:inherit 'tabbar-default
;; 		    :foreground "navy"
;; 		    :background "gray"
;; 		    :height 1.0)

;; (set-face-attribute 'tabbar-button nil
;; 		    :inherit 'tabbar-default
;; 		    :foreground "navy"
;; 		    :background "gray"
;; 		    :box '(:line-width 1
;; 				       :color "#330000")
;; 		    :overline "#330000"
;; 		    :underline "gray"
;; 		    :weight 'bold)

;; (set-face-attribute 'tabbar-unselected nil
;; 		    :inherit 'tabbar-default
;; 		    :foreground "navy"
;; 		    :background "gray"
;; 		    :box '(:line-width 1
;; 				       :color "#330000")
;; 		    :overline "#330000"
;; 		    :underline "gray"
;; 		    :weight 'normal)

;; (set-face-attribute 'tabbar-selected nil
;; 		    :inherit 'tabbar-default
;; 		    :foreground "gold"
;; 		    :background "navy"
;; 		    :box '(:line-width 1
;; 				       :color "#330000")
;; 		    :overline "#330000"
;; 		    :underline "navy"
;; 		    :weight 'bold)


;;; python
;; (set-face-attribute 'tabbar-default nil
;; 		    ;; :family "DejaVu Sans Mono"
;; 		    ;;:inherit 'tabbar-default
;; 		    :foreground "#b0bec5"
;; 		    :background "#263238"
;; 		    :height 1.0)
;; (set-face-attribute 'tabbar-button nil
;; 		    :inherit 'tabbar-default
;; 		    :foreground "#b0bec5" ;;#85A5A5
;; 		    :background "#263238"
;; 		    :box '(:line-width 1
;; 				       :color "#8a8a8a")
;; 		    :overline "#263238"
;; 		    :underline "#263238")
;; (set-face-attribute 'tabbar-unselected nil
;; 		    :inherit 'tabbar-default
;; 		    :foreground "#b0bec5"
;; 		    :background "#263238"
;; 		    :box '(:line-width 1
;; 				       :color "#8a8a8a")
;; 		    :overline "#263238"
;; 		    :underline "#263238"
;; 		    :weight 'normal)
;; (set-face-attribute 'tabbar-selected nil
;; 		    :inherit 'tabbar-default
;; 		    :foreground "gold"
;; 		    :background "#263238"
;; 		    :box '(:line-width 1
;; 				       :color "#8a8a8a")
;; 		    :overline "#263238"
;; 		    :underline "#263238" ;;#9ccc65
;; 		    :weight 'bold)



(defmacro def-tabbar-color
    (foreground background foreground-selected background-selected boxcolor overline underline)
  (set-face-attribute 'tabbar-default nil
                      ;; :family "Bitstream Vera Sans Mono-8" ;;
		      ;; :family "DejaVu Sans Mono"
		      :inherit 'tabbar-defaultl
                      :foreground foreground ;
		      :background background ;
		      :box '(:line-width 1
                                         :color boxcolor
					 ;;:style released-button
					 ) ;
		      :overline overline   ;
		      :underline underline ;
		      ;; :weight 'normal;
		      :height 1.0)      ;
  (set-face-attribute 'tabbar-button nil
                      :inherit 'tabbar-default
                      :foreground foreground
                      :background background
                      :overline overline
                      :underline underline)
  (set-face-attribute 'tabbar-unselected nil ;
		      :inherit 'tabbar-defaultl
                      :foreground foreground ;
		      :background background ;
		      :box '(:line-width 1
                                         :color boxcolor
					 ;;:style released-button
					 ) ;
		      :overline overline   ;
		      :underline underline ;
		      ;; :weight 'normal
                      :height 1.0)      ;
  (set-face-attribute 'tabbar-selected nil
                      :inherit 'tabbar-default        ;
		      :foreground foreground-selected ;
                      :background background-selected ;
		      :box '(:line-width 1
                                         :color boxcolor
					 ;;:style pressed-button
					 ) ;
		      :overline overline   ;
		      :underline underline ;
		      :weight 'bold
                      :height 1.0)) ;;bold

;; (set-face-attribute 'tabbar-separator nil
;; :weight 'bold)

(def-tabbar-color "#b0bec5" "#263238" "gold" "#263238" "#8a8a8a" "#263238" "#263238")
;; (def-tabbar-color "navy" "gray" "goldenrod" "navy" "red" "gray" "gray")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (setq tabbar-buffer-groups-function 'tabbar-ruler-projectile-tabbar-buffer-groups)
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
	 ((condition-case err (projectile-project-root)
            (error
             nil))
          (list (projectile-project-name)))
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

;; (setq tabbar-buffer-groups-function 'tabbar-buffer-groups)



(defvar tabbar-ruler-projectile-tabbar-buffer-group-calc nil
  "Buffer group for projectile.  Should be buffer local and speed up calculation of buffer groups.")
(defun tabbar-ruler-projectile-tabbar-buffer-groups ()
  "Return the list of group names BUFFER belongs to.
    Return only one group for each buffer."
  (if tabbar-ruler-projectile-tabbar-buffer-group-calc (symbol-value
                                                        'tabbar-ruler-projectile-tabbar-buffer-group-calc)
    (set (make-local-variable 'tabbar-ruler-projectile-tabbar-buffer-group-calc)
         (cond ;;
          ;;
          ((memq major-mode '(erc-mode))
           '("IRC"))
          ;;
          ((or
            (string-equal "#" (substring (buffer-name) 0 1))
            (string-equal "*" (substring (buffer-name) 0 1))
            (string-equal ":" (substring (buffer-name) 0 1)))
           '("Misc"))
          ;;
          ((or
            (get-buffer-process (current-buffer))
            (memq major-mode '(comint-mode compilation-mode)))
           '("Term"))
          ;;
          ((condition-case err (projectile-project-root)
             (error
              nil))
           (list (projectile-project-name)))
          ;;
          ((memq major-mode '(emacs-lisp-mode          ;
                              makefile-mode cmake-mode ;
                              ))
           '("Coding"))
          ;;
          ((memq major-mode '(javascript-mode js-mode js2-mode nxhtml-mode html-mode css-mode))
           '("Web"))
          ;;
          ((memq major-mode '(org-mode calendar-mode diary-mode))
           '("Org"))
          ;;
          ((memq major-mode '(dired-mode speedbar-mode))
           '("Dir"))
          ;;
          (t '("Main"))))
    (symbol-value 'tabbar-ruler-projectile-tabbar-buffer-group-calc)))

(setq tabbar-buffer-groups-function 'tabbar-ruler-projectile-tabbar-buffer-groups)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-tabbar)
;; mod-tabbar.el ends here
