;;; mod-eaf.el --- This is where you apply your OCD.  -*- lexical-binding: t -*-
;;
;; Copyright (C) 2009-2021 Damon Kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2021-10-28
;; Modify: 2021-10-28
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
;;; Code:
(require 'mod-package)

(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/")
(require 'eaf)

(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/app/pdf-viewer/")
(require 'eaf-pdf-viewer)

(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/app/camera/")
(require 'eaf-camera)

(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/app/video-player/")
(require 'eaf-video-player)

(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/app/rss-reader/")
(require 'eaf-rss-reader)

(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/app/image-viewer/")
(require 'eaf-image-viewer)

(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/app/system-monitor/")
(require 'eaf-system-monitor)

;; (add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/app/mermaid")
;; (require 'eaf-mermaid)

(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/app/browser/")
(require 'eaf-browser)

(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/app/org-previewer")
(require 'eaf-org-previewer)

(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/app/markdown-previewer")
(require 'eaf-markdown-previewer)

(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/app/mindmap")
(require 'eaf-mindmap)

(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/app/music-player/")
(require 'eaf-music-player)

(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/app/file-manager")
(require 'eaf-file-manager)

(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/app/file-browser")
(require 'eaf-file-browser)

(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/app/vue-demo/")
(require 'eaf-vue-demo)

(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/app/terminal/")
(require 'eaf-terminal)

(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/app/file-sender/")
(require 'eaf-file-sender)

(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/app/demo/")
(require 'eaf-demo)

(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/app/netease-cloud-music/")
(require 'eaf-netease-cloud-music)

(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/app/jupyter/")
(require 'eaf-jupyter)

(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/app/airshare/")
(require 'eaf-airshare)

;; (global-set-key (kbd "C-x w f") 
                ;; (lambda (url) 
                  ;; (interactive "P")
;; (eaf-open-browser url)))

;;
(provide 'mod-eaf)

;;; mod-eaf.el ends here
