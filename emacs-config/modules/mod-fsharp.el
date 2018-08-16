;; -*- lexical-binding: t -*-
;; mod-fsharp.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2018 damon-kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2018-08-16
;; Modify: 2018-08-16
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
(package-require 'fsharp-mode)
(require 'fsharp-mode)

(add-to-list 'auto-mode-alist '("\\.fs[iylx]?$" . fsharp-mode))

;; `windows'
(setq inferior-fsharp-program "\"c:\\Path\To\Fsi.exe\"")
(setq fsharp-compiler "\"c:\\Path\To\Fsc.exe\"")

;; `unix'
(setq inferior-fsharp-program "usr/bin/fsharpi --readline-")
(setq fsharp-compiler "usr/bin/fsharpc")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-fsharp)
;; mod-fsharp.el ends here
