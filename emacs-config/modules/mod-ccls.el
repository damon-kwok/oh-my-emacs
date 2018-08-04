;; -*- lexical-binding: t -*-
;; mod-ccls.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2018 damon-kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2018-08-03
;; Modify: 2018-08-03
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

(package-require 'ccls)
(require 'ccls)

(setq ccls-executable "/home/damon/.ccls/bin/ccls")
(setq ccls-extra-init-params 
	  '(:cacheFormat "msgpack"))
(with-eval-after-load 'projectile 
  (setq projectile-project-root-files-top-down-recurring (append '("compile_commands.json" ".ccls")
																 projectile-project-root-files-top-down-recurring)))

(defun ccls//enable () 
  (condition-case nil (lsp-ccls-enable) 
	(user-error 
	 nil)))

(defun ccls-setup () 
  (interactive) 
  (ccls//enable) 
  (ccls-xref-find-custom "$ccls/base") 
  (ccls-xref-find-custom "$ccls/callers")
  ;; Use lsp-goto-implementation or lsp-ui-peek-find-implementation for derived types/functions
  (ccls-xref-find-custom "$ccls/vars")

  ;; Alternatively, use lsp-ui-peek interface
  (lsp-ui-peek-find-custom 'base "$ccls/base") 
  (lsp-ui-peek-find-custom 'callers "$ccls/callers") 
  (lsp-ui-peek-find-custom 'random "$ccls/random") ;; jump to a random declaration
  )

(add-hook 'c-mode-hook 'ccls-setup)
(add-hook 'c++-mode-hook 'ccls-setup)
;; (add-hook 'objc-mode-hook 'ccls-setup)

;; alternatively, (setq cquery-sem-highlight-method 'overlay)
(setq ccls-sem-highlight-method 'font-lock)

;; For rainbow semantic highlighting
(ccls-use-default-rainbow-sem-highlight)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-ccls)
;; mod-ccls.el ends here
