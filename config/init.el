#!/usr/bin/emacs --script
;; -*- lexical-binding: t -*-
;; init.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2015-2016 Damon Kwok
;;
;; Author: gww <DamonKwok@msn.com>
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

(setq gc-cons-threshold (* 256 1024 1024))
(setq debug-on-error t) ;; M-x toggle-debug-on-error
;; (typo-err)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~")
(add-to-list 'load-path "~/.emacs.d/libraries")
(add-to-list 'load-path "~/../config")
(add-to-list 'load-path "~/../config/modules")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'mod-server)
(require 'mod-package)
(require 'mod-library)
(require 'mod-coding)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(package-require 'magit)
(require 'magit)

(package-require 'psvn)
(require 'psvn)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;edit
(require 'mod-csv)
(require 'mod-protobuf)
(require 'mod-orgmode)
;;(require 'mod-markdown)
(require 'mod-latex)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;base
(require 'mod-basic)
(require 'mod-helm)
(require 'mod-complete)
(require 'mod-tabbar)
(require 'mod-theme)
(require 'mod-calendar)

;;(require 'mod-speedbar)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;code
(require 'mod-elisp)
(require 'mod-csharp)
(require 'mod-clojure)
(require 'mod-cc)
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

(package-require 'emms)
(require 'emms-setup)
(emms-standard)
(emms-default-players)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'mod-keybind)
(require 'mod-chinese-py)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "hello, medusa!")
(provide 'init)
