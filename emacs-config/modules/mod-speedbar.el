;; -*- lexical-binding: t -*-
;; mod-speedbar.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2017 damon-kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2017-11-14
;; Modify: 2017-11-14
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
;;==============================================================================
;;speedbar display mode
;;==============================================================================
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;speedbar
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; switch between main frame and speedbar frame.
;;(global-set-key [(f4)] 'speedbar-get-focus)
;;(global-set-key (kbd "C-c t") 'speedbar-get-focus)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;sr-speedbar
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(package-require 'sr-speedbar)
(require 'sr-speedbar)

;;(global-set-key [(f4)] 'sr-speedbar-toggle)
;; (global-set-key (kbd "C-c t") 'sr-speedbar-toggle)

(package-require 'projectile-speedbar)
(require 'projectile-speedbar)

;; Sometimes, when I am deep in a project tree, I like to use this shortcut to see full context:
(global-set-key (kbd "C-M-s") 'projectile-speedbar-toggle)
;; (global-set-key (kbd "C-M-z") 'projectile-speedbar-open-current-buffer-in-tree)

;; You can also disable the feature completely:
;; (setq projectile-speedbar-projectile-speedbar-enable nil)

;;==============================================================================
;;speedbar base settings
;;==============================================================================
;; left or right (nil:left | t:right)
(setq sr-speedbar-right-side t)

;; sort
(setq speedbar-sort-tags t)

;; t:show icon | nil: don't show icon
(setq speedbar-use-images t)

;; auto refresh
(setq sr-speedbar-auto-refresh t)

;; prevent the speedbar to update the current state, since it is always changing
;;(setq dframe-update-speed t)

;; when open, close other window
;;(setq sr-speedbar-delete-windows t)

;; width
(setq sr-speedbar-max-width 30)	;;set max width
(setq sr-speedbar-width 30)	;;width

;; show all file
(setq speedbar-show-unknown-files t)

;;----------------------------------------------------------------
;;(setq sr-speedbar-right-side nil)
;;(setq sr-speedbar-width 35)
;;(setq speedbar-show-unknown-files t)

;; prevent the speedbar to update the current state, since it is always changing
;;(setq dframe-update-speed t)

(autoload 'speedbar-frame-mode "speedbar" "Popup a speedbar frame" t)
(autoload 'speedbar-get-focus "speedbar" "Jump to speedbar frame" t)
;; inhibit tags grouping and sorting
(setq speedbar-tag-hierarchy-method '(speedbar-simple-group-tag-hierarchy) )
;;---------------new-begin--------------
;; default show :("quick buffer" or "files" or other)
;; (speedbar-change-initial-expansion-list "files")

;; key bind
;; (define-key speedbar-key-map "\M-j" 'speedbar-restricted-prev)
;; (define-key speedbar-key-map "\M-l" 'speedbar-restricted-next)
;; (define-key speedbar-key-map "\M-i" 'speedbar-prev)
;; (define-key speedbar-key-map "\M-k" 'speedbar-next)
;; (define-key speedbar-key-map "\M- " 'speedbar-toggle-line-expansion)
;;---------------new-begin--------------
;; fix speedbar in left, and set auto raise mode
;;(add-hook 'speedbar-mode-hook
;;    (lambda ()
;;        (auto-raise-mode 1)
;;        (add-to-list 'speedbar-frame-parameters '(top . 40))
;;        (add-to-list 'speedbar-frame-parameters '(left . 0))))

(defun speedbar-edit-line() 
  "Edit whatever tag or file is on the current speedbar line." 
  (interactive) 
  (or (save-excursion (beginning-of-line)
		      ;; If this fails, then it is a non-standard click, and as such,
		      ;; perfectly allowed.
		      (if (re-search-forward "[]>?}] [^ ]" (line-end-position) t) 
			  (progn (forward-char -1) 
				 (speedbar-do-function-pointer)) nil)) 
      (speedbar-do-function-pointer)) 
  (setq speedbar-is-opened (sr-speedbar-exist-p)) 
  (if speedbar-is-opened (sr-speedbar-close)) 
  (delete-other-windows) 
  (if speedbar-is-opened (sr-speedbar-open)))

;; (global-set-key (kbd "C-c s")
;; 		(function
;; 		 (lambda ()
;; 		   (setq speedbar-is-opened (sr-speedbar-exist-p))
;; 		   (if speedbar-is-opened
;; 		       (progn
;; 			 (sr-speedbar-close)
;; 			 (sr-speedbar-open))
;; 		     (sr-speedbar-open)))))

;; (global-set-key (kbd "C-c d")
;; 		(function
;; 		 (lambda ()
;; 		   (if (sr-speedbar-exist-p)
;; 		       (sr-speedbar-close)))))

;; (global-set-key (kbd "C-c 1")
;; 		(function
;; 		 (lambda ()
;; 		   (setq speedbar-is-opened (sr-speedbar-exist-p))
;; 		   (speedbar-change-initial-expansion-list "files"))))

;; (global-set-key (kbd "C-c 2")
;; 		(function
;; 		 (lambda ()
;; 		   (setq speedbar-is-opened (sr-speedbar-exist-p))
;; 		   (speedbar-change-initial-expansion-list "quick buffers"))))

;; (global-set-key (kbd "C-c 3")
;; 		(function
;; 		 (lambda ()
;; 		   (setq speedbar-is-opened (sr-speedbar-exist-p))
;; 		   (speedbar-change-initial-expansion-list "buffers"))))

;; (global-set-key (kbd "C-c 4")
;; 		(function
;; 		 (lambda ()
;; 		   (setq speedbar-is-opened (sr-speedbar-exist-p))
;; 		   (speedbar-change-initial-expansion-list "info"))))

;; (global-set-key (kbd "C-c 5")
;; 		(function
;; 		 (lambda ()
;; 		   (setq speedbar-is-opened (sr-speedbar-exist-p))
;; 		   (speedbar-change-initial-expansion-list "project"))))

;; (global-set-key (kbd "C-c 6")
;; 		(function
;; 		 (lambda ()
;; 		   (setq speedbar-is-opened (sr-speedbar-exist-p))
;; 		   (speedbar-change-initial-expansion-list "gud"))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-speedbar)
;; mod-speedbar.el ends here
