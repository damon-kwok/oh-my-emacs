;;; -*- lexical-binding: t -*-
;; mod-csharp.el --- This is where you apply your OCD.
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
;;
(require 'mod-package)
;;
(package-require 'omnisharp)
(require 'omnisharp)
(setq omnisharp-auto-complete-want-importable-types t)

(package-require 'csharp-mode)
(require 'csharp-mode)

(setq omnisharp-eldoc-support nil)

(defun into-omnisharp()
  (interactive)
  ;;(company-mode)
  ;;(auto-complete-mode)
  (omnisharp-mode))

(defun omnisharp-cs-code-format()
  (interactive)
  ;;(omnisharp-fix-usings)
  (omnisharp-code-format)
  (setq old-line (line-number-at-pos))
  (goto-char (point-min))
  ;;(replace-string "" "")
  (if (eq system-type 'windows-nt)
      (replace-string "" ""))
  (goto-char (point-min))
  (forward-line old-line)
  (save-current-buffer))

(defun omnisharp-cs-code-find-usages()
  (interactive)
  (into-omnisharp)
  (omnisharp-helm-find-usages))

(defun omnisharp-cs-code-rename()
  (interactive)
  (into-omnisharp)
  (omnisharp-rename))

(defun csharp-code-format()
  (interactive)
  ;;(into-omnisharp)
  (omnisharp-cs-code-format))

(setq omnisharp-debug nil)

(setq omnisharp-imenu-support t)
;; (if (eq system-type 'windows-nt) (setq omnisharp--curl-executable-path  "~/../bin/curl.exe"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'csharp-mode-hook 'into-omnisharp)

;;(eval-after-load 'company '(add-to-list 'company-backends 'company-omnisharp))
;;(add-hook 'find-file-hook '(lambda()
;;			     (if (string= (symbol-name major-mode) "csharp-mode")
;;				 (message (concat "you opened cs file:" (buffer-name))))

;; (add-hook 'csharp-mode-hook
;;           (lambda ()
;;               (ggtags-mode 1)))

(setq flycheck-idle-change-delay 2)	; in seconds

(define-key csharp-mode-map (kbd "C-M-\\") 'csharp-code-format)
(define-key omnisharp-mode-map (kbd "C-c u") 'omnisharp-fix-usings)
;; (define-key omnisharp-mode-map (kbd ".") 'omnisharp-add-dot-and-auto-complete)
(define-key omnisharp-mode-map (kbd "C-M-i") 'omnisharp-auto-complete)
(define-key csharp-mode-map (kbd "M-.") 'omnisharp-cs-code-find-usages)
(define-key csharp-mode-map (kbd "M-2") 'omnisharp-cs-code-rename)
;;
(provide 'mod-csharp)
;;; mod-csharp.el ends here
