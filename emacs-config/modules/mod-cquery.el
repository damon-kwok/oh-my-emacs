;; -*- lexical-binding: t -*-
;; mod-cquery.el --- This is where you apply your OCD.
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

;; https://maskray.me/blog/2017-12-03-c++-language-server-cquery
;; https://github.com/cquery-project/cquery/wiki/Emacs
(require 'mod-lsp)

(package-require 'cquery)
(require 'cquery)

(setq cquery-executable "/home/damon/.cquery/bin/cquery")

(setq cquery-extra-init-params 
      '(:index (:comments 2) 
               :cacheFormat "msgpack" 
               :completion (:detailedLabel t)))

(with-eval-after-load 'projectile 
  (setq projectile-project-root-files-top-down-recurring (append '("compile_commands.json"
                                                                   ".cquery")
                                                                 projectile-project-root-files-top-down-recurring)))

(defun cquery//enable () 
  (condition-case nil (lsp-cquery-enable) 
    (user-error 
     nil)))

;; Also see lsp-project-whitelist lsp-project-blacklist cquery-root-matchers

(defun cquery-setup () 
  (interactive) 
  (cquery//enable) 
  (push 'company-lsp company-backends) 
  (cquery-xref-find-custom "$cquery/base") 
  (cquery-xref-find-custom "$cquery/callers") 
  (cquery-xref-find-custom "$cquery/derived") 
  (cquery-xref-find-custom "$cquery/vars")

  ;; Alternatively, use lsp-ui-peek interface
  (lsp-ui-peek-find-custom 'base "$cquery/base") 
  (lsp-ui-peek-find-custom 'callers "$cquery/callers") 
  (lsp-ui-peek-find-custom 'random "$cquery/random") ;; jump to a random declaration
  )

;; (add-hook 'c-mode-hook 'cquery-setup)
;; (add-hook 'c++-mode-hook 'cquery-setup)
;; (add-hook 'objc-mode-hook 'cquery-setup)

(setq company-transformers nil company-lsp-async t company-lsp-cache-candidates nil)

;;;;;;;;;;;;;;;;;;;;;;;;;
(setq cquery-sem-highlight-method 'font-lock)
;; alternatively, (setq cquery-sem-highlight-method 'overlay)

;; For rainbow semantic highlighting
(cquery-use-default-rainbow-sem-highlight)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-key c-mode-map (kbd "C-c C-z")  'cquery-setup)
(define-key c++-mode-map (kbd "C-c C-z")  'cquery-setup)
(define-key objc-mode-map (kbd "C-c C-z")  'cquery-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-cquery)
;; mod-cquery.el ends here
