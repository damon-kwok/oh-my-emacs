;; -*- lexical-binding: t -*-
;; mod-java.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2018 damon-kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2018-01-15
;; Modify: 2018-01-15
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
;; `lsp-javacomp'
;; (package-require 'lsp-javacomp)
;; (require 'lsp-javacomp)
;; (define-key java-mode-map (kbd "C-M-i") 'completion-at-point)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; `eclipse.jdt.ls' Eclipse JDT Language Server
(package-require 'lsp-java)
(require 'lsp-java)
(add-hook 'java-mode-hook #'lsp-java-enable)

;; set the projects that are going to be imported into the workspace.
(setq lsp-java--workspace-folders (list (concat (getenv "HOME") "/projects/java") 
                                        (concat (getenv "HOME") "/workspace") 
                                        (concat (getenv "HOME") "/eclipse-workspace")))
;; (unless (executable-find "ipython")
;; (ome-run-command "install-java-lsp-server"))

(setq  lsp-java-server-install-dir "~/.emacs.d/eclipse.jdt.ls/server/")

(defun install-lsp-java-server () 
  "install java lsp server" 
  (interactive) 
  (ome-run-command "install-lsp-java-server"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; `lsp-intellij' Exposes IntelliJ IDEA features through the Language Server Protocol.
;; (package-require 'lsp-intellij)

;; (with-eval-after-load 'lsp-mode
;; (require 'lsp-intellij)
;; (add-hook 'java-mode-hook #'lsp-intellij-enable))

;; (require 'lsp-ui)
;; (add-hook 'lsp-after-open-hook #'lsp-ui-mode)

;; (require 'company-lsp)
;; (setq company-lsp-enable-snippet t
;; company-lsp-cache-candidates t)
;; (push 'company-lsp company-backends)
;; (push 'java-mode company-global-modes)

;; if using Kotlin
;; (push 'kotlin-mode company-global-modes)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-java)
;; mod-java.el ends here
