(require 'package)
(package-initialize)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(add-to-list 'load-path "~/.medusa-ide/home/config")
(add-to-list 'load-path "~/.medusa-ide/home/config/modules")
(add-to-list 'load-path "~/.medusa-ide/home/config/themes")

(require 'init)
