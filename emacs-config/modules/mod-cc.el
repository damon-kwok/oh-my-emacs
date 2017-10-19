;; -*- lexical-binding: t -*-
;; mod-cc.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2015-2016 Damon Kwok
;;
;; Author: gww <DamonKwok@msn.com>
;; Date: 2016-01-07
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
;; along with this program.  If not, see <http:;;www.gnu.org/licenses/>.
;;
;; Code:
;; `function-args'
(package-require 'function-args)
(require 'function-args)
(fa-config-default)

;; Additional setup (optional)
;; Put c++-mode as default for *.h files (improves parsing):
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; Enable case-insensitive searching:
(set-default 'semantic-case-fold t)

;; `shader-mode'
(package-require 'shader-mode)
(autoload 'shader-mode "shader" nil t) ;;(require 'shader-mode)
(add-to-list 'auto-mode-alist '("\\.shader$" . shader-mode))

;; `rtags'
(package-require 'rtags)
(require 'rtags)
(package-require 'company-rtags)
(require 'company-rtags)

;; `irony'
(package-require 'irony)
(autoload 'irony "irony" nil t) ;;(require 'irony)

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))

(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; Windows performance tweaks
(when (boundp 'w32-pipe-read-delay)
  (setq w32-pipe-read-delay 0))
;; Set the buffer size to 64K on Windows (from the original 4K)
(when (boundp 'w32-pipe-buffer-size)
  (setq irony-server-w32-pipe-buffer-size (* 64 1024)))

;;(message irony-server-install-prefix)

;;`company-irony'
(package-require 'company-irony)
(require 'company-irony)
(eval-after-load 'company '(add-to-list 'company-backends 'company-irony))

(define-key c-mode-map (kbd "M-/")  'company-complete)
(define-key c++-mode-map (kbd "M-/")  'company-complete)
(define-key objc-mode-map (kbd "M-/")  'company-complete)

;; `flycheck'
(package-require 'flycheck)
(package-require 'flycheck-clang-analyzer)
(with-eval-after-load 'flycheck
  (require 'flycheck-clang-analyzer)
  (flycheck-clang-analyzer-setup))

;; `cmake'
(package-require 'cmake-font-lock)
(autoload 'cmake-font-lock-activate "cmake-font-lock" nil t)
(add-hook 'cmake-mode-hook 'cmake-font-lock-activate)

;;;; create cmake file
(defun create-cmake-file () 
  " create cmake file with current directory!" 
  (interactive) 
  (find-file "CMakeLists.txt"))

;;;; switch 'cmake buffer' and 'code buffer'
(defun create-cmake-file-or-close () 
  (interactive) 
  (if (or (eq major-mode 'c-mode) 
	  (eq major-mode 'c++-mode)) 
      (create-cmake-file) 
    (if (eq major-mode 'cmake-mode) ;;(if (equal buffer-name "CMakeLists.txt")
	(kill-this-buffer))))

(define-key c-mode-base-map [f6] 'create-cmake-file-or-close)

(add-hook 'cc-mode-hook 
	  '(lambda()	    
	     (message (concat "you opened cc file:" (buffer-name)))))
;;
(provide 'mod-cc)
