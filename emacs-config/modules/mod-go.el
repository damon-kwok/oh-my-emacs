;; -*- lexical-binding: t -*-
;; mod-go.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2018 damon-kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2018-05-22
;; Modify: 2018-05-22
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
;; env
(setenv "GOROOT" "/usr/lib/go")
(setenv "GOPATH" (concat (getenv "HOME") "/goprojects"))
(setenv "PATH" (concat (getenv "PATH") ":" (getenv "GOPATH") "/bin"))


(package-require 'company-go)
(require 'company-go)                                ; load company mode go backend

;; Possible improvements
(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
(setq company-echo-delay 0)                          ; remove annoying blinking
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; lsp-server
(require 'mod-lsp)
(package-require 'lsp-go)
(require 'lsp-go)

(add-hook 'go-mode-hook #'lsp-go-enable)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-go)
;; mod-go.el ends here
