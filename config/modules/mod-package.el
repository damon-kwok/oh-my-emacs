;; -*- lexical-binding: t -*-
;; mod-package.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2015-2015 Damon Kwok
;;
;; Author: gww <DamonKwok@msn.com>
;; Date: 2015-12-31
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
;; `(online?)` is a function that tries to detect whether you are online.
;; We want to refresh our package list on Emacs start if we are.

;; required-at-runtime
;; (eval-when-compile
;;   (require 'cl))

(with-no-warnings 
  (require 'cl))

(require 'package)
;; (setq package-user-dir (concat dotfiles-dir "elpa"))
(setq package-user-dir "~/elpa")

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

;; To get the package manager going, we invoke its initialise function.
(package-initialize)

(defun package-require(pkg) 
  (when (not package-archive-contents) 
    (package-refresh-contents)) 
  (when (not (package-installed-p pkg)) 
    (package-install pkg)))

(defun package-require-git(lib-name path)
  ;;(setq dir-lib-name (expand-file-name "~/libraries" ))
  (setq dir-name (concat (expand-file-name "~/libraries") "/" (file-name-base lib-name))) 
  (setq full-name (concat dir-name "/" lib-name)) 
  (setq cmd-update (concat "git fetch")) 
  (setq cmd-clone (concat "git clone " path " " lib-name)) 
  (add-to-list 'load-path dir-name) 
  (make-directory "~/libraries" t) 
  (message dir-name) 
  (if (file-exists-p dir-name) 
      (progn 
	(setq default-directory dir-name) 
	(call-process-shell-command cmd-update nil t)) 
    (progn 
      (setq default-directory "~/libraries") 
      (call-process-shell-command cmd-clone nil t))))

(defun package-require-svn(lib-name path)
  ;;(setq dir-lib-name (expand-file-name "~/libraries" ))
  (setq dir-name (concat (expand-file-name "~/libraries") "/" (file-name-base lib-name))) 
  (setq full-name (concat dir-name "/" lib-name)) 
  (setq cmd-update (concat "svn up")) 
  (setq cmd-clone (concat "svn co " path " " lib-name)) 
  (add-to-list 'load-path dir-name) 
  (make-directory "~/libraries" t) 
  (message dir-name) 
  (if (file-exists-p dir-name) 
      (progn 
	(setq default-directory dir-name) 
	(call-process-shell-command cmd-update nil t)) 
    (progn 
      (setq default-directory "~/libraries") 
      (call-process-shell-command cmd-clone nil t))))


(defun package-require-curl(file-name path)
  ;;(setq dir-lib-name (expand-file-name "~/libraries" ))
  (setq dir-name (concat (expand-file-name "~/libraries") "/" (file-name-base file-name))) 
  (setq full-name (concat dir-name "/" file-name)) 
  (setq cmd (concat "curl -o " full-name  " " path)) 
  (add-to-list 'load-path dir-name) 
  (make-directory dir-name t) 
  (unless (file-exists-p full-name) 
    (call-process-shell-command cmd nil t)))

;;(auto-install-from-url "https://raw.github.com/aki2o/guide-key-tip/master/guide-key-tip.el")

(defun package-update() 
  (interactive) 
  (package-list-packages t) 
  (package-refresh-contents))

(defun package-upgrade() 
  (interactive)
  ;; upgrade installed
  (save-window-excursion (package-list-packages t) 
			 (package-menu-mark-upgrades) 
			 (package-menu-mark-obsolete-for-deletion) 
			 (package-menu-execute t)))

(defun package-dist-upgrade() 
  (interactive) 
  (package-update) 
  (package-upgrade)) ;;(package-autoremove)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
(provide 'mod-package)

