;; -*- lexical-binding: t -*-
;; mod-basic.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2015-2016 Damon Kwok
;;
;; Author: damon-kwok <damon-kwok@outlook.com>
;; Date: 2016-02-16
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
;;
(require 'mod-package)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`frame';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun no-split-window ()
;; (interactive)
;; nil)
;; (setq split-window-preferred-function 'no-split-window)

;; (setq compilation-window-height 1000)
;; (setq compilation-window-width 1000)
;; (setq same-window-regexps '("."))

;; (defun kill-compile-buffer-if-successful (buffer string)
;; " kill a compilation buffer if succeeded without warnings "
;; (if (and
;; (string-match "compilation" (buffer-name buffer))
;; (string-match "finished" string)
;; (not
;; (with-current-buffer buffer
;; (search-forward "warning" nil t))))
;; (run-with-timer 1 nil
;; 'kill-buffer
;; buffer)))
;; (add-hook 'compilation-finish-functions 'kill-compile-buffer-if-successful)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`Theme';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (package-require 'django-theme)

;; (if (display-graphic-p)
;;     (require 'django-theme)
;; (load-theme 'deeper-blue))

;; (load-theme 'wombat)

;; (load-theme 'deeper-blue)

;; (package-download 'sublime-themes)
;; (load-theme 'granger t t)
;; (enable-theme 'granger)

;; (package-download 'color-theme-modern)

;; (if (display-graphic-p)
;;     (progn ;;
;;       ;;(load-theme 'gray30 t t)
;;       ;;(enable-theme 'gray30)
;;       ;;(load-theme 'deeper-blue)
;;       ;;(enable-theme 'deeper-blue)
;;       ;; load material theme
;;       (package-download 'material-theme)
;;       (load-theme 'material t)
;;       ;;
;;       )
;;   (progn
;;     ;;
;;     ;;(load-theme 'xemacs t t)
;;     ;;(enable-theme 'xemacs)
;;     ;;(load-theme 'deeper-blue)
;;     ;;(enable-theme 'deeper-blue)
;;     (package-download 'material-theme)
;;     (load-theme 'material t)
;;     ;;
;;     ))

;;; oh-my-emacs theme
;;(load-theme 'ome t t)
;;(enable-theme 'ome)

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
;;(load-theme 'ome-xemacs t t)
;;(enable-theme 'ome-xemacs)

;;(package-require 'monokai-theme)
;;(load-theme 'monokai t t)
;;(enable-theme 'monokai)

;; (load-theme 'fischmeister t t)
;; (enable-theme 'fischmeister)

;; (internal-require 'pink-bliss)
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

;; (package-require 'doom-themes)
;; ;; Global settings (defaults)
;;   (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;         doom-themes-enable-italic t) ; if nil, italics is universally disabled
;; (load-theme 'material t)
;; (package-download 'immaterial-theme)
;; (load-theme 'immaterial t)
;; (load-theme 'doom-oceanic-next t)
;; (load-theme 'doom-material t)
;; ;; (load-theme 'doom-one t)
;; ;; (load-theme 'doom-city-lights t)
;; ;; (load-theme 'doom-dracula t)
;; ;; (load-theme 'doom-nord t)
;; ;; (load-theme 'doom-nova t)
;; ;; (load-theme 'doom-opera t)
;; ;; (load-theme 'doom-solarized-dark t)
;; ;; (load-theme 'doom-spacegrey t)
;; ;; (load-theme 'doom-wilmersdorf t)


;;   ;; Enable flashing mode-line on errors
;;   (doom-themes-visual-bell-config)

;;   ;; Enable custom neotree theme (all-the-icons must be installed!)
;;   (doom-themes-neotree-config)
;;   ;; or for treemacs users
;;   (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
;;   (doom-themes-treemacs-config)

;;   ;; Corrects (and improves) org-mode's native fontification.
;; (doom-themes-org-config)

;;(let ((height (face-attribute 'default :height)))
  ;; for all linum/nlinum users
;;  (set-face-attribute 'linum nil :height height)
  ;; only for `linum-relative' users:
;;  (set-face-attribute 'linum-relative-current-face nil :height height)
  ;; only for `nlinum-relative' users:
;;  (set-face-attribute 'nlinum-relative-current-face nil :height height))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`base-config';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; '`error'
(setq debug-on-error t) ;; M-x toggle-debug-on-error
;; (typo-err)



;;; show error message to tip area
;;(condition-case err
;;	(progn
;;		(require 'xxx) )
;;    (error
;;    (message "Can't load xxx-mode %s" (cdr err))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`title';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`other-setting';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; image mode
(auto-image-file-mode t)
(setq mm-inline-large-images t)
;; (add-to-list 'mm-attachment-override-types "/image/*")
(autoload 'thumbs "thumbs" "Preview images in a directory." t) ;;thumbs-mode

;;; `eldoc'
(global-eldoc-mode 1)

;;; `large-file
(package-require 'vlf 'vlf-setup)
(custom-set-variables '(vlf-application 'dont-ask))

;;abbrev-mode
;;Abbrev-mode always open
;;(setq default-abbrev-mode t)
;;(setq abbrev-file-name          ;; tell emacs where to read abbrev
;;      "~/.emacs.d/abbrev_defs") ;; definitions from...
;;(setq save-abbrevs t)           ;; save abbrevs when files are saved
;; you will be asked before the abbreviations are saved
;;(quietly-read-abbrev-file) ;; reads the abbreviations file on startup
;;Avoid errors if the abbrev-file is missing
;;(if (file-exists-p abbrev-file-name)
;;    (quietly-read-abbrev-file))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
(provide 'mod-basic)
;; mod-basic.el ends here
