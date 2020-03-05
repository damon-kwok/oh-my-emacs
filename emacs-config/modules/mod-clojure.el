;; -*- lexical-binding: t -*-
;; mod-clojure.el --- This is where you apply your OCD.
;;
;; Author: damon-kwok <damon-kwok@outlook.com>
;; Date: 2016-02-01
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
;; along with this program.  If not, see <http:;;www.gnu.org/licenses/>.
;;
;; Code:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'mod-package)
;;

;;===================================================
;;clojure
;;===================================================
(package-require 'clojure-mode)

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

;; syntax hilighting for midje
(add-hook 'clojure-mode-hook (lambda () 
                               (setq inferior-lisp-program "lein repl") 
                               (font-lock-add-keywords 
                                nil
                                '(("(\\(facts?\\)" (1 font-lock-keyword-face)) 
                                  ("(\\(background?\\)" (1 font-lock-keyword-face)))) 
                               (define-clojure-indent (fact 1)) 
                               (define-clojure-indent (facts 1))))

;;;;
;; Cider
;;;;
(package-require 'cider)
(package-require '4clojure)
(defadvice 4clojure-open-question (around 4clojure-open-question-around)
  "Start a cider/nREPL connection if one hasn't already been started when
opening 4clojure questions"
  ad-do-it
  (unless cider-current-clojure-buffer
    (cider-jack-in)))

(package-require 'helm-cider)
(helm-cider-mode 1)

;;; `clj-refactor'
(package-require 'clj-refactor)

;;(package-require 'cider-hydra)
;;(cider-hydra-on)

;;(package-require 'helm-cider-history)

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
;; (add-to-list 'auto-mode-alist '("\\.cljs.*$" . clojurescript-mode))
(add-to-list 'auto-mode-alist '("\\.cljs\\.hl\\'" . clojurescript-mode))
(add-to-list 'auto-mode-alist '("lein-env" . enh-ruby-mode))

(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-mode-hook #'company-mode)
;;===================================================
;;keybind
;;===================================================
(defun show-clojure-repl() 
  (interactive)
  ;;(ome-show-compilation "*Messages*")
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

(eval-after-load 'cider '(progn (helm-cider-mode 1) 
                                (define-key clojure-mode-map (kbd "C-c C-v")
                                  'cider-start-http-server) 
                                (define-key clojure-mode-map (kbd "C-M-r") 'cider-refresh) 
                                (define-key clojure-mode-map (kbd "C-c u") 'cider-user-ns) 
                                (define-key cider-mode-map (kbd "C-c u") 'cider-user-ns) 
                                (define-key cider-mode-map (kbd "C-c C-z")  'show-clojure-repl) 
                                (define-key cider-repl-mode-map (kbd "C-c C-z")
                                  'show-clojure-workbuffer)))

;; (package-require 'clojure-cheatsheet)
;; (define-key clojure-mode-map (kbd "C-c C-h") 'clojure-cheatsheet)
(define-key clojure-mode-map (kbd "C-c C-h") 'helm-cider-apropos)
(define-key clojure-mode-map (kbd "C-M-\\")  'cider-format-buffer)


(defun my-kill-java () 
  (interactive) 
  (delete-window) 
  (cider-interactive-eval "(System/exit 0)"))
(define-key cider-repl-mode-map (kbd "C-c C-q") 'my-kill-java)

(defun my-jack-in () 
  (interactive) 
  (delete-other-windows)
  ;;(ome-show-compilation "*cider-repl Server**")
  (cider-jack-in))
;;(define-key clojure-mode-map (kbd "C-c M-j") 'my-jack-in)

(defun my-run-project () 
  (interactive) 
  (ome-run-command "lein run"))

;; `cljs'
(defun cljs-client-start () 
  (interactive) 
  (progn (insert "(use 'figwheel-sidecar.repl-api)\n") 
         (insert "(cljs-repl)\n") 
         (sleep-for 2) 
         (rename-buffer (replace-regexp-in-string " " " CLJS " (buffer-name)))))

(defun cljs-eval-sexp (sexp) 
  (interactive "sClJS-EVAL:") 
  (cider-interactive-eval sexp))
(define-key global-map (kbd "M-\"") 'cljs-eval-sexp)

;;
(defun ome-open-clojure-project ()
  (interactive)
  (if (file-exists-p (concat (ome-project-root) "project.clj")) 
      (find-file (concat (ome-project-root) "project.clj")) 
    (if (file-exists-p (concat (ome-project-root) "build.boot")) 
        (find-file (concat (ome-project-root) "build.boot")) 
      (if (file-exists-p (concat (ome-project-root) "shadow-cljs.edn")) 
          (find-file (concat (ome-project-root) "shadow-cljs.edn")) 
        (if (file-exists-p (concat (ome-project-root) "build.clj")) 
            (find-file (concat (ome-project-root) "build.clj")) 
          (if (file-exists-p (concat (ome-project-root) "package.json")) 
              (find-file (concat (ome-project-root) "package.json"))))))))

(define-key clojure-mode-map [f6] 'ome-open-clojure-project)
(define-key clojurescript-mode-map [f6] 'ome-open-clojure-project)

;; `auto-menu:clojure'
(defun automenu--clojure-mode-menu () 
  '("REPL" "jack-in-clj" "jack-in-cljs" "jack-in-clj&cljs" "" "" "4clj-open" "4clj-prev" "4clj-next" "4clj-check"))

(defun automenu--clojure-mode-func (index) 
  (cond ((= 0 index) 
         (show-clojure-repl)) 
        ((= 1 index) 
         (cider-jack-in-clj nil)) 
        ((= 2 index) 
         (cider-jack-in-cljs nil)) 
        ((= 3 index) 
         (cider-jack-in-clj&cljs nil))
        ((= 6 index) 
         (4clojure-open-question))
        ((= 7 index) 
         (4clojure-previous-question))
        ((= 8 index) 
         (4clojure-next-question))
        ((= 9 index) 
         (4clojure-check-answer))
        (t (message  "clojure-mode menu:%d" index))))

;; `auto-menu:cider-repl'
(defun cider-repl-mode-menu () 
  '("Return" "menu1" "menu2"))

(defun cider-repl-mode-func (index) 
  (cond ((= 0 index) 
         (show-clojure-workbuffer)) 
        ((= 1 index) 
         (message  "cider-repl-mode menu:%d" index)) 
        (t (message  "cider-repl-mode menu:%d" index))))

;; `automenu:clojurescript'
(defun automenu--clojurescript-mode-menu () 
  '("yarn dev" "node-repl" "cljs-repl" "compile" "release" "watch" "check" "start" "stop" "restart" ))

(defun automenu--clojurescript-mode-func (index) 
  (cond ((= 0 index) 
         (ome-run-command "yarn dev"))
        ((= 1 index) 
         (ome-run-command "shadow-cljs node-repl"))
        ((= 2 index) 
         (ome-run-command "shadow-cljs cljs-repl app" )) 
        ((= 3 index) 
         (ome-run-command "shadow-cljs compile app" )) 
        ((= 4 index) 
         (ome-run-command "shadow-cljs release app --debug" )) 
        ((= 5 index) 
         (ome-run-command "shadow-cljs watch app" )) 
        ((= 6 index) 
         (ome-run-command "shadow-cljs check app" )) 
        ((= 7 index) 
         (ome-run-command "shadow-cljs start")) 
        ((= 8 index) 
         (ome-run-command "shadow-cljs stop")) 
        ((= 9 index) 
         (ome-run-command "shadow-cljs restart")) 
        (t (message  "clojurescript menu:%d" index))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-clojure)
;; mod-clojure.el ends here
