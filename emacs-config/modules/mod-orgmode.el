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

(package-require 'org-plus-contrib)
(require 'org-install)

;; 自动换行
(add-hook 'org-mode-hook (lambda () 
			   (setq truncate-lines nil) 
			   (org-display-inline-images t t)))

(setq org-todo-keywords '((sequence "TODO" "DOING" "DONE")))

(setq org-todo-keyword-faces '(("TODO" . "red") 
			       ("DOING" . "yellow") 
			       ("DONE" . "green")))
(setq org-log-done 'time)
;;(setq org-log-done 'note)

(add-hook 'org-load-hook (lambda () 
			   (org-defkey org-mode-map [(meta p)]    'org-metaup) 
			   (org-defkey org-mode-map [(meta n)]  'org-metadown) 
			   (org-defkey org-mode-map "\M-["    'org-metaup) 
			   (org-defkey org-mode-map "\M-/"  'org-metadown) 
			   (org-defkey org-mode-map "\M-;"    'org-metaleft) 
			   (org-defkey org-mode-map "\M-'"  'org-metaright)))
;; (org-defkey org-mode-map "C-c C-z" 'org-export-dispatch)))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)



;; `Babel-Languages'
(package-require 'ob-elixir)
(package-require 'ob-browser)
(package-require 'ob-crystal)
(package-require 'ob-go)
(package-require 'ob-kotlin)
(package-require 'ob-ipython)
(package-require 'ob-lfe)
(package-require 'ob-crystal)
(package-require 'ob-fsharp)
(package-require 'ob-http)
(package-require 'ob-nim)
(package-require 'ob-php)
(package-require 'ob-prolog)
(package-require 'ob-rust)
(package-require 'ob-swift)
(package-require 'ob-dart)
(package-require 'ob-coffee)
(package-require 'ob-coffeescript)
(package-require 'ob-hy)
(package-require 'ob-typescript)
(package-require 'ob-sml)
(org-babel-do-load-languages 'org-babel-load-languages '((shell . t)
							 (octave . t) 
							 (ditaa . t) 
							 (dot . t) 
							 (sql . t)
							 (sqlite . t)
							 (makefile . t)
							 (org . t) 
							 (latex . t)
							 (browser . t)
							 (java . t)
							 (go . t)
							 (crystal . t)
							 (kotlin . t)
							 (js . t)
							 (typescript . t)
							 (python . t)
							 (ipython . t)
							 (perl . t) 
							 (ruby . t)
							 (groovy . t)
							 (matlab . t) 
							 (R . t) 
							 (lisp . t) 
							 (emacs-lisp .t) 
							 (clojure .t)
							 (hy . t)
							 (ocaml . t)
							 (sml . t)
							 (haskell . t) 
							 (elixir .t)
							 (lfe . t)
							 (fsharp . t)
							 (http . t)
							 (nim . t)
							 (php . t)
							 (prolog . t)
							 (rust . t)
							 (swift . t)
							 (dart . t)
							 (coffee . t)
							 (coffeescript . t)))



(require 'ox-publish)
(setq org-publish-project-alist '(
				  ("blog-notes" :base-directory "~/workspace/docs/github-pages/" 
				   :base-extension "org" 
				   :publishing-directory "~/blog/" 
				   :recursive t 
				   :publishing-function org-html-publish-to-html 
				   :headline-levels 4 ; Just the default for this project.
				   :auto-preamble t 
				   :section-numbers nil 
				   :author "damon-kwok" 
				   :email "damon-kwok@outlook.com" 
				   :auto-sitemap t ; Generate sitemap.org automagically...
				   :sitemap-filename "sitemap.org" ; ... call it sitemap.org (it's the default)...
				   :sitemap-title "Sitemap" ; ... with title 'Sitemap'.
				   :sitemap-sort-files anti-chronologically 
				   :sitemap-file-entry-format "%d %t") 
				  ("blog-static" :base-directory "~/workspace/docs/github-pages/" 
				   :base-extension
				   "css\\|js\\|png\\|jpg\\|bmp\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|ico" 
				   :publishing-directory "~/blog/" 
				   :recursive t 
				   :publishing-function org-publish-attachment) 
				  ("blog" :components ("blog-notes" "blog-static"))))
(setq org-html-validation-link nil)
;;
(provide 'mod-orgmode)
;;; mod-orgmode.el ends here
