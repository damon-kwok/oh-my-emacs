(require 'package)
(package-initialize)

(toggle-debug-on-error)
(toggle-debug-on-quit)

(add-to-list 'load-path "~/emacs-config")
(add-to-list 'load-path "~/emacs-config/modules")
(add-to-list 'load-path "~/emacs-config/themes")

(add-to-list 'load-path "~/my-emacs-config/emacs-config")
(add-to-list 'load-path "~/my-emacs-config/emacs-config/modules")
(add-to-list 'load-path "~/my-emacs-config/emacs-config/themes")

(require 'mod-init)
