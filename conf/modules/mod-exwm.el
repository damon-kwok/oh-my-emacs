
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

(package-require 'exwm)
(package-require 'exwm-x)
(package-require 'helm-exwm)
(require 'exwm)
(require 'exwm-x)
(require 'exwm-config)
(require 'exwm-systemtray)

(package-require 'exwm-firefox-core)
(with-eval-after-load 'exwm 
  (require 'exwm-firefox-core))

(define-obsolete-function-alias 'exwm-config-default #'exwm-config-ome "27.1")

(setq exwm-systemtray-height 20)
(exwm-systemtray-enable)

(defun exwm-config-ome () 
  "Default configuration of EXWM."
  ;; Set the initial workspace number.
  (unless (get 'exwm-workspace-number 'saved-value) 
    (setq exwm-workspace-number 4))
  ;; Make class name the buffer name
  (add-hook 'exwm-update-class-hook (lambda () 
                                      (exwm-workspace-rename-buffer
                                       exwm-class-name)))
  ;; Global keybindings.
  (exwm-input-set-key (kbd "M-<tab>") #'exwmx-switch-application)
  ;; 's-p': Launch application
  (exwm-input-set-key (kbd "s-p") 'helm-run-external-command)
  ;; 's-RET': Launch terminal
  (exwm-input-set-key (kbd "s-<return>") #'run-terminal) 
  (unless (get 'exwm-input-global-keys 'saved-value) 
    (setq exwm-input-global-keys ;;
          `(([?\s-x] . run-nemo) 
            ([?\s-z] . run-firefox) 
            ([?\s-t] . run-terminal) 
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

(defun run-nemo () 
  (interactive) 
  (exwmx-quickrun "nemo"))

(defun run-firefox () 
  (interactive) 
  (exwmx-quickrun "firefox"))

;; (defun run-rofi ()
;; (interactive)
;; (exwmx-quickrun "rofi -show run"))

(defun run-terminal () 
  (interactive) 
  (exwmx-quickrun "gnome-terminal"))

(exwm-config-ome)
;;
(provide 'mod-exwm)

;;; mod-exwm.el ends here
