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
(require 'mod-cc)

;; (setenv "LIBCLANG_LIBRARY_DIR" "/home/damon/.llvm/lib")
;; (setenv "LIBCLANG_INCLUDE_DIR" "/home/damon/.llvm/include")
;; `rtags'
(package-require 'rtags)
(require 'rtags)

(if (or (eq system-type 'windows-nt) 
        (eq system-type 'ms-dos)
        (eq system-type 'cygwin)) 
    (setq rtags-rc "rc.exe") 
  (setq rtags-rc "rc"))

(unless (rtags-executable-find rtags-rc) 
  (rtags-install))

;; (add-hook 'after-init-hook '(lambda ()
;; (setq rtags-path (file-name-directory (rtags-executable-find
;; rtags-rc)))
;; (message rtags-path)
;; (setenv "PATH" (concat (file-name-directory rtags-path) ":" (getenv
;; "PATH"))))
;; t)
;;
(package-require 'helm-rtags)
(require 'helm-rtags)
;;
(package-require 'company-rtags)
(require 'company-rtags)

(setq rtags-completions-enabled t)
(eval-after-load 'company '(add-to-list 'company-backends 'company-rtags))
(setq rtags-autostart-diagnostics t)
(rtags-enable-standard-keybindings)
(add-hook 'c-mode-hook 'rtags-start-process-unless-running)
(add-hook 'c++-mode-hook 'rtags-start-process-unless-running)
(add-hook 'objc-mode-hook 'rtags-start-process-unless-running)

;; (setq rtags-use-helm nil)
(setq rtags-display-result-backend 'helm)
(define-key c-mode-base-map (kbd "C-M-.") 'rtags-find-symbol)
(define-key c-mode-base-map (kbd "C-M-,") 'rtags-find-references)
;; (define-key c-mode-base-map (kbd "M-?") 'rtags-find-virtuals-at-point)
(define-key c-mode-base-map (kbd "M-.") 'rtags-find-symbol-at-point)
(define-key c-mode-base-map (kbd "M-?") 'rtags-find-references-at-point)
;; (define-key c-mode-base-map (kbd "M-?") 'rtags-find-file)
(define-key c-mode-base-map (kbd "M-i") 'rtags-imenu)

(defun rtags-open-file () 
  (interactive) 
  (rtags-select-other-window) 
  (delete-other-windows))

(define-key rtags-mode-map (kbd "RET") 'rtags-open-file)
(define-key rtags-mode-map (kbd "M-RET") 'rtags-select)
(define-key rtags-mode-map [mouse-1] 'rtags-open-file)
(define-key rtags-mode-map [mouse-2] 'rtags-open-file)

;; (defun gen-rtags-indexes ()
;; (interactive)
;; (add-hook 'after-init-hook ;;
;; '(lambda ()
;; (shell-command (concat (getenv "HOME") "/.oh-my-emacs/bin/gen-rtags"))) t))

(defun gen-rtags-indexes () 
  (interactive)
  ;; (message (concat "you opened cc file:" (buffer-name)))
  ;; find CmakeLists.txt & gen rtags indexes
  (shell-command (concat (getenv "HOME") "/.oh-my-emacs/bin/gen-rtags " (ome-project-root))))

(defun gen-rtags-indexes-with-elisp () 
  (interactive) 
  (setq dir (ome-buf-dirpath)) 
  (setq cmake-dir (ome-search-file "CMakeLists.txt" dir)) 
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

(defun gen-rtags-indexes-with-elisp () 
  (interactive) 
  (setq dir (ome-buf-dirpath)) 
  (setq cmake-dir (ome-search-file "CMakeLists.txt" dir)) 
  (setq index-dir (concat cmake-dir "rtags_indexes")) 
  (if (eq cmake-dir nil) 
      (message "not found 'CMakeLists.txt' file!") 
    (if (file-exists-p index-dir) 
        (message "rtags_indexes is exists.") 
      (make-directory index-dir)) 
    (progn 
      (setq old-default-directory default-directory) 
      (setq default-directory  index-dir) 
      (message "indexdir:%s" index-dir) 
      (shell-command (concat "bash -c \"source /opt/ros/kinetic/setup.bash && "
                             "cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=1 && " "rc -J " index-dir
                             "\"")) 
      (setq default-directory old-default-directory))))

;; (add-hook 'c-mode-hook 'gen-rtags-indexes)
;; (add-hook 'c++-mode-hook 'gen-rtags-indexes)
;; (add-hook 'objc-mode-hook 'gen-rtags-indexes)

(defun show-rtags-buffer() 
  (interactive) 
  (setq temp-cc-buffer-name (buffer-name (current-buffer))) 
  (ome-show-compilation "*Shell Command Output*") ;;*RTags*
  (shell) 
  (switch-to-buffer-other-window temp-cc-buffer-name) 
  (ome-show-compilation "*Shell Command Output*" t))

(defun show-cc-buffer() 
  (interactive) 
  (switch-to-buffer-other-window temp-cc-buffer-name) 
  (delete-other-windows) 
  (show-rtags-buffer) 
  (switch-to-buffer-other-window temp-cc-buffer-name))

(define-key rtags-mode-map (kbd "C-c C-z") 'show-cc-buffer)
(define-key c-mode-base-map (kbd "C-c C-z") 'show-rtags-buffer)


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
(add-hook 'c-mode-hook #'my-flycheck-rtags-setup) ;;c-mode-common-hook
(add-hook 'c++-mode-hook #'my-flycheck-rtags-setup)
(add-hook 'objc-mode-hook #'my-flycheck-rtags-setup)

;; `flycheck-clang-analyzer'
;; (package-require 'flycheck-clang-analyzer)
;; (with-eval-after-load 'flycheck
;;   (require 'flycheck-clang-analyzer)
;;   (setq flycheck-clang-analyzer-executable "clang-3.9")
;;   (flycheck-clang-analyzer-setup))

;; `flycheck-clang-tidy'
(package-require 'flycheck-clang-tidy)
(eval-after-load 'flycheck '(add-hook 'flycheck-mode-hook #'flycheck-clang-tidy-setup))
;;
(provide 'mod-rtags)
