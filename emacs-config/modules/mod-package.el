;; -*- lexical-binding: t -*-
;; mod-package.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2015-2015 damon-kwok
;;
;; Author: gww <damon-kwok@outlook.com>
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

;; (require 'package)
;; (package-initialize)

;; (setq package-user-dir (concat dotfiles-dir "elpa"))
;; (setq package-user-dir "~/elpa")
(setq ome-lib-dir "~/.emacs.d/libs")
(make-directory ome-lib-dir t)

(setq ome-dev-dir "~/.ome_local/caches")
(make-directory ome-dev-dir t)
;; (setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
;;                         ("org" . "http://orgmode.org/elpa/")))
;; (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)



(setq package-archives '(;;
                         ;;("gnu" . "https://elpa.gnu.org/packages/")
                         ;;("org" . "http://orgmode.org/elpa/")
                         ;;("melpa" . "https://melpa.org/packages/")
                         ;;
                         ;;("gnu-china" . "http://elpa.emacs-china.org/gnu/")
                         ;;("melpa-china" . "http://elpa.emacs-china.org/melpa/")
                         ;;("org-china" . "http://elpa.emacs-china.org/org/")
             			 ("gnu-china" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/") 
                         ("melpa-china" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/") 
                         ("org-china" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
                         ;;
                         ))
;; (add-to-list 'package-archives '("popkit" . "http://elpa.popkit.org/packages/"))
;;(add-to-list 'load-path "~/emacs-config/elpa-mirror")
;;(require 'elpa-mirror)

(defun online? () 
  (if (and (functionp 'network-interface-list) 
           (network-interface-list)) 
      (some (lambda (iface) 
              (unless (equal "lo" (car iface)) 
                (member 'up (first (last (network-interface-info (car iface))))))) 
            (network-interface-list)) t))

;; (when (online?)
;; (unless package-archive-contents (package-refresh-contents)))

;; To get the package manager going, we invoke its initialise function.
(defun package-require(pkg) 
  (when (not (package-installed-p pkg)) 
    (progn (unless package-archive-contents (package-refresh-contents)) 
           (package-install pkg))))

(defun package-require-git(lib-name path)
  ;; (setq dir-lib-name (expand-file-name ome-lib-dir ))
  (setq dir-name (concat (expand-file-name ome-lib-dir) "/" (file-name-base lib-name))) 
  (setq full-name (concat dir-name "/" lib-name)) 
  (setq cmd-update (concat "git fetch")) 
  (setq cmd-clone (concat "git clone " path " --depth=1 " lib-name)) 
  (add-to-list 'load-path dir-name) 
  (make-directory ome-lib-dir t) 
  (message dir-name) 
  (if (file-exists-p dir-name) 
      (progn 
        (setq default-directory dir-name) 
        (call-process-shell-command cmd-update nil t)) 
    (progn 
      (setq default-directory ome-lib-dir) 
      (call-process-shell-command cmd-clone nil nil t))))

(defun package-require-svn(lib-name path)
  ;;(setq dir-lib-name (expand-file-name ome-lib-dir ))
  (setq dir-name (concat (expand-file-name ome-lib-dir) "/" (file-name-base lib-name))) 
  (setq full-name (concat dir-name "/" lib-name)) 
  (setq cmd-update (concat "svn up")) 
  (setq cmd-clone (concat "svn co " path " " lib-name)) 
  (add-to-list 'load-path dir-name) 
  (make-directory ome-lib-dir t) 
  (message dir-name) 
  (if (file-exists-p dir-name) 
      (progn 
        (setq default-directory dir-name) 
        (call-process-shell-command cmd-update nil t)) 
    (progn 
      (setq default-directory ome-lib-dir) 
      (call-process-shell-command cmd-clone nil nil t))))


(defun package-require-curl(dir-name file-name url)
  ;; (setq dir-lib-name (expand-file-name ome-lib-dir ))
  (setq dir (concat (expand-file-name ome-lib-dir) "/" dir-name)) 
  (make-directory dir t) 
  (setq default-directory dir) 
  (setq full-name (concat dir "/" file-name))
  ;; (setq cmd (concat "curl -o " full-name  " " path))
  (setq cmd (concat "curl -O " url)) 
  (add-to-list 'load-path dir) 
  (unless (file-exists-p full-name) 
    (call-process-shell-command cmd nil nil t)))

;; (defun package-require-curl(dir-name file-name url)
;;   ;; (setq dir-lib-name (expand-file-name ome-lib-dir ))
;;   (setq dir (concat (expand-file-name ome-lib-dir) "/" dir-name))
;;   (make-directory dir t)
;;   (setq default-directory dir)
;;   (setq full-name (concat dir "/" file-name))
;;   ;; (setq cmd (concat "curl -o " full-name  " " path))
;;   (setq cmd (concat "curl -O " url))
;;   (add-to-list 'load-path dir)
;;   (unless (file-exists-p full-name)
;;     (ome-run-command cmd)))

;; (defun package-require-curl(file-name path)
;;   ;; (setq dir-lib-name (expand-file-name ome-lib-dir ))
;;   (setq dir-name (concat (expand-file-name ome-lib-dir) "/" (file-name-base file-name)))
;;   (setq full-name (concat dir-name "/" file-name))
;;   (setq cmd (concat "curl -o " full-name  " " path))
;;   ;;(setq cmd (concat "curl -O " path))
;;   (message cmd)
;;   (add-to-list 'load-path dir-name)
;;   (make-directory dir-name t)
;;   (unless (file-exists-p full-name)
;;     (ome-run-command cmd)))

;; (auto-install-from-url "https://raw.github.com/aki2o/guide-key-tip/master/guide-key-tip.el")

(defun package-update() 
  (interactive) 
  (save-window-excursion (package-list-packages t) 
                         (package-refresh-contents)))

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
  (package-autoremove) 
  (package-upgrade))

;; `use-package'
(package-require 'use-package)
(require 'use-package)


;; `quelpa'
(package-require 'quelpa)
(require 'quelpa)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
(provide 'mod-package)
