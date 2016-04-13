(require 'package)
(package-initialize)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(if (or (eq system-type 'windows-nt) 
	(eq system-type 'ms-dos)) 
    (progn (add-to-list 'load-path "~/config")) 
  (progn (add-to-list 'load-path "~/config")))

(require 'init)
