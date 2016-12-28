;;; -*- lexical-binding: t -*-
;;; mod-clojure.el --- This is where you apply your OCD.
;;;
;;; Author: gww <damon-kwok@outlook.com>
;;; Date: 2016-02-01
;;;
;;; This program is free software; you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation, either version 3 of the License, or
;;; (at your option) any later version.
;;;
;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this program.  If not, see <http:;;www.gnu.org/licenses/>.
;;;						 
;;; Code:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'mod-package)
;;;

;;===================================================
;;clojure
;;===================================================
(package-require 'clojure-mode)
(require 'clojure-mode)

(package-require 'cider)
(require 'cider)

(package-require 'clojure-cheatsheet)
(require 'clojure-cheatsheet)

(package-require 'helm-cider-history)
(require 'helm-cider-history)

(package-require 'clj-refactor)
(require 'clj-refactor)

;; (package-require 'lispy)
;; (require 'lispy)

(defun my-clojure-mode-hook ()
  ;; (lispy-mode 1)
  (clj-refactor-mode 1) 
  (yas-minor-mode 1)	    ; for adding require/use/import statements
  ;; This choice of keybinding leaves cider-macroexpand-1 unbound
  (cljr-add-keybindings-with-prefix "C-c C-m"))

(add-hook 'clojure-mode-hook #'my-clojure-mode-hook)

;;===================================================
;;keybind
;;===================================================
(defun show-clojure-repl() 
  (interactive)
  ;;(m-show-compilation "*Messages*")
  (delete-other-windows) 
  (cider-switch-to-repl-buffer) 
  (if (< (/ (frame-height) 3) 
	 (window-height)) 
      (shrink-window (/ (window-height) 2))))

(defun show-clojure-workbuffer() 
  (interactive) 
  (cider-switch-to-last-clojure-buffer) 
  (delete-other-windows) 
  (show-clojure-repl) 
  (cider-switch-to-last-clojure-buffer))

(define-key clojure-mode-map (kbd "C-c C-h") 'clojure-cheatsheet)
(define-key clojure-mode-map (kbd "C-M-\\")  'cider-format-buffer)

;;
(define-key cider-mode-map (kbd "C-c C-z")  'show-clojure-repl)
(define-key cider-repl-mode-map (kbd "C-c C-z")  'show-clojure-workbuffer)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-clojure)
;;; mod-clojure.el ends here
