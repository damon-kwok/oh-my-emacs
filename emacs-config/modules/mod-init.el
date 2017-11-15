;; -*- lexical-binding: t -*-
;; init.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2015-2016 damon-kwok
;;
;; Author: gww <damon-kwok@outlook.com>
;; Create: 2016-01-05
;; Last-saved : 2016-04-19
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(module-require 'mod-package)
;;;
(module-require 'mod-coding)
(module-require 'mod-server)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `base'
(module-require 'mod-basic)
(module-require 'mod-library)
(module-require 'mod-mouse)
(module-require 'mod-helm)
(module-require 'mod-complete)
(module-require 'mod-tabbar)
(module-require 'mod-input)
(module-require 'mod-calendar)
;; (module-require 'mod-dired)
;; (module-require 'mod-speedbar)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `docs'
(module-require 'mod-csv)
(module-require 'mod-protobuf)
(module-require 'mod-markdown)
(module-require 'mod-orgmode)
(module-require 'mod-latex)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `programming-languages'
(module-require 'mod-elisp)
(module-require 'mod-clojure)
(module-require 'mod-elixir)
(module-require 'mod-rust)
;; (module-require 'mod-erlang)
;; (module-require 'mod-ess)
;; (module-require 'mod-csharp)
(module-require 'mod-cc)
(module-require 'mod-py)
(module-require ' mod-haskell)
;; (module-require 'mod-slime)
(module-require 'mod-ros)
(module-require 'mod-git)
;; (module-require 'mod-tree)
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
;; (module-require 'emms-setup)
;; (emms-standard)
;; (emms-default-players)
;;plugins: highlight-tail tabbar fill-column-indicator sr-speedbar yasnippet omnisharp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `tramp'
;; (package-require 'tramp)
;; (module-require 'tramp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `version'
;; (package-require 'magit)
;; (module-require 'magit)
;; (auto-fill-mode 0)
;; (package-require 'psvn)
;; (module-require 'psvn)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(module-require 'mod-keybind)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (message "hello, emacs!")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-init)
;; init.el ends here
