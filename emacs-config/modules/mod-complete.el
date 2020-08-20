;; -*- lexical-binding: t -*-
;; mod-complete.el --- This is where you apply your OCD.
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
;;
(require 'mod-package)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(package-require 'popup)
;;(message projectile-project-root)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (package-require 'ido)
;; (ido-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `auto-complete'
;;-(package-require 'auto-complete)
;;-(require 'auto-complete-config)

;;; `pos-tip'
;;-(package-require 'pos-tip)
;;-(setq ac-quick-help-prefer-pos-tip t)

;;; `ac-default'
;;-(ac-config-default)
;;-(global-auto-complete-mode t)
;;(setq-default ac-sources '(ac-source-words-in-same-mode-buffers))
;;(add-hook 'emacs-lisp-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-symbols)))
;;(add-hook 'auto-complete-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-filename)))

;; ac keybind settings

;;-(define-key ac-complete-mode-map (kbd "TAB") 'ac-next)
;;-(define-key ac-complete-mode-map (kbd "S-TAB") 'ac-previous)
;;-(define-key ac-complete-mode-map "\C-n" 'ac-next)
;;-(define-key ac-complete-mode-map "\C-p" 'ac-previous)
;; (define-key ac-complete-mode-map (kbd "SPC") nil)'ac-complete)
;; (define-key ac-menu-map "\C-n" 'ac-next)
;; (define-key ac-menu-map "\C-p" 'ac-previous)
;; (define-key ac-menu-map (kbd "TAB") 'ac-next)
;; (define-key ac-menu-map (kbd "S-TAB") 'ac-previous)
;; ;;(define-key ac-menu-map (kbd "SPC") 'ac-complete)

;; (set-face-background 'ac-candidate-face "LightGray")
;; (set-face-underline 'ac-candidate-face "DarkGray")
;; (set-face-background 'ac-selection-face "SteelBlue")

;;-(set-face-background 'ac-candidate-face "gray80")
;;-(set-face-underline 'ac-candidate-face "#330000")
;;-(set-face-background 'ac-selection-face "DarkBlue")

;;-(setq ac-use-menu-map t)
;;-(setq ac-auto-start 3)
;; (setq ac-dwim t)

;;-(global-set-key "\M-/" 'auto-complete)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `company'
(package-require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(package-require 'company-ctags)
(with-eval-after-load 'company
  (company-ctags-auto-setup))

(global-set-key (kbd "<M-/>") 'company-complete)
(global-set-key (kbd "<C-M-i>") 'company-complete)

(define-key company-active-map (kbd "C-n")  'company-select-next)
(define-key company-active-map (kbd "C-p")  'company-select-previous)

;; (internal-require 'color)
;; (let ((bg (face-attribute 'default :background)))
;;   (custom-set-faces
;;    `(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 10)))))
;;    `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))
;;    `(company-tooltip ((t (:inherit default :background ,(color-lighten-name bg 2)))))
;;    `(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
;;    `(company-tooltip-common ((t (:inherit font-lock-constant-face))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `yasnippet'
(package-require 'yasnippet)
(package-require 'yasnippet-snippets)
;; (yas-global-mode 1)

(setq dir-core-snippets "~/.oh-my-emacs/snippets/")
(setq dir-ome-snippets "~/workspace/emacs/snippets/")

(if (file-exists-p dir-core-snippets)
    (add-to-list 'yas-snippet-dirs dir-core-snippets))

(if (file-exists-p dir-ome-snippets)
    (add-to-list 'yas-snippet-dirs dir-ome-snippets))

(yas-reload-all)

(define-globalized-minor-mode global-yas-minor-mode yas-minor-mode
  (lambda ()
    (if (and (not (string-match "^\*.*\*$" (buffer-name)))
             (not (eq major-mode 'dired-mode))
             (not (eq major-mode 'speedbar-mode)))
        (yas-minor-mode 1))))

(global-yas-minor-mode 1)

;; (add-hook 'c-mode-hook #'yas-minor-mode)
;; (add-hook 'c++-mode-hook #'yas-minor-mode)
;; (add-hook 'objc-mode-hook #'yas-minor-mode)



(defun yas-open-snippet-file(file-name)
  (interactive "sEnter snippet file name:")
  (find-file (concat dir-core-snippets (symbol-name major-mode)"/"file-name)))

(defun yas-open-snippet-template()
  (interactive)
  (find-file (concat dir-core-snippets (symbol-name major-mode) "/auto-insert")))

;; (define-key yas-minor-mode-map (kbd "TAB") nil)
;; (define-key yas-minor-mode-map [backtab] 'yas-expand)
(global-set-key (kbd "C-x y f") 'yas-open-snippet-file)
(global-set-key (kbd "C-x y a") 'yas-open-snippet-template)
;;


;;
(defun yasnippet-current-line () ;; C-c TAB
  (interactive)
  (let ((current-line (string-trim-right (thing-at-point 'line t))))
    (end-of-line)
    (newline-and-indent)
    (yas-expand-snippet (yasnippet-string-to-template (string-trim current-line)))))

(defun yasnippet-string-to-template (string)
  (let ((count 1))
    (cl-labels ((rep (text)
                     (let ((replace (format "${%d:%s}" count text)))
                       (incf count) replace)))
      (replace-regexp-in-string "[a-zA-Z0-9]+" #'rep string))))

(global-set-key (kbd "C-c TAB") 'yasnippet-current-line)
;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `auto-insert-mode'
(setq-default auto-insert-directory dir-core-snippets)
(auto-insert-mode)
(setq auto-insert-query nil) ;;don't ask me "R U want insert?"

(define-auto-insert "\\.sh\\'" "sh-mode/auto-insert")
(define-auto-insert "\\.org\\'" "org-mode/auto-insert")

(define-auto-insert "\\.\\(c\\|cc|\\|cpp\\|cxx\\)\\'" "cc-mode/auto-insert.c")
(define-auto-insert "\\.\\(h\\)\\'" "cc-mode/auto-insert.h")
(define-auto-insert "\\.\\(hh\\|hpp\\|hxx\\)\\'" "c++-mode/auto-insert.hpp")

(define-auto-insert "\\.el\\'" "emacs-lisp-mode/auto-insert")
(define-auto-insert "\\.els\\'" "emacs-lisp-mode/auto-insert.els")

(define-auto-insert "\\.erl\\'" "erlang-mode/auto-insert")
(define-auto-insert "\\.ex\\'" "elixir-mode/auto-insert")

(define-auto-insert "\\.\\(clj\\|cljs\\|cljc\\|clje\\)\\'" "clojure-mode/auto-insert")
(define-auto-insert "\\.cljs\\'" "clojurescript-mode/auto-insert")
(define-auto-insert "\\.clje\\'" "clojerl-mode/auto-insert")
(define-auto-insert "\\.\\(lisp\\|cl\\|ros\\)\\'" "lisp-mode/auto-insert")
(define-auto-insert "\\.\\(scm\\|ss\\)\\'" "scheme-mode/auto-insert")
(define-auto-insert "\\.lsp\\'" "newlisp-mode/auto-insert")

(define-auto-insert "\\.hs\\'" "haskell-mode/auto-insert")
(define-auto-insert "\\.rs\\'" "rust-mode/auto-insert")
(define-auto-insert "\\.go\\'" "go-mode/auto-insert")

(define-auto-insert "\\.py\\'" "python-mode/auto-insert")
(define-auto-insert "\\.js\\'" "js-mode/auto-insert")
(define-auto-insert "\\.cs\\'" "csharp-mode/auto-insert")
;; ROS launch
(define-auto-insert "\\.launch\\'" "nxml-mode/auto-insert.launch")

(define-auto-insert "\\.pony\\'" "ponylang-mode/auto-insert")

(defadvice auto-insert  (around yasnippet-expand-after-auto-insert activate)
  "expand auto-inserted content as yasnippet templete,
  so that we could use yasnippet in autoinsert mode"
  (let ((is-new-file (and (not buffer-read-only)
                          (or (eq this-command 'auto-insert)
                              (and auto-insert
                                   (bobp)
                                   (eobp)))))) ad-do-it (let ((old-point-max (point-max)))
                                         (when is-new-file (goto-char old-point-max)
                                               (yas-expand-snippet
                                                (buffer-substring-no-properties
                                                 (point-min)
                                                 (point-max)))
                                               (delete-region (point-min) old-point-max)
                                               (elisp-code-format)))))


;;
(provide 'mod-complete)
;; mod-complete.el ends here
