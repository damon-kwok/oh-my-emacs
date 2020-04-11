;; -*- lexical-binding: t -*-
;; init.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2015-2016 damon-kwok
;;
;; Author: damon-kwok <damon-kwok@outlook.com>
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

;;(package-require 'esup)
;; (module-require 'mod-profiler)
(module-require 'mod-gc)
;; (package-require 'exec-path-from-shell)
;; (when (memq window-system '(mac ns x))
;; (exec-path-from-shell-initialize))
(module-require 'mod-coding)
(module-require 'mod-sexp)
(module-require 'mod-elisp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(module-require 'mod-package)
(module-require 'mod-library)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `base'
(module-require 'mod-basic)
(module-require 'mod-splash)
(module-require 'mod-ui-frame)
(module-require 'mod-ui-buffer)
(module-require 'mod-modeline)
(module-require 'mod-ui-editor)
(module-require 'mod-highlight)
(module-require 'mod-tabs)
;; (module-require 'mod-tabbar)
(module-require 'mod-mouse)
(module-require 'mod-complete)
(module-require 'mod-helm)
(module-require 'mod-projectile)
;; (module-require 'mod-treemacs)
;; (module-require 'mod-speedbar)
;; (module-require 'mod-dired)
;; (module-require 'mod-feed)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `docs'
(module-require 'mod-text)
(module-require 'mod-csv)
(module-require 'mod-rst)
(module-require 'mod-adoc)
(module-require 'mod-toml)
(module-require 'mod-orgmode)
(module-require 'mod-markdown)
(module-require 'mod-protobuf)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `utils'
(module-require 'mod-calendar)
(module-require 'mod-format)
;; (module-require 'mod-latex)
(module-require 'mod-ros)
;; (module-require 'mod-book)
(module-require 'mod-ome)
(module-require 'mod-input)
(module-require 'mod-git "git")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `debug'
;; (module-require 'mod-gud)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `programming-languages'
(module-require 'mod-sh)
(module-require 'mod-js)
(module-require 'mod-web)
(module-require 'mod-dart)
(module-require 'mod-ess)
(module-require 'mod-perl "perl")
(module-require 'mod-php)
(module-require 'mod-asm "nasm")
(module-require 'mod-groovy)
;; `java'
(if (file-directory-p "~/.emacs.d/eclipse.jdt.ls/server/")
  (module-require 'mod-java))

;; `cc'
;; (if (or (eq system-type 'windows-nt) ;;gnu/linux
;; (eq system-type 'ms-dos))
;; (defconst cc-lang-server "rtags")
;; (defconst cc-lang-server "clangd")))
(defconst cc-lang-server "ccls")

(cond ((and
         (string= cc-lang-server "clangd")
         (or (executable-find "clangd")
           (executable-find "clangd-devel")))
        (module-require 'mod-clangd))
  ((and
     (string= cc-lang-server "cquery")
     (executable-find "cquery"))
    (module-require 'mod-cquery))
  ((and
     (string= cc-lang-server "ccls")
     (executable-find "ccls"))
    (module-require 'mod-ccls))
  ((and
     (string= cc-lang-server "rtags")
     (executable-find "rdm"))
    (module-require 'mod-rtags)))

;; `python'
;; (if (and (executable-find "ipython")
;; (executable-find "jupyter"))
;; (module-require 'mod-py))
(module-require 'mod-lsp-py "pyls")
(if (and (executable-find "erl")
      (executable-find "rebar3"))
  (module-require 'mod-erlang))

(module-require 'mod-elixir "mix")
(module-require 'mod-lisp "ros")
(module-require 'mod-scheme "scheme")
(module-require 'mod-racket "racket")

;; (module-require 'mod-sly)
(module-require 'mod-csharp)
(module-require 'mod-go "gopls")
;; (module-require 'mod-gocode "gocode")

(module-require 'mod-haskell "stack")
(module-require 'mod-ocaml "opam")
(module-require 'mod-clojure "lein")
(module-require 'mod-hy "hy")
(module-require 'mod-janet "janet")
;; Language IV
(module-require 'mod-rust "cargo")
(module-require 'mod-nim "nimble")
(module-require 'mod-pony "ponyc")
(module-require 'mod-zig "zig")
(module-require 'mod-gluon)
(module-require 'mod-verona "veronac")


;; (package-require 'exwm 'exwm 'wxwm-config)
;; (exwm-config-default)
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
(package-require 'magit)
;; (module-require 'git)
(auto-fill-mode 0)
;; (package-require 'psvn)
;; (module-require 'psvn)

(internal-require 'ediff)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (module-require 'mod-keybind)
(defun show-super-menu ()
  "docstring"
  (interactive)
  (load "mod-keybind.el")
  (message "What's up?")
  (hydra-super-menu/body))

;; (global-set-key (kbd "C-M-z") 'show-super-menu1)
(global-set-key (kbd "M-z") 'show-super-menu)
(module-require 'mod-keybind)
(module-require 'mod-edit-server)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (message "hello, emacs!")
(module-require 'mod-server)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-init)
;; init.el ends here
