;; -*- lexical-binding: t -*-
;; mod-git.el --- This is where you apply your OCD.
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
(package-require 'git-gutter)
(custom-set-variables ;;
 '(git-gutter:window-width 2) 
 ;; '(git-gutter:modified-sign "☁") 
 ;; '(git-gutter:added-sign "☀") 
 ;; '(git-gutter:deleted-sign "☂")
 '(git-gutter:handled-backends '(git hg bzr svn)))

(global-git-gutter-mode +1)
;;
(package-download 'magit)
(global-set-key (kbd "C-x g") 
                (lambda () 
                  (internal-require 'magit) 
                  (magit-status)))
(global-set-key (kbd "C-x M-g") 
                (lambda () 
                  (internal-require 'magit) 
                  (magit-dispatch-popup)) )
;;
;; `magithub'
;; (use-package magithub
;; :after magit
;; :config
;; (magithub-feature-autoinject t)
;; (setq magithub-clone-default-directory "~/github"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-git)
;; mod-git.el ends here
