;; -*- lexical-binding: t -*-
;; mod-gc.el --- This is where you apply your OCD.
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


;; 显示垃圾回收信息，这个可以作为调试用 {t:display nil: not}
(setq garbage-collection-messages nil)

;; (if (or (string= system-type 'windows-nt) ;
;;         (string= system-type 'ms-dos)
;;         (string= system-type 'cygwin))
;;     (progn
;;       (setq gc-cons-threshold (* 256 1024 1024))
;;       (setq gc-cons-percentage 0.5)
;;       (add-hook 'after-init-hook (lambda ()
;;                                    (run-with-idle-timer 3 t #'garbage-collect))))
;;   (progn (my-optimize-gc 256 0.2)
;;          (add-hook 'after-init-hook (lambda ()
;;                                       (my-optimize-gc 16 0.2)))))

(progn (my-optimize-gc 256 0.2) 
       (add-hook 'after-init-hook (lambda () 
                                    (my-optimize-gc 8 0.1))))
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-gc)
;; mod-gc.el ends here
