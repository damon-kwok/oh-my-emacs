;; -*- lexical-binding: t -*-
;; mod-zig.el --- This is where you apply your OCD.
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
(package-download 'zig-mode)
(add-to-list 'auto-mode-alist '("\\.zig\\" . zig-mode))
(add-hook 'zig-mode-hook ;;
  (lambda ()
    (internal-require 'zig-mode)
    ;;lsp
    (internal-require 'mod-lsp)
    (add-to-list 'lsp-language-id-configuration '(zig-mode . "zig"))
    (lsp-register-client (make-lsp-client :new-connection (lsp-stdio-connection "<path to zls>")
                           :major-modes '(zig-mode)
                           :server-id 'zls))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-zig)
;; mod-zig.el ends here
