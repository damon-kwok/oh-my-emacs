;; -*- lexical-binding: t -*-
;; mod-sh.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2018 damon-kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2018-07-02
;; Modify: 2018-07-02
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
(require 'mod-lsp)
(add-hook 'sh-mode-hook 'lsp)

;; (package-require 'lsp-sh)
;; (package-require-curl "lsp-sh" "lsp-sh.el"
                      ;; "https://raw.githubusercontent.com/emacs-lsp/lsp-sh/master/lsp-sh.el")
;; (require 'lsp-sh)

;; `automenu'
;; (setenv "OME_PREFIX" "/home/damon/.ome_local")
(defun automenu--sh-mode-menu () 
  '("publish-to:$OME_PREFIX/bin/" "publish-to:$OME_ROOT/bin/" "2" "3" "4" "5" "6" "7" "8" "9"))

(defun automenu--sh-mode-func (index) 
  (cond ((= 0 index) 
         (ome-run-command (concat "cp -rf " (buffer-file-name) " " (getenv "OME_PREFIX") "/bin/"))) 
        ((= 1 index) 
         (ome-run-command (concat "cp -rf " (buffer-file-name) " " (getenv "OME_ROOT") "/bin/"))) 
        ((= 2 index) 
         (message  "sh-mode menu:%d" index)) 
        ((= 3 index) 
         (message  "sh-mode menu:%d" index)) 
        ((= 4 index) 
         (message  "sh-mode menu:%d" index)) 
        ((= 5 index) 
         (message  "sh-mode menu:%d" index)) 
        ((= 6 index) 
         (message  "sh-mode menu:%d" index)) 
        ((= 7 index) 
         (message  "sh-mode menu:%d" index)) 
        ((= 8 index) 
         (message  "sh-mode menu:%d" index)) 
        ((= 9 index) 
         (message  "sh-mode menu:%d" index)) 
        (t (message  "sh-mode menu:%d" index))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-sh)
;; mod-sh.el ends here
