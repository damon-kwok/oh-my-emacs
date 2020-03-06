;; -*- lexical-binding: t -*-
;; mod-helm.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2015-2016 Damon Kwok
;;
;; Author: damon-kwok <damon-kwok@outlook.com>
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
;;(internal-require 'ido)
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
(package-download 'helm)
;; (package-download 'swiper-helm)
;; (package-download 'helm-swoop)
(package-download 'helm-bm)
(package-download 'helm-ag)
(package-download 'helm-ls-svn)
(package-download 'helm-ls-git)
(package-download 'helm-ls-hg)
;;; (package-download 'helm-buffer-list)
(package-download 'helm-descbinds)
(package-download 'helm-pages)
(package-download 'helm-xref)
;; (package-download 'ac-helm)
(package-download 'helm-company)
;; (package-download 'company-quickhelp) ;; don't super tty

;; (package-download 'vlf)

;; Replace common selectors with Helm versions.
(global-set-key (kbd "M-x") 
                (lambda (arg) 
                  (interactive "P") 
                  (ome-helm-init) 
                  (helm-M-x arg)))
;;(global-set-key (kbd "C-c i") (lambda () (ome-helm-init) (helm-imenu)))
(global-set-key (kbd "C-x C-b") 
                (lambda () 
                  (interactive) 
                  (ome-helm-init) 
                  (helm-buffers-list)))
(global-set-key (kbd "C-x C-f") 
                (lambda (arg) 
                  (interactive "P") 
                  (ome-helm-init) 
                  (helm-find-files arg)))

(defun ome-helm-init()
  ;; `large-file
  ;; (internal-require 'vlf-setup)
  ;; (custom-set-variables '(vlf-application 'dont-ask))

  ;; (message "helm::")
  (internal-require 'helm-config) 
  (internal-require 'helm)
  ;; Activate Helm.
  (helm-mode 1)
  ;; Tell Helm to resize the selector as needed.
  (helm-autoresize-mode 1)

  ;; Make Helm look nice.
  (setq-default helm-display-header-line nil helm-autoresize-min-height 20
                helm-autoresize-max-height 35 helm-split-window-in-side-p t helm-M-x-fuzzy-match t
                helm-buffers-fuzzy-matching t helm-recentf-fuzzy-match t helm-apropos-fuzzy-match t) 
  (set-face-attribute 'helm-source-header nil 
                      :height 0.75)



  ;; Keybinding
  (define-key helm-map (kbd "<tab>")  'helm-execute-persistent-action) 
  (define-key helm-map (kbd "<escape>")  'helm-keyboard-quit)

  ;; (global-set-key (kbd "C-x c g") 'helm-google-suggest)
  ;; (global-set-key (kbd "C-x C-g") 'helm-do-grep)
  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; `helm-swiper-helm'
  ;; Enrich isearch with Helm using the `C-S-s' binding.
  ;; swiper-helm behaves subtly different from isearch, so let's not
  ;; override the default binding.
  ;; (internal-require 'swiper-helm)
  ;; (global-set-key (kbd "C-M-s") 'swiper-helm)

  ;; `helm-swoop'
  ;; (internal-require 'helm-swoop)
  ;; (global-set-key (kbd "C-M-s") 'helm-swoop)

  ;; ac-helm
  ;; (internal-require 'ac-helm)

  ;; helm-company
  ;; (internal-require 'helm-company)
  ;; `helm-bm'
  (internal-require 'helm-bm) ;; Not necessary if using ELPA package
  (global-set-key (kbd "C-c b") 'helm-bm)

  ;; `helm-ag' (need ag)
  (internal-require 'helm-ag)

  ;; helm-is-git hg svn
  (internal-require 'helm-ls-svn) 
  (internal-require 'helm-ls-git) 
  (internal-require 'helm-ls-hg)

  ;; (internal-require 'helm-buffer-list)
  (internal-require 'helm-descbinds) 
  (helm-descbinds-mode)

  ;; helm-pages
  (internal-require 'helm-pages)

  ;; helm-xref
  (internal-require 'helm-xref) 
  (setq xref-show-xrefs-function 'helm-xref-show-xrefs)

  ;; `helm-company'
  (package-download 'helm-company) 
  (autoload 'helm-company "helm-company") ;; Not necessary if using ELPA package
  (eval-after-load 'company '(progn (define-key company-mode-map (kbd "C-:") 'helm-company) 
                                    (define-key company-active-map (kbd "C-:") 'helm-company)))

  ;; don't super tty
  ;; (internal-require 'company-quickhelp)
  ;; (company-quickhelp-mode 1)
  ;; (setq company-quickhelp-delay 0.5)
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
(provide 'mod-helm)
