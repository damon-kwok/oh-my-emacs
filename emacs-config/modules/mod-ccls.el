;; -*- lexical-binding: t -*-
;; mod-ccls.el --- This is where you apply your OCD.
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
(package-download 'ccls)
(package-download 'cuda-mode)
(package-download 'lsp-mode)
(package-download 'lsp-ui)
(package-download 'company-lsp)
;;
(defun cc-mode-init ()
  (internal-require 'mod-cc)
  (internal-require 'mod-lsp)
  ;;
  (setq ccls-initialization-options
    '(:index (:comments 2)
       :completion (:detailedLabel t)))
  (internal-require 'ccls)
  ;;
  (lsp))

(dolist (hook '(c-mode c++-mode objc-mode cuda-mode))
  (add-hook hook 'cc-mode-init))
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-ccls)
;; mod-ccls.el ends here
