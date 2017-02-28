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



;;; `clj-refactor'
(package-require 'clj-refactor)
(require 'clj-refactor)


(defun my-clojure-mode-hook ()
  (clj-refactor-mode 1)
  (yas-minor-mode 1)	    ; for adding require/use/import statements
  ;; This choice of keybinding leaves cider-macroexpand-1 unbound
  (cljr-add-keybindings-with-prefix "C-c C-m"))

(add-hook 'clojure-mode-hook #'my-clojure-mode-hook)



;;;;
;; Clojure
;;;;

;; Enable paredit for Clojur
(add-hook 'clojure-mode-hook 'enable-paredit-mode)

;; This is useful for working with camel-case tokens, like names of
;; Java classes (e.g. JavaClassName)
(add-hook 'clojure-mode-hook 'subword-mode)

;; A little more syntax highlighting
(package-require 'clojure-mode-extra-font-locking)
(require 'clojure-mode-extra-font-locking)

;; syntax hilighting for midje
(add-hook 'clojure-mode-hook
          (lambda ()
            (setq inferior-lisp-program "lein repl")
            (font-lock-add-keywords
             nil
             '(("(\\(facts?\\)"
                (1 font-lock-keyword-face))
               ("(\\(background?\\)"
                (1 font-lock-keyword-face))))
            (define-clojure-indent (fact 1))
            (define-clojure-indent (facts 1))))


;;;;
;; Cider
;;;;
(package-require 'helm-cider)
(require 'helm-cider)

;;; 
(package-require 'cider-hydra)
(require 'cider-hydra)

;; provides minibuffer documentation for the code you're typing into the repl
(add-hook 'cider-mode-hook 'eldoc-mode)

;; go right to the REPL buffer when it's finished connecting
(setq cider-repl-pop-to-buffer-on-connect t)

;; When there's a cider error, show its buffer and switch to it
(setq cider-show-error-buffer t)
(setq cider-auto-select-error-buffer t)

;; Where to store the cider history.
(setq cider-repl-history-file "~/.emacs.d/cider-history")

;; Wrap when navigating history.
(setq cider-repl-wrap-history t)

;; enable paredit in your REPL
(add-hook 'cider-repl-mode-hook 'paredit-mode)

;; Use clojure mode for other extensions
(add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.boot$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.cljs.*$" . clojure-mode))
(add-to-list 'auto-mode-alist '("lein-env" . enh-ruby-mode))

(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-mode-hook #'company-mode)
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

;; key bindings
;; these help me out with the way I usually develop web apps
(defun cider-start-http-server ()
  (interactive)
  (cider-load-current-buffer)
  (let ((ns (cider-current-ns)))
    (cider-repl-set-ns ns)
    (cider-interactive-eval (format "(println '(def server (%s/start))) (println 'server)" ns))
    (cider-interactive-eval (format "(def server (%s/start)) (println server)" ns))))


(defun cider-refresh ()
  (interactive)
  (cider-interactive-eval (format "(user/reset)")))

(defun cider-user-ns ()
  (interactive)
  (cider-repl-set-ns "user"))

(eval-after-load 'cider
  '(progn
     (helm-cider-mode 1)
     (define-key clojure-mode-map (kbd "C-c C-v") 'cider-start-http-server)
     (define-key clojure-mode-map (kbd "C-M-r") 'cider-refresh)
     (define-key clojure-mode-map (kbd "C-c u") 'cider-user-ns)
     (define-key cider-mode-map (kbd "C-c u") 'cider-user-ns)
     (define-key cider-mode-map (kbd "C-c C-z")  'show-clojure-repl)
     (define-key cider-repl-mode-map (kbd "C-c C-z")  'show-clojure-workbuffer)))

(define-key clojure-mode-map (kbd "C-c C-h") 'clojure-cheatsheet)
(define-key clojure-mode-map (kbd "C-M-\\")  'cider-format-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-clojure)
;;; mod-clojure.el ends here
