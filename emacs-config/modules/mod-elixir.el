;; -*- lexical-binding: t -*-
;; mod-elixir.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2015-2016 Damon Kwok
;;
;; Author: gww <DamonKwok@msn.com>
;; Date: 2016-01-11
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
;; Set up the basic Elixir mode.
(package-require 'elixir-mode)

;; Alchemist offers integration with the Mix tool.
(package-require 'alchemist)
(with-eval-after-load "elixir-mode" (add-hook 'elixir-mode-hook 'alchemist-mode))

;; Bind some Alchemist commands to more commonly used keys.
(with-eval-after-load "alchemist" (define-key alchemist-mode-map (kbd "C-c C-l") 
				    (lambda () 
				      (interactive) 
				      (save-buffer) 
				      (alchemist-iex-compile-this-buffer)
				      (show-elixir-mode-repl)))
		      
		      (define-key alchemist-iex-mode-map (kbd "C-c C-z") 'show-elixir-mode-workbuffer)
		      (define-key alchemist-mode-map (kbd "C-x C-e") 'alchemist-iex-send-current-line-and-go) 
		      ;;(define-key elixir-mode-map (kbd "C-c C-c") 'alchemist-iex-compile-this-buffer)
		      (define-key elixir-mode-map (kbd "C-c C-z") 'show-elixir-mode-repl))


;; A Flycheck checker that uses Mix, so it finds project deps.
;; From https://github.com/ananthakumaran/dotfiles/blob/master/.emacs.d/init-elixir.el#L25-L42
(with-eval-after-load "flycheck" (flycheck-define-checker elixir-mix
							  "An Elixir syntax checker using the Elixir interpreter.See URL `http://elixir-lang.org/'." 
							  :command ("mix" "compile" source) 
							  :error-patterns ((error 
									    line-start
									    "** ("
									    (zero-or-more
									     not-newline)
									    ") "
									    (zero-or-more
									     not-newline)
									    ":"
									    line
									    ": "
									    (message)
									    line-end) 
									   (warning line-start
										    (one-or-more
										     (not (syntax
											   whitespace)))
										    ":" line ": "
										    (message)
										    line-end)) 
							  :modes elixir-mode) 
		      (add-to-list 'flycheck-checkers 'elixir-mix))

(defun show-elixir-mode-repl() 
  (interactive) 
  (setq temp-elixir-buffer-name (buffer-name (current-buffer))) 
  (m-show-compilation "*Alchemist-IEx*") 
  (alchemist-iex-run) 
  (switch-to-buffer-other-window temp-elixir-buffer-name) 
  (m-show-compilation "*Alchemist-IEx*" t))

(defun show-elixir-mode-workbuffer() 
  (interactive) 
  (switch-to-buffer-other-window temp-elixir-buffer-name) 
  (delete-other-windows) 
  (show-elixir-mode-repl) 
  (switch-to-buffer-other-window temp-elixir-buffer-name))

;; (define-key elixir-mode-map (kbd "C-c C-c")  'compile-current-buffer)
;; (define-key elixir-mode-map (kbd "C-c C-k")  'eval-buffer)
;; (define-key elixir-mode-map (kbd "C-M-\\")  'elisp-code-format)

(defun show-elixir-mode-menu(index))

(defun add (a b) 
  (+ a b))

(fset 'fadd (symbol-function (intern "add")))
(fadd 1 2)

(fset 'fadd2  (-> "add" intern symbol-function))
(fadd2 1 2)


;;
(provide 'mod-elixir)
;;; ohai-elixir.el ends here
