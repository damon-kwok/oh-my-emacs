;;; mod-lsp-elixir.el --- This is where you apply your OCD.  -*- lexical-binding: t -*-
;;
;; Copyright (C) 2009-2021 Damon Kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2021-02-25
;; Modify: 2021-02-25
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
;;; Code:
(require 'mod-package)
;;
(require 'mod-lsp)
(add-to-list 'auto-mode-alist '("\\.ex$" . elixir-mode))
(add-hook 'elixir-mode-hook;;
         (lambda() (internal-require 'mod-lsp)
            (lsp)))
;;
(provide 'mod-lsp-elixir)

;;; mod-lsp-elixir.el ends here
