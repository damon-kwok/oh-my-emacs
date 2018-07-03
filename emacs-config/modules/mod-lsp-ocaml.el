;; -*- lexical-binding: t -*-
;; mod-lsp-ocaml.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2018 damon-kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2018-01-18
;; Modify: 2018-01-18
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
;;
(require 'mod-lsp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(package-require 'lsp-ocaml)
(require 'lsp-ocaml)

(add-hook 'tuareg-mode-hook #'lsp-ocaml-enable)
(add-hook 'caml-mode-hook #'lsp-ocaml-enable)
(add-hook 'reason-mode-hook #'lsp-ocaml-enable) ;; for Reason support
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(package-require 'tuareg)
(require 'tuareg)

(add-hook 'tuareg-mode-hook
            (lambda()
              (when (functionp 'prettify-symbols-mode)
                (prettify-symbols-mode))))



(package-require 'merlin)
(require 'merlin)

(push "<SHARE_DIR>/emacs/site-lisp" load-path) ; directory containing merlin.el
(setq merlin-command "<BIN_DIR>/ocamlmerlin")  ; needed only if ocamlmerlin not already in your PATH
(autoload 'merlin-mode "merlin" "Merlin mode" t)
(add-hook 'tuareg-mode-hook 'merlin-mode)
(add-hook 'caml-mode-hook 'merlin-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-lsp-ocaml)
;; mod-lsp-ocaml.el ends here
