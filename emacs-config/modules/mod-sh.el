;; -*- lexical-binding: t -*-
;; mod-sh.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2018 damon-kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2018-07-02
;; Modify: 2018-07-02
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
(add-to-list 'auto-mode-alist '("PKGBUILD" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.sh$" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.rd$" . sh-mode))

(add-hook 'sh-mode-hook (lambda()
                          ;; (message (concat "you opened cc file:" (buffer-name)))
                          ;; enabled lsp-mode
                          ;;(if (executable-find "bash-language-server")
                          ;; (internal-require 'mod-lsp)
                          ;; (lsp)
                          ;; (package-require 'lsp-sh)
                          ;; (package-require-curl "lsp-sh" "lsp-sh.el"
                          ;; "https://raw.githubusercontent.com/emacs-lsp/lsp-sh/master/lsp-sh.el"))
                          ;;
                          ;; `keybind'
                          (define-key sh-mode-map (kbd "C-c C-z") 'show-global-shell)
                          (internal-require 'shell)
                          (define-key shell-mode-map (kbd "C-c `")  'show-global-workbuffer)
                          (define-key shell-mode-map (kbd "C-c C-z")  'show-global-workbuffer)))
(global-set-key (kbd "C-c `") 'show-global-shell)
(global-set-key (kbd "C-c C-`") 'show-global-shell-new)
(global-set-key (kbd "C-c C-z") 'show-global-shell)

;; `repl'
(defun show-global-shell()
  (interactive)
  (setq temp-global-buffer-name (buffer-name (current-buffer)))
  (ome-show-compilation "*shell*")
  (if (or (eq system-type 'windows-nt) ;;gnu/linux
        (eq system-type 'ms-dos))
    (progn
      (setq explicit-bash-args '("/bin/bash" "--login"))
      (setq shell-file-name (executable-find "mintty")))
    ;;
    ;; start-file-process
    ;; process-connection-type
    ;;
    )
  (shell)
  (switch-to-buffer-other-window temp-global-buffer-name)
  (ome-show-compilation "*shell*" t)
  )

(defun show-global-shell-new()
  (interactive)
  (ome-kill-buffer-by-name "*shell*")
  (show-global-shell))

(defun show-global-workbuffer()
  (interactive)
  (switch-to-buffer-other-window temp-global-buffer-name)
  (delete-other-windows)
  (show-global-shell)
  (switch-to-buffer-other-window temp-global-buffer-name))


;; `automenu'
;; (setenv "OME_PREFIX" "/home/damon/.ome_local")
(defun automenu--sh-mode-menu ()
  '("publish-to:$OME_PREFIX/bin/" "publish-to:$OME_ROOT/bin/" "2" "3" "4" "5" "6" "7" "8" "9"))

(defun automenu--sh-mode-func (index)
  (cond ((= 0 index)
          (ome-run-command (concat "cp -rf " (buffer-file-name) " " (getenv "OME_PREFIX") "/bin/")))
    ((= 1 index)
      (ome-run-command (concat "cp -rf " (buffer-file-name) " " (getenv "OME_ROOT") "/bin/")))
    ((= 2 index)
      (message  "sh-mode menu:%d" index))
    ((= 3 index)
      (message  "sh-mode menu:%d" index))
    ((= 4 index)
      (message  "sh-mode menu:%d" index))
    ((= 5 index)
      (message  "sh-mode menu:%d" index))
    ((= 6 index)
      (message  "sh-mode menu:%d" index))
    ((= 7 index)
      (message  "sh-mode menu:%d" index))
    ((= 8 index)
      (message  "sh-mode menu:%d" index))
    ((= 9 index)
      (message  "sh-mode menu:%d" index))
    (t (message  "sh-mode menu:%d" index))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-sh)
;; mod-sh.el ends here
