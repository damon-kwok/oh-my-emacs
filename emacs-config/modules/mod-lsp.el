;; -*- lexical-binding: t -*-
;; mod-lsp.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2018 damon-kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2018-05-29
;; Modify: 2018-05-29
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
(package-require 'lsp-mode)
(require 'lsp-mode)

;;
(package-require 'lsp-ui)
(require 'lsp-ui)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)
(add-hook 'lsp-mode-hook 'flycheck-mode)
(define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
(define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)

;; (lsp-ui-peek-jump-backward)
;; (lsp-ui-peek-jump-forward)

;;yasnippet
(require 'mod-complete)

;; company
(package-require 'company)
(require 'company)                                   ; load company mode

(package-require 'company-lsp)
(require 'company-lsp)
(push 'company-lsp company-backends)

;; company-lsp-cache-candidates: Can be set to 'auto, t, or nil.
(setq company-lsp-cache-candidates 'auto)
(setq company-lsp-async t)
(setq company-lsp-enable-snippet t)
(setq company-lsp-enable-recompletion t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-lsp)
;; mod-lsp.el ends here
