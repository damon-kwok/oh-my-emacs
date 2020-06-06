;; -*- lexical-binding: t -*-
;; mod-irony.el --- This is where you apply your OCD.
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; `irony'
(package-download 'irony)
(autoload 'irony "irony" nil t)
;; (unless (file-exists-p "/home/damon/.emacs.d/elpa/irony/bin/irony-server") (irony-install-server))
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point] 'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol] 'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; Windows performance tweaks
(when (boundp 'w32-pipe-read-delay)
  (setq w32-pipe-read-delay 0))
;; Set the buffer size to 64K on Windows (from the original 4K)
(when (boundp 'w32-pipe-buffer-size)
  (setq irony-server-w32-pipe-buffer-size (* 64 1024)))

;; `ironyeldoc'
(package-require 'irony-eldoc)
(add-hook 'irony-mode-hook #'irony-eldoc)


;;`company-irony'
(package-require 'company-irony)
(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
(setq company-backends (delete 'company-semantic company-backends))
(setq company-backends (delete 'company-clang company-backends))

(setq company-idle-delay 0)
;; (define-key c-mode-map [(tab)] 'company-complete)
;; (define-key c++-mode-map [(tab)] 'company-complete)
;; (define-key objc-mode-map [(tab)] 'company-complete)
(define-key c-mode-map (kbd "M-/")  'company-complete)
(define-key c++-mode-map (kbd "M-/")  'company-complete)
(define-key objc-mode-map (kbd "M-/")  'company-complete)

;; `flycheck'
(package-require 'flycheck)
(add-hook 'c-mode-hook 'flycheck-mode)
(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'objc-mode-hook 'flycheck-mode)

;; `flycheck-irony'
(package-require 'flycheck-irony)
(eval-after-load 'flycheck '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-irony)
;; mod-irony.el ends here
