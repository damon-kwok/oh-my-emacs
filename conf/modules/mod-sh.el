;; -*- lexical-binding: t -*-
;; mod-sh.el --- This is where you apply your OCD.
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
(add-to-list 'auto-mode-alist '("PKGBUILD" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.sh$" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.rd$" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.[Bb][Aa][Tt]\\'" . bat-mode))

;; setup exec-path-from-shell here
(package-require 'exec-path-from-shell)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(add-hook 'sh-mode-hook (lambda()
                          '(sh-basic-offset 2)
                          '(sh-indentation 2)
                          '(smie-indent-basic 2)
                          ;;
                          (internal-require 'modern-sh)
                          (modern-sh-mode)
                          (define-key modern-sh-mode-map (kbd "<f6>")  'modern-sh-menu)
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
;; `repl'
(defun show-global-shell()
  (interactive)
  (setq temp-global-buffer-name (buffer-name (current-buffer)))
  (ome-show-compilation "*shell*")
  (if (or (eq system-type 'windows-nt) ;;gnu/linux
        (eq system-type 'ms-dos))
    (progn
      (setq explicit-bash-args '("/bin/bash" "-i" "--login"))
      (setq shell-file-name (executable-find "bash")))
    ;;
    ;; start-file-process
    ;; process-connection-type
    ;;
    )
  (shell)
  (switch-to-buffer-other-window temp-global-buffer-name)
  (ome-show-compilation "*shell*" t))

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


(defvar th-shell-popup-buffer nil)

(defun th-shell-popup ()
  "Toggle a shell popup buffer with the current file's directory as cwd."
  (interactive)
  (unless (buffer-live-p th-shell-popup-buffer)
    (save-window-excursion (shell "*Popup Shell*"))
    (setq th-shell-popup-buffer (get-buffer "*Popup Shell*")))
  (let ((win (get-buffer-window th-shell-popup-buffer))
	(dir (file-name-directory (or (buffer-file-name)
				      ;; dired
				      dired-directory
				      ;; use HOME
				      "~/"))))
    (if win
	(quit-window nil win)
      (pop-to-buffer th-shell-popup-buffer nil t)
      (comint-send-string nil (concat "cd " dir "\n")))))

(global-set-key (kbd "<f12>") 'th-shell-popup)


(package-require 'shell-pop)


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
