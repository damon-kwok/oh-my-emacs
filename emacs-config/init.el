(require 'package)
;; (package-initialize)
;;(if (< emacs-major-version 27) (package-initialize))
;;(when (version< emacs-version "27.1") (package-initialize))
;;(unless package--initialized (package-initialize t))
(unless package--initialized (package-initialize))

;; (toggle-frame-fullscreen)
;; (toggle-debug-on-error)
;; (toggle-debug-on-quit)
(setq debug-on-error t)
(setq debug-on-quit nil)

(add-to-list 'load-path "~/.oh-my-emacs/emacs-config")
(add-to-list 'load-path "~/.oh-my-emacs/emacs-config/modules")
(add-to-list 'load-path "~/.oh-my-emacs/emacs-config/preferences")
(add-to-list 'custom-theme-load-path "~/.oh-my-emacs/emacs-config/themes")

;; Display the total loading time in the minibuffer
(defun display-startup-echo-area-message () 
  "Display startup echo area message."
  (message "Initialized in %s" (emacs-init-time)))

(require 'benchmark)
(defun module-require (pkg) 
  (message "Module '%s' loaded in %.3fs" pkg (benchmark-elapse (require pkg))) )

(defun internal-require (pkg) 
  ;;(message "---->require '%s' in %.3fs" pkg (benchmark-elapse (require pkg))
  (require pkg))
;;
;; Benchmark loading time file by file and display it in the *Messages* buffer
;; (when init-file-debug (require 'benchmark))
;; (defun module-require(mod)
;; (when init-file-debug
;; (message "Module '%s' loaded in %.2fs" mod (benchmark-elapse (require mod))))
;; (require mod))
;;
;; avoid compile error
;;(setq byte-compile-warnings nil)
;; (byte-recompile-directory (expand-file-name "~/.oh-my-emacs/emacs-config/modules") 0)
;;
(module-require 'mod-init)
