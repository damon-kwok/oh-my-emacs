(require 'package)
(package-initialize)

;; (toggle-frame-fullscreen)
(toggle-debug-on-error)
(toggle-debug-on-quit)

(add-to-list 'load-path "~/emacs-config")
(add-to-list 'load-path "~/emacs-config/modules")
(add-to-list 'custom-theme-load-path "~/emacs-config/themes")

(add-to-list 'load-path "~/my-emacs-config/emacs-config")
(add-to-list 'load-path "~/my-emacs-config/emacs-config/modules")
(add-to-list 'custom-theme-load-path "~/my-emacs-config/emacs-config/themes")

;;avoid compile error
;;(setq byte-compile-warnings nil) 
;; (byte-recompile-directory (expand-file-name (concat (getenv "ROOT") "/emacs-config/modules")) 0)

;; Display the total loading time in the minibuffer
(defun display-startup-echo-area-message ()
  "Display startup echo area message."
  (message "Initialized in %s" (emacs-init-time)))

;; Benchmark loading time file by file and display it in the *Messages* buffer
 (when init-file-debug (require 'benchmark))

(defun module-require(mod)
 (when init-file-debug
	(message "Module '%s' loaded in %.2fs" mod (benchmark-elapse (require mod))))
	(require mod))

(require 'mod-init)
