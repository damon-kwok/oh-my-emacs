;; -*- lexical-binding: t -*-
;; mod-rust.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2015-2017 damon-kwok
;;
;; Author: qq563 <damon-kwok@outlook.com>
;; Create: 2017-06-23
;; Modify: 2017-06-23
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'mod-package)
;;
(package-require 'racer)
(require 'racer)
(package-require 'cargo)
(require 'cargo)

;; Configure Emacs to activate racer when rust-mode starts:

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'rust-mode-hook 'cargo-minor-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)

;; For completions, install company with M-x package-install RET company RET. A sample configuration:

(add-hook 'racer-mode-hook #'company-mode)

(require 'rust-mode)
(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)


(defun ome-open-or-close-cargofile () 
  (interactive) 
  (if (eq major-mode 'rust-mode) 
	  (ome-smart-find-file "Cargo.toml" t) 
	(if (eq major-mode 'conf-toml-mode)
		(kill-this-buffer))))

;; `keybinding'
(define-key rust-mode-map [f5] 
  '(lambda () 
	 (interactive) 
	 (ome-run-command "cargo build")))
(define-key rust-mode-map [f6] 'm-open-or-close-cargofile)
;; (define-key conf-toml-mode-map [f6] 'm-open-or-close-cargofile)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-rust)
;; mod-rust.el ends here
