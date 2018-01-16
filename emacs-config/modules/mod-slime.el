;; -*- lexical-binding: t -*-
;; mod-slime.el --- This is where you apply your OCD.
;;
;; Author     : Dylan R. E. Moonfire (original)
;; Maintainer : Jostein Kjønigsen <jostein@gmail.com>
;; Created    : Feburary 2005
;; Modified   : November 2015
;; Version    : 0.8.12
;; Keywords   : emacs elisp
;; Package-Version: 20160117.1321
;; X-URL      : https://github.com/josteink/csharp-mode
;; Last-saved : 2016-Jan-06
;; Copyright (C) 2015-2016 Damon Kwok
;;
;; Author: gww <damon-kwok@outlook.com>
;; Date: 2016-01-21
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
;;
(require 'mod-package)

(package-require 'slime)
(require 'slime)
(slime-setup)
;; (package-require "slime/contrib")

(defun slime-fuzzy-init () 
  (message "-------------------slime-fuzzy-init-------------------"))

;;slime-asdf slime-autodoc slime-banner slime-c-p-c slime-cl-indent slime-clipboard
;;slime-compiler-notes-tree slime-editing-commands slime-enclosing-context
;;slime-fancy-inspector slime-fancy slime-fontifying-fu slime-fuzzy slime-highlight-edits
;;slime-hyperdoc slime-indentation slime-mdot-fu slime-media slime-motd slime-mrepl
;;slime-package-fu slime-parse slime-presentation-streams slime-presentations
;;slime-references slime-repl slime-sbcl-exts slime-scheme slime-scratch slime-snapshot
;;slime-sprof slime-tramp slime-typeout-frame slime-xref-browser

(eval-after-load "slime" '(progn
							;;(slime-setup '(slime-repl slime-fuzzy))
							(slime-setup '(slime-asdf slime-autodoc slime-banner slime-c-p-c
													  slime-cl-indent slime-clipboard
													  slime-compiler-notes-tree
													  slime-editing-commands slime-enclosing-context
													  slime-fancy-inspector slime-fancy
													  slime-fontifying-fu slime-fuzzy
													  slime-highlight-edits slime-hyperdoc
													  slime-indentation slime-mdot-fu slime-media ;;slime-motd
													  slime-mrepl slime-package-fu slime-parse
													  slime-presentation-streams slime-presentations
													  slime-references slime-repl slime-sbcl-exts
													  slime-scheme slime-scratch slime-snapshot
													  slime-sprof slime-tramp ;;slime-typeout-frame ;;muliti-frame
													  slime-xref-browser)) 
							(setq slime-truncate-lines t) 
							(setq swank:*globally-redirect-io*  t) 
							(setq slime-complete-symbol-function ' slime-fuzzy-complete-symbol) 
							(setq slime-net-coding-system 'utf-8-unix)))

;;-------------------------------------------------
;; Set your lisp system and, optionally, some contribs
(setq inferior-lisp-program "sbcl")
;; (setq inferior-lisp-program (concat (getenv "HOME") "/dev/clasp/build/clasp"))
;; (setq inferior-lisp-program (concat (getenv "HOME") "/dev/ccl/lx86cl64"))
(setq slime-contribs '(slime-fancy))
(require 'slime-autoloads)

;; Enable paredit for Clojur
(package-require 'paredit)
(require 'paredit)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'slime-repl-mode-hook 'enable-paredit-mode)

;; This is useful for working with camel-case tokens, like names of
;; Java classes (e.g. JavaClassName)
(add-hook 'slime-repl-mode-hook 'subword-mode)


;; `keybind'
(defun show-lisp-repl() 
  (interactive) 
  (delete-other-windows) 
  (setq temp-lisp-buffer-name (buffer-name (current-buffer)))
  ;; (slime-switch-to-output-buffer)
  (if (slime-connected-p) 
	  (slime-switch-to-output-buffer) 
	(slime)) 
  (if (< (/ (frame-height) 3) 
		 (window-height)) 
	  (shrink-window (/ (window-height) 2))))

(defun show-lisp-workbuffer() 
  (interactive) 
  (switch-to-buffer-other-window temp-elixir-buffer-name) 
  (delete-other-windows) 
  (show-lisp-repl) 
  (slime-switch-to-output-buffer))

(define-key lisp-mode-map (kbd "C-c C-q") 'slime-repl-quit)
(define-key lisp-mode-map (kbd "C-c C-z") 'show-lisp-repl)

(define-key slime-repl-mode-map (kbd "C-c C-q") 'slime-repl-quit)
(define-key slime-repl-mode-map (kbd "C-c C-z") 'show-lisp-workbuffer)
;;
(provide 'mod-slime)
;; mod-slime.el ends here
