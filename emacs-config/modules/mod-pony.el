;; -*- lexical-binding: t -*-
;; mod-pony.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2020 damon-kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2020-03-27
;; Modify: 2020-03-27
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
(package-download 'ponylang-mode)
(package-download 'flycheck-pony)
(package-download 'pony-snippets)

(add-to-list 'auto-mode-alist '("\\.pony$" . ponylang-mode))

(add-hook 'ponylang-mode-hook ;;
  (lambda ()
    (set-variable 'indent-tabs-mode nil)
    (set-variable 'tab-width 2)
    ;;
    (internal-require 'flycheck-pony)
    ;;
    (internal-require 'pony-snippets)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-pony)
;; mod-pony.el ends here
