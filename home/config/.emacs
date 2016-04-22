(require 'package)
(package-initialize)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(add-to-list 'load-path "~/config")
(add-to-list 'load-path "~/config/modules")
(add-to-list 'load-path "~/config/themes")

(require 'init)