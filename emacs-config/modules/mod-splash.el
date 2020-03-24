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
(package-require 'all-the-icons)
;; (package-require 'spaceline-all-the-icons)
;; (spaceline-all-the-icons-theme)
(package-require 'dashboard)
(page-break-lines-mode (if (display-graphic-p) 1 -1))
(dashboard-setup-startup-hook)

;; Set the title
(setq dashboard-banner-logo-title "Oh My Emacs!")

;; Set the banner
(setq dashboard-startup-banner (if (display-graphic-p) (expand-file-name "~/.oh-my-emacs/logo.png") 1))
;; Value can be
;; 'official which displays the official emacs logo
;; 'logo which displays an alternative emacs logo
;; 1, 2 or 3 which displays one of the text banners
;; "path/to/your/image.png" which displays whatever image you would prefer

;; Content is not centered by default. To center, set
(setq dashboard-center-content nil)

;; To disable shortcut "jump" indicators for each section, set
(setq dashboard-show-shortcuts t)

;; To customize which widgets are displayed, you can use the following snippet
(setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 5)
                        (agenda . 5)
                        (registers . 5)))

;; (setq show-week-agenda-p t)

(defun dashboard-insert-custom (list-size)
  (insert "Custom text"))
(add-to-list 'dashboard-item-generators  '(custom . dashboard-insert-custom))
(add-to-list 'dashboard-items '(custom) t)

(setq dashboard-set-heading-icons (display-graphic-p))
(setq dashboard-set-file-icons (display-graphic-p))

(dashboard-modify-heading-icons '((recents . "file-text")
                                  (bookmarks . "book")))

(setq dashboard-set-navigator nil)

;; Format: "(icon title help action face prefix suffix)"
(setq dashboard-navigator-buttons
      `(;; line1
        ((,(all-the-icons-octicon "mark-github" :height 1.1 :v-adjust 0.0)
         "Homepage"
         "Browse homepage"
         (lambda (&rest _) (browse-url "homepage")))
        ("★" "Star" "Show stars" (lambda (&rest _) (show-stars)) warning)
        ("?" "" "?/h" #'show-help nil "<" ">"))
         ;; line 2
        ((,(all-the-icons-faicon "linkedin" :height 1.1 :v-adjust 0.0)
          "Linkedin"
          ""
          (lambda (&rest _) (browse-url "homepage")))
         ("?" nil "Show flags" (lambda (&rest _) (message "flag")) error))))

;; To show info about the packages loaded and the init time:
(setq dashboard-set-init-info (display-graphic-p))

;; Also, the message can be customized like this:
(setq dashboard-init-info "Oh my Emacs!")

;; A randomly selected footnote will be displayed. To disable it:
(setq dashboard-set-footer (display-graphic-p))

;; To customize it and customize its icon;
(setq dashboard-footer-messages '("Dashboard is pretty cool!"))
(setq dashboard-footer-icon (all-the-icons-octicon "dashboard"
                                                   :height 1.1
                                                   :v-adjust -0.05
                                                   :face 'font-lock-keyword-face))
;; Org mode’s agenda
(setq show-week-agenda-p t)
(setq dashboard-org-agenda-categories '("Tasks" "Appointments"))


;;; enable/disable loading page (t:disable nil:enable)
;; (setq inhibit-startup-message t)
;; (setq inhibit-startup-screen t)
;; (setq inhibit-splash-screen t)

;;(dashboard-setup-startup-hook)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-splash)
;; mod-splash.el ends here
