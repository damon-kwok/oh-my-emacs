;;; -*- lexical-binding: t -*-
;;; init.el --- This is where you apply your OCD.
;;;
;;; Copyright (C) 2015-2016 damon-kwok
;;;
;;; Author: gww <damon-kwok@outlook.com>
;;; Create: 2016-01-05
;;; Last-saved : 2016-04-19
;;;
;;; This program is free software; you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation, either version 3 of the License, or
;;; (at your option) any later version.
;;;
;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this program.  If not, see <http:;;www.gnu.org/licenses/>.
;;;						 
;;; Code:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'mod-package)
;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `base'
(require 'mod-basic)
(require 'mod-package)
(require 'mod-library)
(require 'mod-coding)
(require 'mod-helm)
(require 'mod-dired)
(require 'mod-complete)
(require 'mod-tabbar)
;; (require 'mod-speedbar)
(require 'mod-input)
(require 'mod-calendar)
(require 'mod-server)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `docs'
(require 'mod-csv)
(require 'mod-protobuf)
(require 'mod-orgmode)
(require 'mod-markdown)
;;(require 'mod-latex)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `programming-languages'
(require 'mod-elisp)
;; (require 'mod-csharp)
(require 'mod-clojure)
(require 'mod-cc)
(require 'mod-ess)
;; (require 'mod-slime)
;; (require 'mod-erlang)
;; (require 'mod-elixir)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(if (or (eq system-type 'windows-nt)
;;	(eq system-type 'ms-dos))
;;   (setq dir-medusa-config "~/emacs-config")
;;  (setq dir-medusa-config "~/emacs-config"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (standard-display-european t)
;; (load-library "iso-transl")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `eclim'
;;(custom-set-variables
;;  '(eclim-eclipse-dirs '("C:/SOFT/application/eclipse-jee-mars-1-win32-x86_64/eclipse"))
;;  '(eclim-executable "C:/SOFT/application/eclipse-jee-mars-1-win32-x86_64/eclipse/eclim"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `eide'
;;(package-require 'eide)
;;(eide-start)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `music'
;; (package-require 'emms)
;; (require 'emms-setup)
;; (emms-standard)
;; (emms-default-players)
;; (toggle-frame-fullscreen)
;; (toggle-debug-on-error)
;;plugins: highlight-tail tabbar fill-column-indicator sr-speedbar yasnippet omnisharp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `tramp'
;; (package-require 'tramp)
;; (require 'tramp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `version'
;; (package-require 'magit)
;; (require 'magit)
;; (auto-fill-mode 0)
;; (package-require 'psvn)
;; (require 'psvn)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'mod-keybind)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "hello, emacs!")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-init)
;;; init.el ends here