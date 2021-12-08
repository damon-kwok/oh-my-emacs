;; -*- lexical-binding: t -*-
;; mod-package.el --- This is where you apply your OCD.
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

(setq package-check-signature nil)
;; (setq package-check-signature 'allow-unsigned)

;; `(online?)` is a function that tries to detect whether you are online.
;; We want to refresh our package list on Emacs start if we are.

;; required-at-runtime
;; (eval-when-compile
;;   (internal-require 'cl))

;; (with-no-warnings (internal-require 'cl))
(internal-require 'cl-lib)

;; (internal-require 'package)
;; (package-initialize)

;; (setq package-user-dir (concat dotfiles-dir "elpa"))
;; (setq package-user-dir "~/elpa")
(setq ome-lib-dir "~/.emacs.d/libs")
(make-directory ome-lib-dir t)


;; (setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
;;                         ("org" . "http://orgmode.org/elpa/")))
;; (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

(setq package-archives ;;
      '(;;
        ("gnu" . "https://elpa.gnu.org/packages/") 
        ("melpa" . "https://melpa.org/packages/")
        ("org" . "https://orgmode.org/elpa/")
        ;;
        ;;("gnu-china" . "https://elpa.zilongshanren.com/gnu/")
        ;;("melpa-china" . "https://elpa.zilongshanren.com/melpa/")
        ;;("melpa-stable-china" . "http://elpa.emacs-china.org/stable-melpa/")
        ;;("org-china" . "https://elpa.zilongshanren.com/org/")
        ;;
        ;;'("popkit" . "http://elpa.popkit.org/packages/")
        ;;
        ;; ("gnu-tuna" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ;; ("melpa-tuna" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
        ;; ("org-tuna" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
        ;;
        ;; ("gnu-ustc" . "https://mirrors.ustc.edu.cn/elpa/gnu/")
        ;; ("melpa-ustc" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
        ;; ("melpa-stable-ustc" . "https://mirrors.ustc.edu.cn/elpa/melpa-stable/")
        ;;("org-ustc" . "https://mirrors.ustc.edu.cn/elpa/org/")
        ))

;;(add-to-list 'load-path "~/conf/elpa-mirror")
;;(internal-require 'elpa-mirror)

(defun online? () 
  (if (and (functionp 'network-interface-list) 
           (network-interface-list)) 
      (some (lambda (iface) 
              (unless (equal "lo" (car iface)) 
                (member 'up (first (last (network-interface-info (car
                                                                  iface))))))) 
            (network-interface-list)) t))

;; (when (online?)
;; (unless package-archive-contents (package-refresh-contents)))
(unless package-archive-contents (package-refresh-contents))

(defun lazy-require (ext mode) 
  (add-hook 'find-file-hook             ;
            `(lambda () 
               (when (and (stringp buffer-file-name) 
                          (string-match (concat "\\." ,ext "\\'")
                                        buffer-file-name)) 
                 (internal-require (quote ,mode)) 
                 (,mode)))))

;; (lazy-require "soy" 'soy-mode)
;; (lazy-require "tpl" 'tpl-mode)

;; To get the package manager going, we invoke its initialise function.
(defun package-download (pkg) 
  (when (not (package-installed-p pkg)) 
    (progn (package-refresh-contents) 
           (package-install pkg))))

(defun package-require(pkg &optional alias-pkg alias-pkg2) 
  (package-download pkg) 
  (if alias-pkg (internal-require alias-pkg) 
    (internal-require pkg)) 
  (if alias-pkg2 (internal-require alias-pkg2)))

(defun package-download-git(lib-name repo) 
  (let* ((oldir default-directory) 
         (ome-lib-dir-git (concat ome-lib-dir "/git")) 
         (dir-name (concat ome-lib-dir-git "/" (file-name-base lib-name))) 
         (cmd-update (concat "git pull")) 
         (cmd-clone (concat "git clone " repo " --depth=1 " lib-name))) 
    (make-directory ome-lib-dir-git t) 
    (add-to-list 'load-path dir-name) 
    (message "dir-name:%s" dir-name) 
    (if (file-exists-p dir-name) 
        (progn
          ;; (setq default-directory dir-name)
          ;; (ome-run-command cmd-update)
          ) 
      (progn 
        (setq default-directory ome-lib-dir-git) 
        (ome-run-command cmd-clone))) 
    (setq default-directory oldir)))

(defun package-require-git(dir-name file-name url) 
  (let* ((pkg (intern dir-name))) 
    (package-download-git dir-name) 
    (internal-require pkg)))

(defun package-download-svn(lib-name path) 
  (let* ((oldir default-directory) 
         (ome-lib-dir-svn (concat ome-lib-dir "/svn")) 
         (dir-name (concat ome-lib-dir-svn "/" (file-name-base lib-name))) 
         (cmd-update (concat "svn up")) 
         (cmd-clone (concat "svn co " path lib-name))) 
    (make-directory ome-lib-dir-svn t) 
    (add-to-list 'load-path dir-name) 
    (if (file-exists-p dir-name) 
        (progn
          ;; (setq default-directory dir-name)
          ;; (call-process-shell-command cmd-update nil t)
          ) 
      (progn 
        (setq default-directory ome-lib-dir-svn) 
        (call-process-shell-command cmd-clone nil nil t))) 
    (setq default-directory oldir)))

(defun package-require-svn(dir-name file-name url) 
  (let* ((pkg (intern dirname))) 
    (package-download-svn dir-name) 
    (internal-require pkg)))

(defun package-download-curl(dir-name file-name url) 
  (let* ((oldir default-directory) 
         (dir (concat ome-lib-dir "/curl/" dir-name)) 
         (full-name (concat dir "/" file-name)) 
         (cmd (concat "curl -o " full-name " " url))) 
    (make-directory dir t) 
    (add-to-list 'load-path dir) 
    (setq default-directory dir-name) 
    (unless (file-exists-p full-name) 
      (progn 
        (setq default-directory dir) 
        (call-process-shell-command cmd nil nil t))) 
    (setq default-directory oldir)))

(defun package-require-curl(dir-name file-name url) 
  (let* ((pkg (intern dir-name))) 
    (package-download-curl dir-name file-name url) 
    (internal-require pkg)))

(defun package-update() 
  (interactive) 
  (save-window-excursion (package-list-packages t) 
                         (package-refresh-contents)))

(defun package-upgrade() 
  "Upgrade installed" 
  (interactive) 
  (save-window-excursion (package-list-packages t) 
                         (package-menu-mark-upgrades) 
                         (package-menu-mark-obsolete-for-deletion) 
                         (package-menu-execute t)))

(defun package-dist-upgrade() 
  (interactive) 
  (package-update) 
  (package-upgrade) 
  (package-autoremove))

;; `use-package'
(package-require 'use-package)

;; `quelpa'
;; (package-require 'quelpa)

;;
;; (auto-install-from-url "https://raw.github.com/aki2o/guide-key-tip/master/guide-key-tip.el")

(package-download-curl "xcowsay" "xcowsay.el"
                       "https://www.emacswiki.org/emacs/download/xcowsay.el")

(package-download-curl "pink-bliss" "pink-bliss-theme.el"
                       "https://raw.githubusercontent.com/kensanata/elisp/master/pink-bliss-theme.el")
(package-download-curl "pink-bliss" "pink-bliss.el"
                       "https://www.emacswiki.org/emacs/download/pink-bliss.el")
(package-download-curl "pink-bliss" "pink-gnu.xpm"
                       "http://www.emacswiki.org/emacs/download/pink-gnu.xpm")

(package-download-curl "visws" "visws.el"
                       "https://www.emacswiki.org/emacs/download/visws.el")

(package-download-curl "multi-term" "multi-term.el"
                       "https://www.emacswiki.org/emacs/download/multi-term.el")
(setq multi-term-program "/bin/bash")

(package-require 'package-lint)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
(provide 'mod-package)
