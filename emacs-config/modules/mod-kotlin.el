;; -*- lexical-binding: t -*-
;; mod-kotlin.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2018 damon-kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2018-08-04
;; Modify: 2018-08-04
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
(package-require 'kotlin-mode)
(require 'kotlin-mode)

;; (package-require 'lsp-kotlin)
;; (require 'lsp-kotlin)

;; (lsp-define-stdio-client lsp-python "kotlin"
;; (lsp-make-traverser #'(lambda (dir)
;; (directory-files
;; dir
;; nil
;; "setup.py\\|Pipfile\\|setup.cfg\\|tox.ini")))
;; '("pyls"))

;; (add-hook 'kotlin-mode-hook #'lsp-kotlin-enable)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-kotlin)
;; mod-kotlin.el ends here
