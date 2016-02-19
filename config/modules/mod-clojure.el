;;---------------------------
;;env
;;(setq-default env-seg ":")
;;(if (eq system-type 'windows-nt) (setq env-seg ";"))

;;(setenv-ext "LEIN_HOME" "ROOT" "leiningen-1.5.2-win/lein")
;;(setenv-ext "LEIN" "ROOT" "leiningen-1.5.2-win/lein")
;;(setenv-ext "LEIN_JAR" "LEIN_HOME" "leiningen-2.0.0-preview10-standalone.jar")
;;(setenv "PATH" (concat (getenv "LEIN_HOME") env-seg (getenv "PATH")))

;;(setq-default DEFAULT_PATH (getenv "PATH"))
;;(setq-default GOOS "windows")

(require 'mod-package)

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


(provide 'mod-clojure)
