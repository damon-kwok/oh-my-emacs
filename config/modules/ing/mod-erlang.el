;;; mod-erlang.el --- gww

;; Copyright (C) 2013  gww

;; Author: gww <gww@192.168.0.171>
;; Keywords: lisp

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:
(require 'mod-package)

;; This is needed for Erlang mode setup
;;(setq erlang-root-dir "/usr/local/lib/erlang")
;;(setq load-path (cons "/usr/local/lib/erlang/lib/tools-2.6.10/emacs" load-path))
;;(load-plugin-in "erlang-tools-2.6.10")
;(setq exec-path (cons "/usr/local/lib/erlang/bin" exec-path))
(require 'erlang-start)

;;(load-plugin "distel/elisp")
(package-require 'distel)
(require 'distel)
(distel-setup)

(defun show-erlang-shell()
  (interactive)
  (setq temp-buffer-name (buffer-name (current-buffer)))
  (if (get-buffer "*erlang*")
      (switch-to-buffer-other-window "*erlang*")
    (erlang-shell-display))
  (switch-to-buffer-other-window temp-buffer-name)
  (show-output-window "*erlang*" t))

(defun hide-erlang-shell()
  (interactive)
  (other-window 1)
  (delete-other-windows))

;; Some Erlang customizations
(add-hook 'erlang-shell-mode-hook
	  (lambda ()
	    ;;define C-c z
	    (define-key erlang-shell-mode-map (kbd "C-c z") 'hide-erlang-shell)))

(add-hook 'erlang-mode-hook
	  (lambda ()
	    ;; when starting an Erlang shell in Emacs, default in the node name
	    (setq inferior-erlang-machine-options '("-sname" "emacs"))
	    ;; add Erlang functions to an imenu menu
	    (imenu-add-to-menubar "imenu")
	    ;;define C-c z
	    (define-key erlang-mode-map (kbd "C-c z") 'show-erlang-shell)))

;; A number of the erlang-extended-mode key bindings are useful in the shell too
(defconst distel-shell-keys
  '(("\C-\M-i"   erl-complete)
    ("\M-?"      erl-complete)	
    ("\M-."      erl-find-source-under-point)
    ("\M-,"      erl-find-source-unwind) 
    ("\M-*"      erl-find-source-unwind) 
    )
  "Additional keys to bind when in Erlang shell.")

(add-hook 'erlang-shell-mode-hook
	  (lambda ()
	    ;; add some Distel bindings to the Erlang shell
	    (dolist (spec distel-shell-keys)
	      (define-key erlang-shell-mode-map (car spec) (cadr spec)))))

(provide 'mod-erlang)
;;; mod-erlang.el ends here

