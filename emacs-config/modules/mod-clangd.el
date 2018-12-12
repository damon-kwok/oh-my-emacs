;; -*- lexical-binding: t -*-
;; mod-clangd.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2018 damon-kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2018-08-06
;; Modify: 2018-08-06
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
(require 'mod-cc)
(require 'mod-lsp)
;; (require 'lsp-clients)
;; (setq lsp-clients-clangd-executable (executable-find "clangd"))
(require 'lsp-clients) 
(lsp-clients-register-clangd)

(add-hook 'c-mode-hook #'lsp)
(add-hook 'c++-mode-hook #'lsp)
(add-hook 'objc-mode-hook #'lsp)

(defun clangd-setup () 
  (interactive) 
  (gen-cmake-file)
  ;; (cquery//enable)
  (push 'company-lsp company-backends))

(add-hook 'c-mode-hook #'clangd-setup)
(add-hook 'c++-mode-hook #'clangd-setup)
(add-hook 'objc-mode-hook #'clangd-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-clangd)
;; mod-clangd.el ends here
