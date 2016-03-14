#!/usr/bin/emacs --script
;; -*- lexical-binding: t -*-
;; init.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2015-2016 damon-kwok
;;
;; Author: damon-kwok <damon-kwok@outlook.com>
;; Date: 2016-01-05
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

;; (toggle-frame-fullscreen)
;; (toggle-debug-on-error)
;;plugins: highlight-tail tabbar fill-column-indicator sr-speedbar yasnippet omnisharp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~")
(add-to-list 'load-path "~/.emacs.d/libraries")
(add-to-list 'load-path "~/../config")
(add-to-list 'load-path "~/../config/modules")
(add-to-list 'custom-theme-load-path "~/../config/themes")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'mod-coding)
(require 'mod-server)
(require 'mod-package)
(require 'mod-library)
(require 'mod-input)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (package-require 'tramp)
;; (require 'tramp)

;; ;;; version
;; (package-require 'magit)
;; (require 'magit)
;; (auto-fill-mode 0)
;; (package-require 'psvn)
;; (require 'psvn)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;edit
(require 'mod-csv)
(require 'mod-protobuf)
(require 'mod-orgmode)
(require 'mod-markdown)
;; (require 'mod-latex)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;base
(require 'mod-basic)
(require 'mod-helm)			
(require 'mod-complete)
(require 'mod-calendar)
;; (require 'mod-theme)
(require 'mod-tabbar)
;; (require 'mod-speedbar)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;code
(require 'mod-elisp)
(require 'mod-csharp)
;; (require 'mod-clojure)
;; (require 'mod-cc)
;;(require 'mod-slime)
;;(require 'mod-erlang)
;;(require 'mod-elixir)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (standard-display-european t)
;; (load-library "iso-transl")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;eclim
;;(custom-set-variables
;;  '(eclim-eclipse-dirs '("C:/SOFT/application/eclipse-jee-mars-1-win32-x86_64/eclipse"))
;;  '(eclim-executable "C:/SOFT/application/eclipse-jee-mars-1-win32-x86_64/eclipse/eclim"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;启动eide
;;(package-require 'eide)
;;(eide-start)

;;; music
;; (package-require 'emms)
;; (require 'emms-setup)
;; (emms-standard)
;; (emms-default-players)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'mod-keybind)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "hello, emacs!")
(provide 'init)

;; (package-requir
