;; -*- lexical-binding: t -*-
;; mod-cc.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2015-2016 Damon Kwok
;;
;; Author: gww <damon-kwok@outlook.com>
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
;; (require 'function-args)
;; (fa-config-default)

;; Additional setup (optional)
;; Put c++-mode as default for *.h files (improves parsing):
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hxx\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cxx\\'" . c++-mode))

;; Enable case-insensitive searching:
;; (set-default 'semantic-case-fold t)

;; `shader-mode'
(package-require 'shader-mode)
(autoload 'shader-mode "shader" nil t) ;;(require 'shader-mode)
(add-to-list 'auto-mode-alist '("\\.shader$" . shader-mode))


;; `rtags'
(package-require 'rtags)
(require 'rtags)
;; (message rtags-path)
(unless (rtags-executable-find "rc") 
  (rtags-install))
(setenv "PATH" (concat (file-name-directory (rtags-executable-find "rc")) ":" (getenv "PATH")))

(setq rtags-completions-enabled t)
(eval-after-load 'company '(add-to-list 'company-backends 'company-rtags))
(setq rtags-autostart-diagnostics t)
(rtags-enable-standard-keybindings)

(add-hook 'c-mode-hook 'rtags-start-process-unless-running)
(add-hook 'c++-mode-hook 'rtags-start-process-unless-running)
(add-hook 'objc-mode-hook 'rtags-start-process-unless-running)

(package-require 'company-rtags)
(require 'company-rtags)

(package-require 'helm-rtags)
(require 'helm-rtags)
;; (setq rtags-use-helm nil)

(package-require 'company-rtags)
(require 'company-rtags)

(define-key c-mode-base-map (kbd "C-M-.") 'rtags-find-symbol)
(define-key c-mode-base-map (kbd "C-M-,") 'rtags-find-references)
;; (define-key c-mode-base-map (kbd "M-?") 'rtags-find-virtuals-at-point)
(define-key c-mode-base-map (kbd "M-.") 'rtags-find-symbol-at-point)
(define-key c-mode-base-map (kbd "M-,") 'rtags-find-references-at-point)
(define-key c-mode-base-map (kbd "M-?") 'rtags-find-file)
(define-key c-mode-base-map (kbd "M-i") 'rtags-imenu)

(defun rtags-open-file () 
  (interactive) 
  (rtags-select-other-window) 
  (delete-other-windows))
(defun show-rtags-buffer() 
  (interactive) 
  (setq temp-cc-buffer-name (buffer-name (current-buffer))) 
  (m-show-compilation "*RTags*") 
  (shell) 
  (switch-to-buffer-other-window temp-cc-buffer-name) 
  (m-show-compilation "*RTags*" t))
(defun show-cc-buffer() 
  (interactive) 
  (switch-to-buffer-other-window temp-cc-buffer-name) 
  (delete-other-windows) 
  (show-rtags-buffer) 
  (switch-to-buffer-other-window temp-cc-buffer-name))


(define-key rtags-mode-map (kbd "RET") 'rtags-open-file)
(define-key rtags-mode-map (kbd "M-RET") 'rtags-select)
(define-key rtags-mode-map [mouse-1] 'rtags-open-file)
(define-key rtags-mode-map [mouse-2] 'rtags-open-file)

(define-key rtags-mode-map (kbd "C-c C-z") 'show-cc-buffer)
(define-key c-mode-base-map (kbd "C-c C-z") 'show-rtags-buffer)


;; `irony'
(package-require 'irony)
(autoload 'irony "irony" nil t)
;; (require 'irony)
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
(require 'company-irony)
(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
(setq company-backends (delete 'company-semantic company-backends))

;; (package-require 'company-irony-c-headers)
;; (require 'company-irony-c-headers)
;; (eval-after-load 'company
;;   '(add-to-list
;;     'company-backends '(company-irony-c-headers company-irony)))


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

;; `flycheck-rtags'
(package-require 'flycheck-rtags)
(require 'flycheck-rtags)

(defun my-flycheck-rtags-setup () 
  (flycheck-select-checker 'rtags) 
  (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
  (setq-local flycheck-check-syntax-automatically nil))
;; c-mode-common-hook is also called by c++-mode
(add-hook 'c-mode-common-hook #'my-flycheck-rtags-setup)

;; `flycheck-clang-analyzer'
;; (package-require 'flycheck-clang-analyzer)
;; (with-eval-after-load 'flycheck
;;   (require 'flycheck-clang-analyzer)
;;   (setq flycheck-clang-analyzer-executable "clang-3.9")
;;   (flycheck-clang-analyzer-setup))

;; `flycheck-irony'
(package-require 'flycheck-irony)
(eval-after-load 'flycheck '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

;; `flycheck-clang-tidy'
(package-require 'flycheck-clang-tidy)
(eval-after-load 'flycheck '(add-hook 'flycheck-mode-hook #'flycheck-clang-tidy-setup))


;; `cmake-ide'
;; (package-require 'cmake-ide)
;; (cmake-ide-setup)

;; cmake `font-lock'
(package-require 'cmake-font-lock)
(autoload 'cmake-font-lock-activate "cmake-font-lock" nil t)
(add-hook 'cmake-mode-hook 'cmake-font-lock-activate)

;; `create-or-open-cmake-file'
(defun m-search-file (filename &optional path) 
  (message (concat "check:" path)) 
  (if (file-exists-p (concat path filename)) 
      (progn (message path) path) 
    (progn 
      (setq parent (m-parent-dirpath path)) 
      (if (or (eq parent nil) 
	      (string= parent "/")) nil (search-cmakefile-from parent)))))

(defun m-smart-find-file (filename &optional create) 
  " create cmake file with current directory!" 
  (interactive) 
  (setq dir (m-buf-dirpath)) 
  (setq cmake-dir (m-search-file filename dir)) 
  (if (eq cmake-dir nil) 
      (if create (find-file filename)) 
    (find-file (concat cmake-dir filename))))

;; switch 'cmake buffer' and 'code buffer'
(defun m-open-or-close-cmakefile () 
  (interactive) 
  (if (or (eq major-mode 'c-mode) 
	  (eq major-mode 'c++-mode)) 
      (m-smart-find-file "CMakeLists.txt" t) 
    (if (eq major-mode 'cmake-mode) ;;(if (equal buffer-name "CMakeLists.txt")
	(kill-this-buffer))))

;; switch 'package-xml buffer' and 'code buffer'
(defun m-open-or-close-packagexml () 
  (interactive) 
  (if (or (eq major-mode 'c-mode) 
	  (eq major-mode 'c++-mode)) 
      (m-smart-find-file "package.xml") 
    (if (eq major-mode 'nxml-mode) 
	(kill-this-buffer))))

(define-key c-mode-map [f6] 'm-open-or-close-cmakefile)
(define-key c++-mode-map [f6] 'm-open-or-close-cmakefile)
(define-key cmake-mode-map [f6] 'm-open-or-close-cmakefile)

(define-key c-mode-map [f7] 'm-open-or-close-packagexml)
(define-key c++-mode-map [f7] 'm-open-or-close-packagexml)
(define-key nxml-mode-map [f7] 'm-open-or-close-packagexml)


;;; Syntax highlighting support for "`Modern.C++'" - until `C++17' and Technical Specification.
(package-require 'modern-cpp-font-lock)
(require 'modern-cpp-font-lock)
(modern-c++-font-lock-global-mode t)


;; `format'
(package-require 'clang-format)
(require 'clang-format)
;; (define-key c++-mode-map (kbd "C-M-") 'clang-format-region)
(define-key c-mode-map (kbd "C-c C-f")  'clang-format-buffer)
(define-key c++-mode-map (kbd "C-c C-f")  'clang-format-buffer)
(define-key objc-mode-map (kbd "C-c C-f")  'clang-format-buffer)

(define-key c-mode-map (kbd "C-M-\\")  'clang-format-region)
(define-key c++-mode-map (kbd "C-M-\\")  'clang-format-region)
(define-key objc-mode-map (kbd "C-M-\\")  'clang-format-region)

(package-require 'google-c-style)
(require 'google-c-style)

(add-hook 'c-mode-common-hook 'google-set-c-style)


;; (setq rtags-bin-path (file-name-directory (rtags-executable-find "rc")))
(defun gen-rtags-indexes2 () 
  (message (concat "you opened cc file:" (buffer-name)))
  ;; find CmakeLists.txt & gen rtags indexes
  (m-run-command (concat (getenv "HOME")  "/my-emacs-config/bin/gen-rtags")))


(defun gen-rtags-indexes () 
  (setq dir (m-buf-dirpath)) 
  (setq cmake-dir (search-cmakefile-from dir)) 
  (setq index-dir (concat cmake-dir "rtags_indexes")) 
  (if (eq cmake-dir nil) 
      (message "not found 'CMakeLists.txt' file!") 
    (if (file-exists-p index-dir) 
	(message "rtags_indexes is exists.") 
      (progn 
	(setq old-default-directory default-directory) 
	(make-directory index-dir) 
	(setq default-directory  index-dir) 
	(shell-command
	 "bash -c \"source /opt/ros/kinetic/setup.bash && cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=1 && rc -J .\"") 
	(setq default-directory old-default-directory)))))

(add-hook 'c-mode-hook 'gen-rtags-indexes)
(add-hook 'c++-mode-hook 'gen-rtags-indexes)
(add-hook 'objc-mode-hook 'gen-rtags-indexes)
;;
(provide 'mod-cc)
