;;; mod-exwm.el --- This is where you apply your OCD.  -*- lexical-binding: t -*-
;;
;; Copyright (C) 2009-2021 Damon Kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2021-10-26
;; Modify: 2021-10-26
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
;;; Code:
(require 'mod-package)

;;(toggle-frame-fullscreen)

(package-require 'exwm)
(package-require 'exwm-x)
(package-require 'helm-exwm)
(require 'exwm)
(require 'exwm-config)
(require 'exwm-systemtray)


(package-require 'exwm-firefox-core)
(with-eval-after-load 'exwm 
  (require 'exwm-firefox-core))

(define-obsolete-function-alias 'exwm-config-default #'exwm-config-ome "27.1")

(setq exwm-systemtray-height 20)
(exwm-systemtray-enable)

(require 'exwm-x)
(setq exwmx-button-floating-button-line 'mode-line)

(defun ome-exwm-config () 
  "Default configuration of EXWM."
  ;; Set the initial workspace number.
  (unless (get 'exwm-workspace-number 'saved-value) 
    (setq exwm-workspace-number 4))
  ;; Make class name the buffer name
  (add-hook 'exwm-update-class-hook (lambda () 
                                      (exwm-workspace-rename-buffer
                                       exwm-class-name)))
  ;; Global keybindings.
  (exwm-input-set-key (kbd "<f8>") #'exwm-floating-toggle-floating) 
  (exwm-input-set-key (kbd "M-<tab>") #'ome-switch-app) 
  (exwm-input-set-key (kbd "s-<tab>") #'ome-switch-app) 
  (exwm-input-set-key (kbd "C-c C-c") #'exwmx-sendstring)
  ;; 's-p': Launch application
  (exwm-input-set-key (kbd "s-p") 'ome-switch-app)
  ;; 's-RET': Launch terminal
  (exwm-input-set-key (kbd "s-<return>") #'ome-run-terminal)
  (exwm-input-set-key (kbd "S-s-<return>") #'ome-run-lxterminal)
  (unless (get 'exwm-input-global-keys 'saved-value) 
    (setq exwm-input-global-keys ;;
          `(([?\s-x] . ome-run-nemo) 
            ([?\s-z] . ome-run-browser) 
            ([?\s-t] . ome-run-lxterminal) 
            ([?\s-d] . helm-run-external-command)

            ;; 's-r': Reset (to line-mode).
            ([?\s-r] . exwm-reset)

            ;; 's-w': Switch workspace.
            ([?\s-w] . exwm-workspace-switch)

            ;; 's-&': Launch application.
            ([?\s-&] . (lambda (command) 
                         (interactive (list (read-shell-command "$ "))) 
                         (start-process-shell-command command nil command)))

            ;; 's-N': Switch to certain workspace.
            ,@(mapcar (lambda (i)                    ;;
                        `(,(kbd (format "s-%d" i)) . ;;
                          (lambda () 
                            (interactive) 
                            (exwm-workspace-switch-create ,i)))) 
                      (number-sequence 0 9)))))
  ;; Line-editing shortcuts
  (unless (get 'exwm-input-simulation-keys 'saved-value) 
    (setq exwm-input-simulation-keys ;;
          '(([?\C-b] . [left]) 
            ([?\C-f] . [right]) 
            ([?\C-p] . [up]) 
            ([?\C-n] . [down]) 
            ([?\C-a] . [home]) 
            ([?\C-e] . [end]) 
            ([?\M-v] . [prior]) 
            ([?\C-v] . [next]) 
            ([?\C-d] . [delete]) 
            ([?\C-k] . [S-end delete]))))
  ;; Enable EXWM
  (exwm-enable)
  ;; Configure Ido
  (exwm-config-ido)
  ;; Other configurations
  (exwm-config-misc))

(defun ome-run-nemo () 
  (interactive) 
  (if (ome-helm-init) 
      (exwmx-quickrun "nemo")))

(defun ome-run-browser () 
  (interactive) 
  (if (ome-helm-init) ;; (eaf-open-browser "https://cn.bing.com")
      (exwmx-quickrun "firefox")))

(defun ome-run-dmenu (cmd)
  (interactive "P") 
  (if (ome-helm-init) 
      (helm-run-external-command cmd)))

(defun ome-switch-app () 
  (interactive) 
  (if (ome-helm-init) 
      (exwmx-switch-application)))

(defun ome-run-terminal () 
  (interactive) 
  (if (ome-helm-init) ;;(exwmx-quickrun "gnome-terminal")
      (shell)))

(defun ome-run-lxterminal () 
  (interactive) 
  (if (ome-helm-init)
      (exwmx-quickrun "lxterminal")))

(ome-exwm-config)
;;
(provide 'mod-exwm)

;;; mod-exwm.el ends here
