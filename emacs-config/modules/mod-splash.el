;; -*- lexical-binding: t -*-
;; mod-splash.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2018 damon-kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2018-08-10
;; Modify: 2018-08-10
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
(package-require 'dashboard)
(require 'dashboard)
(dashboard-setup-startup-hook)
(setq dashboard-banner-logo-title "Oh My Emacs!")
(setq dashboard-items '((projects . 15) 
						(recents  . 20) 
						(bookmarks . 7) 
						(agenda . 5) 
						(registers . 5)))

(setq dashboard-startup-banner "~/.oh-my-emacs/logo.png")

(add-to-list 'dashboard-items '(agenda) t)
(setq show-week-agenda-p t)





;;; enable/disable loading page (t:disable nil:enable)
(setq inhibit-startup-message t)
(setq inhibit-startup-screen t)
(setq inhibit-splash-screen t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-splash)
;; mod-splash.el ends here
