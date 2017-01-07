;;; -*- lexical-binding: t -*-
;; mod-orgmode.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2015-2016 Damon Kwok
;;
;; Author: gww <DamonKwok@msn.com>
;; Date: 2016-01-19
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
;;org-mode
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

;;-(package-require 'org-plus-contrib)
;;-(require 'org-install)

(setq org-todo-keywords '((sequence "TODO" "DOING" "DONE")))

(setq org-todo-keyword-faces '(("TODO" . "red") 
			       ("DOING" . "yellow") 
			       ("DONE" . "green")))
(setq org-log-done 'time)
;;(setq org-log-done 'note)

(add-hook 'org-load-hook 
	  (lambda ()
	    (org-defkey org-mode-map [(meta p)]    'org-metaup)
	    (org-defkey org-mode-map [(meta n)]  'org-metadown)

	    (org-defkey org-mode-map "\M-["    'org-metaup)
	    (org-defkey org-mode-map "\M-/"  'org-metadown)
	    (org-defkey org-mode-map "\M-;"    'org-metaleft )
	    (org-defkey org-mode-map "\M-'"  'org-metaright)))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
;;
(provide 'mod-orgmode)
;;; mod-orgmode.el ends here
