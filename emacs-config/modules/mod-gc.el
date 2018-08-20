;; -*- lexical-binding: t -*-
;; mod-gc.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2018 damon-kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2018-08-10
;; Modify: 2018-08-10
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
;;----------------------------------------------------------------------------
;; Temporarily reduce garbage collection during startup
;;----------------------------------------------------------------------------
;; (defconst sanityinc/initial-gc-cons-threshold gc-cons-threshold
;;   "Initial value of `gc-cons-threshold' at start-up time.")
;; (setq gc-cons-threshold (* 256 1024 1024))
;; (add-hook 'after-init-hook (lambda ()
;; 			     (setq gc-cons-threshold sanityinc/initial-gc-cons-threshold)))

(defun my-optimize-gc (NUM PER) 
  "By default Emacs will initiate GC every 0.76 MB allocated (gc-cons-threshold == 800000).
@see http://www.gnu.org/software/emacs/manual/html_node/elisp/Garbage-Collection.html
We increase this to 16MB by `(my-optimize-gc 16 0.5)` "
  (setq-default gc-cons-threshold (* 1024 1024 NUM) gc-cons-percentage PER))

;;(message (concat "gc:" gc-cons-threshold " pre:" gc-cons-percentage))
(my-optimize-gc 256 0.2)
(add-hook 'after-init-hook (lambda () 
                             (my-optimize-gc 16 0.2)))
;;

;;(require 'indent-tabs-mode)
;; Permanently force Emacs to indent with spaces, never with TABs:
;;(define-globalized-minor-mode global-notab-mode indent-tabs-mode
;;  (lambda ()
;;    (setq-default indent-tabs-mode nil)))
;;(global-notab-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-gc)
;; mod-gc.el ends here
