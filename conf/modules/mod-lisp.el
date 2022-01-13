;; -*- lexical-binding: t -*-
;; mod-lisp.el --- This is where you apply your OCD.
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
(require 'mod-package)

;; (add-to-list 'auto-mode-alist '("\\.cl\\.lisp\\.ros\\'" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.cl\\'" . lisp-mode))
(package-download 'slime)
(package-download 'paredit)
(add-hook 'lisp-mode-hook (lambda ()
                            ;; Enable paredit
                            (internal-require 'paredit)
                            (enable-paredit-mode)
                            (define-key lisp-mode-map (kbd "C-M-\\")  'lisp-code-format)
                            (define-key lisp-mode-map (kbd "C-c C-z") 'show-lisp-repl)

                            ;;Enable slime
                            (slime-setup)
                            ;; (package-require "slime/contrib")

                            ;;-------------------------------------------------
                            ;; Set your lisp system and, optionally, some contribs
                            ;; (load "C:/Users/Administrator/.roswell/helper.el")
                            (setq inferior-lisp-program "ros -Q run")
                            (setq slime-contribs '(slime-fancy))
                            (internal-require 'slime-autoloads)
                            (add-hook 'slime-repl-mode-hook ;;
                                      (lambda ()
                                        ;; Enable paredit
                                        (enable-paredit-mode)
                                        ;; This is useful for working with camel-case tokens, like names of
                                        ;; Java classes (e.g. JavaClassName)
                                        (subword-mode)))
                            (define-key slime-prefix-map (kbd "C-c C-z") 'show-lisp-repl)
                            (define-key slime-repl-mode-map (kbd "C-c C-z") 'show-lisp-workbuffer)
                            (define-key slime-prefix-map (kbd "C-c C-q") 'slime-repl-quit)
                            (define-key slime-repl-mode-map (kbd "C-c C-q") 'slime-repl-quit)
                            (slime-define-keys slime-prefix-map ("\C-z" 'show-lisp-repl))))


(defun slime-fuzzy-init ()
  (message "-------------------slime-fuzzy-init-------------------"))

;;slime-asdf slime-autodoc slime-banner slime-c-p-c slime-cl-indent slime-clipboard
;;slime-compiler-notes-tree slime-editing-commands slime-enclosing-context
;;slime-fancy-inspector slime-fancy slime-fontifying-fu slime-fuzzy slime-highlight-edits
;;slime-hyperdoc slime-indentation slime-mdot-fu slime-media slime-motd slime-mrepl
;;slime-package-fu slime-parse slime-presentation-streams slime-presentations
;;slime-references slime-repl slime-sbcl-exts slime-scheme slime-scratch slime-snapshot
;;slime-sprof slime-tramp slime-typeout-frame slime-xref-browser

(package-download 'slime-company)
(eval-after-load "slime" ;;
  '(progn
     (message "--------------eval-after-load-------------111")
	   ;;(slime-setup '(slime-repl slime-fuzzy))
	   (slime-setup '(slime-company slime-asdf slime-autodoc slime-banner slime-c-p-c slime-cl-indent
                                  slime-clipboard slime-compiler-notes-tree slime-editing-commands
                                  slime-enclosing-context slime-fancy-inspector slime-fancy
                                  slime-fontifying-fu slime-fuzzy slime-highlight-edits
                                  slime-hyperdoc slime-indentation slime-mdot-fu slime-media
                                  ;;slime-motd
                                  slime-mrepl slime-package-fu slime-parse
		                              ;; slime-presentation-streams slime-presentations
                                  slime-references slime-repl slime-sbcl-exts slime-scheme
                                  slime-scratch slime-snapshot slime-sprof slime-tramp ;;slime-typeout-frame ;;muliti-frame
                                  slime-xref-browser))
     (setq slime-truncate-lines t)
     (setq swank:*globally-redirect-io*  t)
     (setq slime-complete-symbol-function ' slime-fuzzy-complete-symbol)
     (setq slime-net-coding-system 'utf-8-unix)
     (message "--------------eval-after-load-------------222")))

;;
(defun show-lisp-repl()
  (interactive)
  (delete-other-windows)
  (setq temp-lisp-buffer-name (buffer-name (current-buffer)))
  (if (slime-connected-p)
      (slime-switch-to-output-buffer)
    (slime))
  (if (< (/ (frame-height) 2)
         (window-height))
      (shrink-window (/ (window-height) 2))))

(defun show-lisp-workbuffer()
  (interactive)
  (switch-to-buffer-other-window temp-lisp-buffer-name)
  (delete-other-windows)
  (show-lisp-repl)
  (switch-to-buffer-other-window temp-lisp-buffer-name))

(package-require 'elisp-format)
(defun lisp-code-format()
  (interactive)
  (elisp-format-buffer)
  (save-current-buffer)
  (message "format complete!"))

;; `automenu:lisp'
(defun automenu--lisp-mode-menu ()
  '("0" "eval-bufffer" "run-current-file" "3" "4" "5" "6" "7" "8" "9"))

(defun automenu--lisp-mode-func (index)
  (cond ((= 0 index)
         (message  "lisp menu:%d" index))
        ((= 1 index)
         (slime-eval-buffer))
        ((= 2 index)
         (ome-run-command (buffer-file-name)))
        ((= 3 index)
         (message  "lisp menu:%d" index))
        ((= 4 index)
         (message  "lisp menu:%d" index))
        ((= 5 index)
         (message  "lisp menu:%d" index))
        ((= 6 index)
         (message  "lisp menu:%d" index))
        ((= 7 index)
         (message  "lisp menu:%d" index))
        ((= 8 index)
         (message  "lisp menu:%d" index))
        ((= 9 index)
         (message  "lisp menu:%d" index))
        (t (message  "lisp menu:%d" index))))
;;
(provide 'mod-lisp)
;; mod-lisp.el ends here
