;;; mod-lua.el --- This is where you apply your OCD.  -*- lexical-binding: t -*-
;;
;; Copyright (C) 2009-2020 Damon Kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2020-08-27
;; Modify: 2020-08-27
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

(add-to-list 'auto-mode-alist '("\\.lua?c\\'" . lua-mode))
;;
(provide 'mod-lua)

;;; mod-lua.el ends here
