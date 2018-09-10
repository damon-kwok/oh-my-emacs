;; -*- lexical-binding: t -*-
;; init.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2015-2016 damon-kwok
;;
;; Author: gww <damon-kwok@outlook.com>
;; Create: 2016-01-05
;; Last-saved : 2016-04-19
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

;; (defcustom ome-logo (expand-file-name "~/.oh-my-emacs/logo.png")
;; "set ome logo. nil means official logo."
;; :type 'string)
;; (setq fancy-splash-image ome-logo)
;;(module-require 'mod-gc)
(module-require 'mod-coding)
(module-require 'mod-server)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(module-require 'mod-package)
(module-require 'mod-library)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `base'
(module-require 'mod-basic)
(module-require 'mod-splash)
(module-require 'mod-mouse)
(module-require 'mod-tabbar)
(module-require 'mod-complete)
(module-require 'mod-helm)
(module-require 'mod-projectile)
(module-require 'mod-speedbar)

(if (and (executable-find "offlineimap")
         (executable-find "mu"))
    (module-require 'mod-email))

(module-require 'mod-feed)
;; (module-require 'mod-dired)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `docs'
(module-require 'mod-csv)
(module-require 'mod-protobuf)
(module-require 'mod-markdown)
(module-require 'mod-orgmode)
(module-require 'mod-input)
(module-require 'mod-calendar)
(module-require 'mod-profiler)
(module-require 'mod-format)
(module-require 'mod-highlight)

;; (module-require 'mod-latex)
(module-require 'mod-ros)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `debug'
(module-require 'mod-gud)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `programming-languages'
(module-require 'mod-elisp)
(module-require 'mod-js)
;; (module-require 'mod-ess)

(if (and (executable-find "clang")
         (executable-find "clangd"))
    (module-require 'mod-clangd))

(if (executable-find "cquery")
    (module-require 'mod-cquery))

(if (executable-find "ccls")
    (module-require 'mod-ccls))

(if (executable-find "rdm")
    (module-require 'mod-rtags))
(module-require 'mod-java)
(module-require 'mod-lsp-py)

(if (executable-find "nasm")
    (module-require 'mod-asm))

(if (and (executable-find "erl")
         (executable-find "rebar3")
    (module-require 'mod-erlang))

(if (executable-find "mix") 
    (module-require 'mod-elixir))

(if (executable-find "ros")
    (module-require 'mod-slime))

;; (module-require 'mod-sly)
;; (module-require 'mod-csharp)

(if (executable-find "nimble")
    (module-require 'mod-nim))

(if (executable-find "hy")
    (module-require 'mod-hy))

;; (if (executable-find "go")
;; (module-require 'mod-go))

(if (and (executable-find "go")
         (executable-find "gocode"))
    (module-require 'mod-gocode))

(if (executable-find "ocaml")
    (module-require 'mod-ocaml))

(if (executable-find "lein") 
    (module-require 'mod-clojure))

(if (executable-find "cargo") 
    (module-require 'mod-rust))

(if (executable-find "stack") 
    (module-require 'mod-haskell))

(if (executable-find "git") 
    (module-require 'mod-git))

;; (package-require 'exwm)
;; (require 'exwm)
;; (require 'exwm-config)
;; (exwm-config-default)

;; (if (eq system-type 'gnu/linux)
;; (module-require 'mod-cc))
;; (if (and (unless system-type 'windows-nt)
;; (unless system-type 'ms-dos))
;; (module-require 'mod-cc))

;; (if (and (executable-find "ipython")
;; (executable-find "jupyter"))
;; (module-require 'mod-py))

;; (if (or (unless system-type 'windows-nt)
;; (unless system-type 'ms-dos))
;; (module-require 'mod-email))

;; (module-require 'mod-tree)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `music'
;; (package-require 'emms)
;; (module-require 'emms-setup)
;; (emms-standard)
;; (emms-default-players)
;;plugins: highlight-tail tabbar fill-column-indicator sr-speedbar yasnippet omnisharp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `tramp'
;; (package-require 'tramp)
;; (module-require 'tramp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `version'
;; (package-require 'magit)
;; (module-require 'magit)
;; (auto-fill-mode 0)
;; (package-require 'psvn)
;; (module-require 'psvn)

(require 'ediff)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(module-require 'mod-keybind)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (message "hello, emacs!")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-init)
;; init.el ends here
