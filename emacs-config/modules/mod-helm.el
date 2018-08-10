;; -*- lexical-binding: t -*-
;; mod-helm.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2015-2016 Damon Kwok
;;
;; Author: gww <damon-kwok@outlook.com>
;; Date: 2016-01-04
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'mod-package)
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`Projectile';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`bm';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; or if you want use this feature in your library: (bm-bookmark-add nil nil t)
;; (package-require 'bm)
;; (require 'bm)

;;; M$ Visual Studio key setup.
;; (global-set-key (kbd "<C-f2>") 'bm-toggle)
;; (global-set-key (kbd "<f2>")   'bm-next)
;; (global-set-key (kbd "<S-f2>") 'bm-previous)

;;; Click on fringe to toggle bookmarks, and use mouse wheel to move between them.
;; (global-set-key (kbd "<left-fringe> <mouse-5>") 'bm-next-mouse)
;; (global-set-key (kbd "<left-fringe> <mouse-4>") 'bm-previous-mouse)
;; (global-set-key (kbd "<left-fringe> <mouse-1>") 'bm-toggle-mouse)

;;; If you would like the markers on the right fringe instead of the left, add the following line:
;; (setq bm-marker 'bm-marker-right)

;;; If you would like to cycle bookmark in LIFO order, add the following line:
;; (setq bm-in-lifo-order t)

;;; If you would like to cycle through bookmarks in all open buffers, add the following line:
;; (setq bm-cycle-all-buffers t)

;;; If you would like to remove bookmark after jump to it by bm-next or bm-previous:
;; (setq temporary-bookmark-p t)

;; `bookmark'
(global-set-key (kbd "C-x r l") 'helm-bookmarks)
(global-set-key (kbd "C-x r d") 'bookmark-delete)
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`helm';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(package-require 'helm)
(require 'helm-config)
(require 'helm)

;;; Activate Helm.
(helm-mode 1)

;;; Replace common selectors with Helm versions.
(global-set-key (kbd "M-x") 'helm-M-x)
;;(global-set-key (kbd "C-c i") 'helm-imenu)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
;; (global-set-key (kbd "C-x c g") 'helm-google-suggest)
;; (global-set-key (kbd "C-x C-g") 'helm-do-grep)

;;; A binding for using Helm to pick files using Projectile,
;;; and override the normal grep with a Projectile based grep.
;; (package-require 'helm-projectile)
;; (require 'helm-projectile)
;; (global-set-key (kbd "C-c C-f") 'helm-projectile-find-file-dwim)
;; (global-set-key (kbd "C-x C-g") 'helm-projectile-grep)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; `helm-swiper-helm'
;;; Enrich isearch with Helm using the `C-S-s' binding.
;;; swiper-helm behaves subtly different from isearch, so let's not
;;; override the default binding.
;; (package-require 'swiper-helm)
;; (require 'swiper-helm)
;; (global-set-key (kbd "C-M-s") 'swiper-helm)

;; `helm-swoop'
;; (package-require 'helm-swoop)
;; (require 'helm-swoop)
;; (global-set-key (kbd "C-M-s") 'helm-swoop)

;;; ac-helm
;; (package-require 'ac-helm)
;; (require 'ac-helm)

;;; helm-company
;; (package-require 'helm-company)
;; (require 'helm-company)

;;; Tell Helm to resize the selector as needed.
(helm-autoresize-mode 1)

;;; Make Helm look nice.
(setq-default helm-display-header-line nil
              helm-autoresize-min-height 20
              helm-autoresize-max-height 35
              helm-split-window-in-side-p t

              helm-M-x-fuzzy-match t
              helm-buffers-fuzzy-matching t
              helm-recentf-fuzzy-match t
              helm-apropos-fuzzy-match t)

(set-face-attribute 'helm-source-header nil :height 0.75)

;;; Keybinding
(define-key helm-map (kbd "<tab>")  'helm-execute-persistent-action)
(define-key helm-map (kbd "<escape>")  'helm-keyboard-quit)

;;; `helm-bm'
(package-require 'helm-bm)
(require 'helm-bm) ;;; Not necessary if using ELPA package
(global-set-key (kbd "C-c b") 'helm-bm)

;;; `helm-ag' (need ag)
(package-require 'helm-ag)
(require 'helm-ag)

;;; helm-is-git hg svn
(package-require 'helm-ls-svn)
(require 'helm-ls-svn)

(package-require 'helm-ls-git)
(require 'helm-ls-git)

(package-require 'helm-ls-hg)
(require 'helm-ls-hg)

;;; (package-require 'helm-buffer-list)
(package-require 'helm-descbinds)
(require 'helm-descbinds)
(helm-descbinds-mode)

;;; helm-pages
(package-require 'helm-pages)
(require 'helm-pages)

;;; helm-xref
(package-require 'helm-xref)
(require 'helm-xref)
(setq xref-show-xrefs-function 'helm-xref-show-xrefs)

;;; `helm-company'
(package-require 'helm-company)
(autoload 'helm-company "helm-company") ;; Not necessary if using ELPA package
(eval-after-load 'company '(progn (define-key company-mode-map (kbd "C-:") 'helm-company) 
								  (define-key company-active-map (kbd "C-:") 'helm-company)))

;; don't super tty
;; (package-require 'company-quickhelp)
;; (company-quickhelp-mode 1)
;; (setq company-quickhelp-delay 0.5)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
(provide 'mod-helm)
