;; -*- lexical-binding: t -*-
;; mod-js.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2017 damon-kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2017-12-27
;; Modify: 2017-12-27
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
;; (package-require 'lsp-mode)
;; (require 'lsp-mode)

;; (package-require 'lsp-ui)
;; (require 'lsp-ui)
;; (add-hook 'lsp-mode-hook 'lsp-ui-mode)

;; `lsp-js'
;; (package-require 'lsp-javascript-typescript)
;; (require 'lsp-javascript-typescript)
;; (add-hook 'js-mode-hook #'lsp-javascript-typescript-enable)
;; (add-hook 'typescript-mode-hook #'lsp-javascript-typescript-enable) ;; for typescript support
;; (add-hook 'js2-mode-hook #'lsp-javascript-typescript-enable) ;; for js2-mode support
;; (add-hook 'js3-mode-hook #'lsp-javascript-typescript-enable) ;; for js3-mode support
;; (add-hook 'rjsx-mode #'lsp-javascript-typescript-enable) ;; for rjsx-mode support

;; `nodejs-repl'
(package-require 'nodejs-repl)
(require 'nodejs-repl)

(add-hook 'js-mode-hook
          (lambda ()
            (define-key js-mode-map (kbd "C-x C-e") 'nodejs-repl-send-last-expression)
            (define-key js-mode-map (kbd "C-c C-j") 'nodejs-repl-send-line)
            (define-key js-mode-map (kbd "C-c C-r") 'nodejs-repl-send-region)
            (define-key js-mode-map (kbd "C-c C-l") 'nodejs-repl-load-file)
            (define-key js-mode-map (kbd "C-c C-z") 'nodejs-repl-switch-to-repl)))


;; `company'
(package-require 'company-lsp)
(require 'company-lsp)
(push 'company-lsp company-backends)

;; `js2'
(package-require 'js2-mode)
(require 'js2-mode)

;; `js2-refactor'
(package-require 'js2-refactor)
(require 'js2-refactor)
(add-hook 'js2-mode-hook #'js2-refactor-mode)
(setq js2-skip-preprocessor-directives t)

(js2r-add-keybindings-with-prefix "C-c C-m")
;; eg. extract function with `C-c C-m ef`.

(js2r-add-keybindings-with-modifier "C-s-")
;; eg. extract function with `C-s-e C-s-f`.

(define-key js2-refactor-mode-map (kbd "C-c C-e C-f") 'js2r-extract-function)

;; `web-mode'
(package-require 'web-mode)
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

;; `skewer-mode'
(package-require 'skewer-mode)
(require 'skewer-mode)

(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-js)
;; mod-js.el ends here
