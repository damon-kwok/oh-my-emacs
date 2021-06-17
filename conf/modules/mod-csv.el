;;; -*- lexical-binding: t -*-
;; mod-csv.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2020 Damon Kwok
;;
;; Author: damon <damon-kwok@outlook.com>
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
;;
(package-download 'csv-mode)

(add-to-list 'auto-mode-alist '("\\.csv$" . csv-mode))
(add-hook 'csv-mode-hook '(lambda()
                            (toggle-truncate-lines)
                            (csv-align-fields nil (buffer-end -1)
                                              (buffer-end +1))))
;;
(provide 'mod-csv)
;;; mod-csv.el ends here
