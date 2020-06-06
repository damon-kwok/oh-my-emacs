;; -*- lexical-binding: t -*-
;; mod-haskell.el --- This is where you apply your OCD.
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
;;
;; (package-download 'intero)
;; (package-download 'dante)
(package-download 'flycheck-haskell)
(package-download 'lsp-haskell)
;;
(add-hook 'haskell-mode-hook;;
          (lambda ()
            ;; (internal-require 'intero)
            (internal-require 'dante)
            (internal-require 'mod-lsp)
            (internal-require 'flycheck-haskell)
            (internal-require 'lsp-haskell)
            ;;
            ;; (intero-mode)
            (flycheck-mode)
            ;;
            (setq lsp-haskell-process-path-hie "ghcide")
            (setq lsp-haskell-process-args-hie '())
            (lsp)
            (lsp-ui-mode)
            ;;
            ;; dante
            ;; (dante-mode)
            ;; (add-hook 'dante-mode-hook;;
            ;;           '(lambda ()
            ;;              (flycheck-add-next-checker ; 'haskell-dante
            ;;               '(warning . haskell-hlint))))
            ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-haskell)
;; mod-haskell.el ends here
