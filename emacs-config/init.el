(require 'package)
(package-initialize)

(toggle-debug-on-error)

(add-to-list 'load-path "~/emacs-config")
(add-to-list 'load-path "~/emacs-config/modules")
(add-to-list 'load-path "~/emacs-config/themes")

(require 'mod-init)
