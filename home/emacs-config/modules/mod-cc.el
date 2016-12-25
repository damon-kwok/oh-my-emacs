;; -*- lexical-binding: t -*-
;; mod-cc.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2015-2016 Damon Kwok
;;
;; Author: gww <DamonKwok@msn.com>
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
(package-require 'shader-mode)
;;(require 'shader-mode)
(autoload 'shader-mode "shader" nil t)
(add-to-list 'auto-mode-alist '("\\.shader$" . shader-mode))

(package-require 'irony)
;;(require 'irony)
(autoload 'irony "irony" nil t)

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

;;windows set
(setq w32-pipe-read-delay 0)

;;(message irony-server-install-prefix)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;ac-irony
;;(package-require 'ac-irony)
;;(require 'ac-irony)
(defun my-ac-irony-setup ()
  ;; be cautious, if yas is not enabled before (auto-complete-mode 1), overlays
  ;; *may* persist after an expansion.
  (yas-minor-mode 1) 
  (auto-complete-mode 1) 
  (add-to-list 'ac-sources 'ac-source-irony) 
  (define-key irony-mode-map (kbd "M-RET") 'ac-complete-irony-async))

;;(add-hook 'irony-mode-hook 'my-ac-irony-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;'company-irony
;; (package-require 'company-irony)
;; (require 'company-irony)
;; (eval-after-load 'company '(add-to-list 'company-backends 'company-irony))

;; (define-key c-mode-map (kbd "M-/")  'company-complete)
;; (define-key c++-mode-map (kbd "M-/")  'company-complete)
;; (define-key objc-mode-map (kbd "M-/")  'company-complete)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;'ac-irony
;; (package-require-git "ac-irony" "https://github.com/Sarcasm/ac-irony.git")
;; (require 'ac-irony)
(package-require 'company-irony)
(require 'company-irony)

(defun my-ac-irony-setup ()
  ;; be cautious, if yas is not enabled before (auto-complete-mode 1), overlays
  ;; *may* persist after an expansion.
  (yas-minor-mode 1)
  (auto-complete-mode 1)

  (add-to-list 'ac-sources 'ac-source-irony)
  (define-key irony-mode-map (kbd "M-RET") 'ac-complete-irony-async))

(add-hook 'irony-mode-hook 'my-ac-irony-setup)

(add-hook 'cc-mode-hook 
	  '(lambda()
	    
	     (message (concat "you opened cc file:" (buffer-name)))))






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; create cmake file
(defun create-cmake-file () 
  " create cmake file with current directory!" 
  (interactive) 
  (find-file "CMakeLists.txt"))

;;;; switch 'cmake buffer' and 'code buffer'
(defun create-cmake-file-or-close () 
  (interactive) 
  (if (or (eq major-mode 'c-mode) 
	  (eq major-mode 'c++-mode)) 
      (create-cmake-file) 
    (if (eq major-mode 'cmake-mode) ;;(if (equal buffer-name "CMakeLists.txt")
	(kill-this-buffer))))


(define-key c-mode-base-map [f6] 'create-cmake-file-or-close)

;;
(provide 'mod-cc)
