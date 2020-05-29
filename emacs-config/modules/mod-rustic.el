;; -*- lexical-binding: t -*-
;; mod-rustic.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2020 damon-kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2020-05-29
;; Modify: 2020-05-29
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
(package-download 'rustic)
(add-to-list 'auto-mode-alist '("\\.rs$" . rust-mode))
;;
(add-hook 'rust-mode-hook (lambda ()
                            (internal-require 'rustic)
                            ;; (setq rustic-lsp-server 'rust-analyzer)
                            ;; (setq lsp-rust-analyzer-server-command '("~/.cargo/bin/rust-analyzer"))
                            (push 'rustic-clippy flycheck-checkers))

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
