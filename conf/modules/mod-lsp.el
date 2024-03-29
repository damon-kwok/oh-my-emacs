;; -*- lexical-binding: t -*-
;; mod-lsp.el --- This is where you apply your OCD.
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
(package-download 'lsp-mode)
(require 'lsp-mode)
;; (require 'lsp-clients)
(setq lsp-auto-guess-root t)

(package-require 'dap-mode)
(add-hook 'lsp-mode-hook 'dap-mode)
;; (add-hook 'lsp-mode-hook 'dap-ui-mode)

;;
(package-require 'lsp-ui)
;; (add-hook 'lsp-mode-hook 'lsp-ui-mode)

;; don't include type signature in the child frame
(setq lsp-ui-doc-include-signature nil)

;; don't show symbol on the right of info
(setq lsp-ui-sideline-show-symbol nil)


;; Whether or not to enable ‘lsp-ui-sideline’.
(setq lsp-ui-sideline-enable nil)
;;{{{
;; Control to ignore duplicates when there is a same symbol with the same contents.
(setq lsp-ui-sideline-ignore-duplicate nil)

;;When t, show the symbol name on the right of the information.
(setq lsp-ui-sideline-show-symbol t)

;; Whether to show hover messages in sideline.
(setq lsp-ui-sideline-show-hover t)

;; Whether to show flycheck messages in sideline.
(setq lsp-ui-sideline-show-flycheck t)

;; Whether to show code actions in sideline.
(setq lsp-ui-sideline-show-code-actions t)

;; Define the mode for updating sideline information. choice: line point
(setq lsp-ui-sideline-update-mode 'line)
;;}}}


;; Whether or not to enable lsp-ui-doc.
(setq lsp-ui-doc-enable t)
;;{{{
;; Whether or not to enable the header which display the symbol string.
(setq lsp-ui-doc-header nil)

;; Whether or not to include the object signature/type in the frame.
(setq lsp-ui-doc-include-signature nil)

;; Where to display the doc. choice: top bottom at-point
(setq lsp-ui-doc-position 'top)

;; Border color of the frame.
(setq lsp-ui-doc-border "white")

;; Maximum number of columns of the frame.
(setq lsp-ui-doc-max-width 150)

;; Maximum number of lines in the frame.
(setq lsp-ui-doc-max-height 30)

;; Whether to display documentation in a child-frame or the current frame.
;; Child frames requires GNU/Emacs version >= 26 and graphical frames.
(setq lsp-ui-doc-use-childframe t)
;;}}}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `flycheck'
(package-require 'flycheck)
;; (add-hook 'after-init-hook #'global-flycheck-mode)
(setq flycheck-idle-change-delay 2)     ; in seconds

(add-hook 'lsp-mode-hook 'flycheck-mode)

(defun lsp-after-save-hook ()
  (when (eq major-mode 'sh-mode)
    (lsp-format-buffer)))
(add-hook 'after-save-hook #'lsp-after-save-hook nil t)
(define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
(define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)

;; don't include type signature in the child frame
(setq lsp-ui-doc-include-signature nil)

;; don't show symbol on the right of info
(setq lsp-ui-sideline-show-symbol nil)

;; There is a window-local jump list dedicated to cross references:
;; (lsp-ui-peek-jump-backward)
;; (lsp-ui-peek-jump-forward)

;; Other cross references:
;; (lsp-ui-peek-find-workspace-symbol "pattern 0")
;; (lsp-ui-peek-find-custom 'base "$cquery/base")

;;yasnippet
(require 'mod-complete)

;; company
(package-require 'company)


(define-key lsp-ui-mode-map [f10] 'lsp-ui-sideline-toggle-symbols-info)

;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-lsp)
;; mod-lsp.el ends here
