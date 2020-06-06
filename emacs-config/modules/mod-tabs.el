;; -*- lexical-binding: t -*-
;; mod-tabs.el --- This is where you apply your OCD.
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
(package-require 'centaur-tabs)
(setq centaur-tabs-style "box") ;; alternate bar box chamfer rounded slant wave zigzag
(setq centaur-tabs-height 20)
(setq centaur-tabs-set-icons (display-graphic-p))
(setq centaur-tabs-plain-icons nil)
;; (setq centaur-tabs-gray-out-icons 'buffer)
(setq centaur-tabs-set-bar 'under) ;; 'left
(setq x-underline-at-descent-line t)
(setq centaur-tabs-set-close-button (display-graphic-p))
;; (setq centaur-tabs-close-button "x")
(setq centaur-tabs-set-modified-marker t)
(setq centaur-tabs-modified-marker "*")
;; (centaur-tabs-change-fonts "arial" 160)
(if window-system (centaur-tabs-change-fonts "JetBrains Mono Medium" 100))
;;ExtraBold
(add-hook 'dired-mode-hook 'centaur-tabs-local-mode)

(defun centaur-tabs-buffer-groups ()
  "`centaur-tabs-buffer-groups' control buffers' group rules.

    Group centaur-tabs with mode if buffer is derived from `eshell-mode' `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
    All buffer name start with * will group to \"Emacs\".
    Other buffer group by `centaur-tabs-get-group-name' with project name."
  (list (cond ;;
          ((or
             (string-equal "*" (substring (buffer-name) 0 1))
             (memq major-mode '(magit-process-mode magit-status-mode magit-diff-mode magit-log-mode
                                 magit-file-mode magit-blob-mode magit-blame-mode))) "Emacs")
          ((ome-project-name) (ome-project-name))
          ((derived-mode-p 'prog-mode) "Editing")
          ((derived-mode-p 'dired-mode) "Dired")
          ((memq major-mode '(helpful-mode help-mode)) "Help")
          ((memq major-mode '(org-mode org-agenda-clockreport-mode org-src-mode org-agenda-mode
                               org-beamer-mode org-indent-mode org-bullets-mode org-cdlatex-mode
                               org-agenda-log-mode diary-mode)) "OrgMode")
          (t (centaur-tabs-get-group-name (current-buffer))))))

(setq centaur-tabs--buffer-show-groups nil)
;; (centaur-tabs-group-buffer-groups)
(centaur-tabs-group-by-projectile-project)

(defun centaur-tabs-hide-tab (x)
  (let ((name (format "%s" x)))
    (or (string-prefix-p "*epc" name)
      (string-prefix-p "*helm" name)
      (string-prefix-p "*Compile-Log*" name)
      (string-prefix-p "*lsp" name)
      (and (string-prefix-p "magit" name)
        (not (file-name-extension name))))))

(setq centaur-tabs-cycle-scope 'tabs)

(centaur-tabs-enable-buffer-reordering)

;; When the currently selected tab(A) is at the right of the last visited
;; tab(B), move A to the right of B. When the currently selected tab(A) is
;; at the left of the last visited tab(B), move A to the left of B
(setq centaur-tabs-adjust-buffer-order t)

;; Move the currently selected tab to the left of the the last visited tab.
(setq centaur-tabs-adjust-buffer-order 'left)

;; Move the currently selected tab to the right of the the last visited tab.
(setq centaur-tabs-adjust-buffer-order 'right)

;; (global-set-key (kbd "C-<prior>")  'centaur-tabs-backward)
;; (global-set-key (kbd "C-<next>") 'centaur-tabs-forward)

(global-set-key (kbd "C-M-'") 'centaur-tabs-forward)
(global-set-key (kbd "C-M-;") 'centaur-tabs-backward)

(global-set-key (kbd "C-M-[") 'centaur-tabs-forward-group)
(global-set-key (kbd "C-M-/") 'centaur-tabs-backward-group)
(defalias 'ome-tabbar-forward 'centaur-tabs-forward)
(defalias 'ome-tabbar-backward 'centaur-tabs-backward)
(defalias 'ome-tabbar-forward-group 'centaur-tabs-forward-group)
(defalias 'ome-tabbar-backward-group 'centaur-tabs-backward-group)


;; (def-tabbar-color "#b0bec5" "#263238" "gold" "#263238" "#8a8a8a" "#263238" "#263238")
;; (def-tabbar-color "navy" "gray" "goldenrod" "navy" "red" "gray" "gray")
;; DarkGreen LightGoldenrod DarkGoldenrod gold DarkGreen #00B2BF #330000 gray60 grey gray #383838



;; ;; dark
;; (set-face-attribute 'centaur-tabs-default t
;;   :background "#263238"
;;   :foreground "#37474f")

;; (set-face-attribute 'centaur-tabs-unselected nil
;;   :background "#263238"
;;   :foreground "#b0bec5")

;; (set-face-attribute 'centaur-tabs-selected nil
;;   :background "#37474f"
;;   :foreground "#9ccc65") ;;orange #9ccc65

;; (set-face-attribute 'centaur-tabs-unselected-modified nil
;;   :background "#263238"
;;   :foreground "red")

;; (set-face-attribute 'centaur-tabs-selected-modified nil
;;   :background "#37474f"
;;   :foreground "red")
;; (setq centaur-tabs-background-color "#263238")

;; ;;light
;; (set-face-attribute 'centaur-tabs-default t
;;   :background "gray80"
;;   :foreground "gray40")

;; (set-face-attribute 'centaur-tabs-unselected nil
;;   :background "gray80"
;;   :foreground "gray40")

;; (set-face-attribute 'centaur-tabs-selected nil
;;   :background "gray60"
;;   :foreground "#770000") ;;orange #9ccc65

;; (set-face-attribute 'centaur-tabs-unselected-modified nil
;;   :background "gray80"
;;   :foreground "#770000")

;; (set-face-attribute 'centaur-tabs-selected-modified nil
;;   :background "gray60"
;;   :foreground "#770000")
;; (setq centaur-tabs-background-color "gray80")
;;
(centaur-tabs-mode t)
(centaur-tabs-headline-match)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-tabs)
;; mod-tabs.el ends here
