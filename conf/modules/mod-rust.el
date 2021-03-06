;; -*- lexical-binding: t -*-
;; mod-rust.el --- This is where you apply your OCD.
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
;; (package-download 'racer)
(package-download 'cargo)
(package-download 'rust-mode)
(add-to-list 'auto-mode-alist '("\\.rs$" . rust-mode))
;;
(add-hook 'rust-mode-hook ;;
  (lambda ()
    ;; Configure Emacs to activate racer when rust-mode starts:
    ;; (racer-mode)
    ;; (add-hook 'racer-mode-hook #'eldoc-mode)
    ;; (add-hook 'racer-mode-hook #'company-mode)
    ;;
    (internal-require 'cargo)
    (cargo-minor-mode)
    ;;
    (setq company-tooltip-align-annotations t)
    ;; `keybinding'
    (define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
    (define-key rust-mode-map [f5]
      '(lambda ()
         (interactive)
         (ome-run-command "cargo build")))
    (define-key rust-mode-map [f6] 'ome-open-or-close-cargofile)
    (internal-require 'mod-toml)
    (add-hook 'toml-mode-hook ;;
      (lambda ()
        (interactive)
        (define-key toml-mode-map [f6] 'ome-open-or-close-cargofile)))
    (add-hook 'conf-toml-mode-hook ;;
      (lambda ()
        (interactive)
        (define-key conf-toml-mode-map [f6] 'ome-open-or-close-cargofile)))
    ;;
    (require 'mod-lsp)
    (lsp)
    (lsp-ui-mode)))

(defun ome-open-or-close-cargofile ()
  (interactive)
  (if (eq major-mode 'rust-mode)
    (ome-smart-find-file "Cargo.toml" t)
    (if (or (eq major-mode 'toml-mode)
          (eq major-mode 'conf-toml-mode))
      (kill-this-buffer))))


;; `automenu:rust'
(defun automenu--rust-mode-menu ()
  '("Cargo.toml" "build" "run" "3" "4" "5" "6" "7" "8" "9"))

(defun automenu--rust-mode-func (index)
  (cond ((= 0 index)
          (ome-open-or-close-cargofile))
    ((= 1 index)
      (ome-project-command "cargo build"))
    ((= 2 index)
      (ome-project-command "cargo run"))
    ((= 3 index)
      (message  "rust menu:%d name:%s" index (ome-project-name)))
    ((= 4 index)
      (message  "rust menu:%d" index))
    ((= 5 index)
      (message  "rust menu:%d" index))
    ((= 6 index)
      (message  "rust menu:%d" index))
    ((= 7 index)
      (message  "rust menu:%d" index))
    ((= 8 index)
      (message  "rust menu:%d" index))
    ((= 9 index)
      (message  "rust menu:%d" index))
    (t (message  "rust menu:%d" index))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-rust)
;; mod-rust.el ends here
