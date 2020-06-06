;; -*- lexical-binding: t -*-
;; mod-ocaml.el --- This is where you apply your OCD.
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'mod-package)
;;;
(package-download 'tuareg)
(add-to-list 'auto-mode-alist '("\\.ml$" . tuareg-mode))
(add-hook 'tuareg-mode-hook (lambda()
                              (when (functionp 'prettify-symbols-mode)
                                (prettify-symbols-mode))
                              (package-require 'merlin)

                              ;; directory containing merlin.el
                              (push "<SHARE_DIR>/emacs/site-lisp" load-path)

                              ;; needed only if ocamlmerlin not already in your PATH
                              (setq merlin-command "<BIN_DIR>/ocamlmerlin")
                              (autoload 'merlin-mode "merlin" "Merlin mode" t)
                              (add-hook 'tuareg-mode-hook 'merlin-mode)
                              (add-hook 'caml-mode-hook 'merlin-mode)

                              ;; `flycheck'
                              (package-require 'flycheck-ocaml)
                              (with-eval-after-load 'merlin
                                ;; Disable Merlin's own error checking
                                (setq merlin-error-after-save nil)

                                ;; Enable Flycheck checker
                                (flycheck-ocaml-setup))
                              (add-hook 'tuareg-mode-hook #'merlin-mode)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-ocaml)
;; mod-ocaml.el ends here
