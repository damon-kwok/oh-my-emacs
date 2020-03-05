;; -*- lexical-binding: t -*-
;; mod-org-publish.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2018 damon-kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2018-08-24
;; Modify: 2018-08-24
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
(internal-require 'htmlize)
(internal-require 'org)
(internal-require 'ox-html)
(internal-require 'ox-publish)

(setq org-publish-project-alist '(;;
                                  ("blog" :components ("blog-notes" "blog-static"))
                                  ;;
                                  ("blog-notes" :base-directory "~/workspace/blog/src/" 
                                   :base-extension "org" 
                                   :publishing-directory "~/projects/me/blog/" 
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
                                  ;;
                                  ("blog-static" :base-directory "~/workspace/blog/src/" 
                                   :base-extension
                                   "css\\|js\\|png\\|jpg\\|bmp\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|ico" 
                                   :publishing-directory "~/projects/me/blog/" 
                                   :recursive t 
                                   :publishing-function org-publish-attachment)
                                  ;;
                                  ))
(setq org-html-validation-link nil)

(setq *site-template-directory* "~/workspace/blog/src/templates")
(defun read-html-template (template-file) 
  (with-temp-buffer (insert-file-contents (concat *site-template-directory* "/" template-file)) 
                    (buffer-string)))

;;; 设置CSS样式
(setq org-html-head-extra
      "<link rel=\"stylesheet\" type=\"text/css\" href=\"/style/default.css\" />")
;;; 取消默认的CSS
(setq org-html-head-include-default-style nil)
;;; 取消默认的Javascript代码
(setq org-html-head-include-scripts nil)
;;; XXX 用org-html-head可以设置<head>部分
(setq org-html-preamble (read-html-template "preamble.html"))
(setq org-html-postamble (read-html-template "postamble.html"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-org-publish)
;; mod-org-publish.el ends here
