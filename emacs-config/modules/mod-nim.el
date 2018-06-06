;; -*- lexical-binding: t -*-
;; mod-nim.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2018 damon-kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2018-06-05
;; Modify: 2018-06-05
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
(package-require 'nim-mode)
(require 'nim-mode)

(add-hook 'nim-mode-hook 'nimsuggest-mode)
;; The `nimsuggest-path' will be set the value of
;; (executable-find "nimsuggest"), automatically.
;; (setq nimsuggest-path "path/to/nimsuggest")

;; You may need to install below packages if you haven't installed yet.

;; -- Auto completion --
;; You can omit if you configured company-mode on `prog-mode-hook'
(add-hook 'nimsuggest-mode-hook 'company-mode)  ; auto complete package
;; -- Auto lint --
;; You can omit if you configured flycheck-mode on `prog-mode-hook'
(add-hook 'nimsuggest-mode-hook 'flycheck-mode) ; auto linter package

;; FYI:
;; might be supproted in the future, but not for now
;; (add-hook 'nimsuggest-mode-hook 'nimsuggest-mode)

(add-hook 'nimsuggest-mode-hook 'flymake-mode) ; builtin auto linter package

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-nim)
;; mod-nim.el ends here
