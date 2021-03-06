;; -*- lexical-binding: t -*-
;; mod-elixir.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2020 Damon Kwok
;;
;; Author: damon <damon-kwok@outlook.com>
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
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;
;; Code:
;;
(require 'mod-package)
;;
(package-download 'elixir-mode)
(package-download 'alchemist)
;;
;; Set up the basic Elixir mode.
(add-to-list 'auto-mode-alist '("\\.ex$" . elixir-mode))
;;
(add-hook 'elixir-mode-hook ;;
          (lambda ()
            ;; Alchemist offers integration with the Mix tool.
            ;; (internal-require 'elixir-mode)
            (internal-require 'alchemist)
            (alchemist-mode)
            ;;
            ;; A `Flycheck' checker that uses Mix, so it finds project deps.
            ;; From https://github.com/ananthakumaran/dotfiles/blob/master/.emacs.d/init-elixir.el#L25-L42
            (with-eval-after-load "flycheck"
              ;;
              (flycheck-define-checker
               ;;
               elixir-mix
               "An Elixir syntax checker using the Elixir interpreter.See URL `http://elixir-lang.org/'."
               :command ("mix" "compile" source)
               :error-patterns ;;
               ((error
                 line-start
                 "** ("
                 (zero-or-more not-newline)
                 ") "
                 (zero-or-more not-newline)
                 ":"
                 line
                 ": "
                 (message)
                 line-end)
                (warning line-start (one-or-more (not (syntax whitespace))) ":" line ": " (message)
                         line-end))
               :modes elixir-mode)
              (add-to-list 'flycheck-checkers 'elixir-mix))
            ;;
            ;; Bind some Alchemist commands to more commonly used keys.
            (define-key alchemist-mode-map (kbd "C-c C-l")
              (lambda ()
                (interactive)
                (save-buffer)
                (alchemist-iex-compile-this-buffer)
                (show-elixir-mode-repl)))
            ;;
            (define-key alchemist-iex-mode-map (kbd "C-c C-z") 'show-elixir-mode-workbuffer)
            ;;
            (define-key alchemist-mode-map (kbd "C-x C-e")
              (lambda ()
                (interactive)
                (alchemist-iex-send-current-line-and-go)
                (show-elixir-mode-workbuffer)))
            ;;
            (define-key elixir-mode-map (kbd "C-c C-c") 'alchemist-mix-compile)
            ;;
            (define-key elixir-mode-map (kbd "C-c C-r") 'alchemist-mix-run)
            ;;
            (define-key elixir-mode-map (kbd "C-c C-z") 'show-elixir-mode-repl)))


(defun show-elixir-mode-repl()
  (interactive)
  (setq temp-elixir-buffer-name (buffer-name (current-buffer)))
  (ome-show-compilation "*Alchemist-IEx*")
  (alchemist-iex-run)
  (switch-to-buffer-other-window temp-elixir-buffer-name)
  (ome-show-compilation "*Alchemist-IEx*" t))

(defun show-elixir-mode-workbuffer()
  (interactive)
  (switch-to-buffer-other-window temp-elixir-buffer-name)
  (delete-other-windows)
  (show-elixir-mode-repl)
  (switch-to-buffer-other-window temp-elixir-buffer-name))

;; (define-key elixir-mode-map (kbd "C-c C-c")  'compile-current-buffer)
;; (define-key elixir-mode-map (kbd "C-c C-k")  'eval-buffer)
;; (define-key elixir-mode-map (kbd "C-M-\\")  'elisp-code-format)

;; `automenu:elixir'
(defun automenu--elixir-mode-menu ()
  '("repl" "compile" "run" "3" "4" "5" "6" "7" "8" "repl"))

(defun automenu--elixir-mode-func (index)
  (cond ;;
    ((= 0 index)
      (show-elixir-mode-repl))
    ((= 1 index)
      (alchemist-mix-compile))
    ((= 2 index)
      (alchemist-mix-run))
    ((= 3 index)
      (message  "elixir menu:%d" index))
    ((= 4 index)
      (message  "elixir menu:%d" index))
    ((= 5 index)
      (message  "elixir menu:%d" index))
    ((= 6 index)
      (message  "elixir menu:%d" index))
    ((= 7 index)
      (message  "elixir menu:%d" index))
    ((= 8 index)
      (message  "elixir menu:%d" index))
    ((= 9 index)
      (message  "elixir menu:%d" index))
    (t (message  "elixir menu:%d" index))))

;;
(provide 'mod-elixir)
;;; ohai-elixir.el ends here
