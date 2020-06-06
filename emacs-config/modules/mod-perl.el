;; -*- lexical-binding: t -*-
;; mod-perl.el --- This is where you apply your OCD.
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'mod-package)
;;
;; `automenu'
(defun automenu--perl-mode-menu ()
  '("publish-to:$OME_PREFIX/bin/" "1" "2" "3" "4" "5" "6" "7" "8" "9"))

(defun automenu--perl-mode-func (index)
  (cond ((= 0 index)
         (ome-run-command (concat "cp -rf " (buffer-file-name) " " (getenv "OME_PREFIX") "/bin/")))
        ((= 1 index)
         (message  "perl-mode menu:%d" index))
        ((= 2 index)
         (message  "perl-mode menu:%d" index))
        ((= 3 index)
         (message  "perl-mode menu:%d" index))
        ((= 4 index)
         (message  "perl-mode menu:%d" index))
        ((= 5 index)
         (message  "perl-mode menu:%d" index))
        ((= 6 index)
         (message  "perl-mode menu:%d" index))
        ((= 7 index)
         (message  "perl-mode menu:%d" index))
        ((= 8 index)
         (message  "perl-mode menu:%d" index))
        ((= 9 index)
         (message  "perl-mode menu:%d" index))
        (t (message  "perl-mode menu:%d" index))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-perl)
;; mod-perl.el ends here
