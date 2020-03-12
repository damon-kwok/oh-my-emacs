;; -*- lexical-binding: t -*-
;; mod-ccls-old.el --- This is where you apply your OCD.
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
;;(setq ccls-executable "/home/damon/.ccls/bin/ccls")
(setq ccls-initialization-options 
      '(:index (:comments 2) 
               :completion (:detailedLabel t)))



;; (setq ccls-extra-init-params 
      ;; '(:index (:comments 2) 
               ;; :completion (:detailedLabel t)))

;; (with-eval-after-load 'projectile 
  ;; (setq projectile-project-root-files-top-down-recurring ;;
        ;; (append '("compile_commands.json" ".ccls")
                ;; projectile-project-root-files-top-down-recurring)))

(defun ccls//enable () 
  (condition-case nil ;;
      (lsp) 
    (user-error 
     nil)))

(defun ccls-setup () 
  (interactive)
  (ome-gen-cmake-file)
  (ccls//enable)
  ;;
  ;; direct callers
  (lsp-find-custom "$ccls/call")
  ;; callers up to 2 levels
  (lsp-find-custom "$ccls/call" '(:levels 2))
  ;; direct callees
  (lsp-find-custom "$ccls/call" '(:callee t))

  (lsp-find-custom "$ccls/vars")
  ;; Use lsp-goto-implementation or lsp-ui-peek-find-implementation (textDocument/implementation) for derived types/functions
  ;; $ccls/inheritance is more general

  ;; Alternatively, use lsp-ui-peek interface
  (lsp-ui-peek-find-custom "$ccls/call")
  (lsp-ui-peek-find-custom "$ccls/call" '(:callee t))
  ;;
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; `helper'
(defun ccls/callee () (interactive) (lsp-ui-peek-find-custom "$ccls/call" '(:callee t)))
(defun ccls/caller () (interactive) (lsp-ui-peek-find-custom "$ccls/call"))
(defun ccls/vars (kind) (lsp-ui-peek-find-custom "$ccls/vars" `(:kind ,kind)))
(defun ccls/base (levels) (lsp-ui-peek-find-custom "$ccls/inheritance" `(:levels ,levels)))
(defun ccls/derived (levels) (lsp-ui-peek-find-custom "$ccls/inheritance" `(:levels ,levels :derived t)))
(defun ccls/member (kind) (interactive) (lsp-ui-peek-find-custom "$ccls/member" `(:kind ,kind)))

;; References w/ Role::Role
(defun ccls/references-read () (interactive)
  (lsp-ui-peek-find-custom "textDocument/references"
    (plist-put (lsp--text-document-position-params) :role 8)))

;; References w/ Role::Write
(defun ccls/references-write ()
  (interactive)
  (lsp-ui-peek-find-custom "textDocument/references"
   (plist-put (lsp--text-document-position-params) :role 16)))

;; References w/ Role::Dynamic bit (macro expansions)
(defun ccls/references-macro () (interactive)
  (lsp-ui-peek-find-custom "textDocument/references"
   (plist-put (lsp--text-document-position-params) :role 64)))

;; References w/o Role::Call bit (e.g. where functions are taken addresses)
(defun ccls/references-not-call () (interactive)
  (lsp-ui-peek-find-custom "textDocument/references"
   (plist-put (lsp--text-document-position-params) :excludeRole 32)))

;; ccls/vars ccls/base ccls/derived ccls/members have a parameter while others are interactive.
;; (ccls/base 1) direct bases
;; (ccls/derived 1) direct derived
;; (ccls/member 2) => 2 (Type) => nested classes / types in a namespace
;; (ccls/member 3) => 3 (Func) => member functions / functions in a namespace
;; (ccls/member 0) => member variables / variables in a namespace
;; (ccls/vars 1) => field
;; (ccls/vars 2) => local variable
;; (ccls/vars 3) => field or local variable. 3 = 1 | 2
;; (ccls/vars 4) => parameter

;; References whose filenames are under this project
;; (lsp-ui-peek-find-references nil (list :folders (vector (projectile-project-root))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (add-hook 'c-mode-hook 'ccls-setup)
;; (add-hook 'c++-mode-hook 'ccls-setup)
;; (add-hook 'objc-mode-hook 'ccls-setup)

;; alternatively, (setq cquery-sem-highlight-method 'overlay)
(setq ccls-sem-highlight-method 'font-lock)
;; For rainbow semantic highlighting
(ccls-use-default-rainbow-sem-highlight)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-ccls-old)
;; mod-ccls-old.el ends here
