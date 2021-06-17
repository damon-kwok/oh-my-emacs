;; -*- lexical-binding: t -*-
;; mod-text.el --- This is where you apply your OCD.
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
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-hook 'org-mode-hook '(lambda()
                            (internal-require 'mod-orgmode)))
;; `automenu:text'
(defun automenu--text-mode-menu ()
  '("edit-server-done" "1" "2" "3" "4" "5" "6" "7" "8" "9"))

(defun automenu--text-mode-func (index)
  (cond ((= 0 index)
         (edit-server-done))
        ((= 1 index)
         (message  "text menu:%d" index))
        ((= 2 index)
         (message  "text menu:%d" index))
        ((= 3 index)
         (message  "text menu:%d" index))
        ((= 4 index)
         (message  "text menu:%d" index))
        ((= 5 index)
         (message  "text menu:%d" index))
        ((= 6 index)
         (message  "text menu:%d" index))
        ((= 7 index)
         (message  "text menu:%d" index))
        ((= 8 index)
         (message  "text menu:%d" index))
        ((= 9 index)
         (message  "text menu:%d" index))
        (t (message  "text menu:%d" index))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-text)
;; mod-text.el ends here
