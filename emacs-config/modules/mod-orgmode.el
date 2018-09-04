;;; -*- lexical-binding: t -*-
;; mod-orgmode.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2015-2016 Damon Kwok
;;
;; Author: gww <damon-kwok@outlook.com>
;; Date: 2016-01-19
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
;;
;;org-mode
;; (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(package-require 'org-plus-contrib)
(require 'org-install)

(add-hook 'org-mode-hook (lambda () 
                           (setq truncate-lines nil) 
                           (setq org-startup-with-inline-images t) 
                           (org-display-inline-images t t)))

(setq org-todo-keywords '((sequence "TODO" "DOING" "DONE")))

(setq org-todo-keyword-faces '(("TODO" . "red") 
                               ("DOING" . "yellow") 
                               ("DONE" . "green")))
(setq org-enforce-todo-dependencies t)

(setq org-log-done 'time)
;;(setq org-log-done 'note)

(add-hook 'org-load-hook (lambda () 
                           (org-defkey org-mode-map [(meta p)]    'org-metaup) 
                           (org-defkey org-mode-map [(meta n)]  'org-metadown) 
                           (org-defkey org-mode-map "\M-["    'org-metaup) 
                           (org-defkey org-mode-map "\M-/"  'org-metadown) 
                           (org-defkey org-mode-map "\M-;"    'org-metaleft) 
                           (org-defkey org-mode-map "\M-'"  'org-metaright)))
;; (org-defkey org-mode-map "C-c C-z" 'org-export-dispatch)))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-switchb)
(global-set-key "\C-c#" 'org-update-statistics-cookies)

;; (global-set-key (kbd "C-c C-b") #'(lambda ()
;; (interactive)
;; (org-publish-project "blog")))

;;
;; (org-remember-insinuate)
;; (setq org-directory "~/journal/")
;; (setq org-default-notes-file
;; (concat org-directory (concat (format-time-string "%Y-%m") ".org.cpt"))
;; )

;; (define-key global-map "\C-cr" 'org-remember)

;; (define-key global-map "\C-cc" 'org-capture)

(define-key global-map "\C-cj" (lambda () 
                                 (interactive) 
                                 (org-capture nil "j")))

(defconst journal-file (concat "~/workspace/org/journal-" (format-time-string "%Y-%m") ".org"))

(setq org-capture-templates '(("t" "Todo" entry (file+headline "~/workspace/org/gtd.org" "Tasks")
                               "* TODO %?\n  %i\n  %a") 
                              ("j" "Journal" entry (file+olp+datetree journal-file)
                               "* %?\nEntered on %U\n  %i\n  %a")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; `tex'
(require 'mod-latex)
(package-require 'org2ctex)
(require 'org2ctex)

(org2ctex-toggle t)

;;
;; (setq org2ctex-latex-default-class "ctexart")

;; disable latex auto font settings
;; (setq org2ctex-latex-fonts nil)

;;
;; (setq org-latex-create-formula-image-program 'dvipng)    ;速度很快，但 *默认* 不支持中文
(setq org-latex-create-formula-image-program 'imagemagick) ;速度较慢，但支持中文
(setq org-format-latex-options (plist-put org-format-latex-options 
                                          :scale 2.0)) ;调整 LaTeX 预览图片的大小
(setq org-format-latex-options (plist-put org-format-latex-options 
                                          :html-scale 2.5)) ;调整 HTML 文件中 LaTeX 图像的大小
;; 中文目录下的 org 文件无法转换为 pdf 文件
;; 这个问题可以使用 latexmk 命令配合 "%b.tex" (仅仅使用文件名，而不是文件的绝对路径) 来规避，比如：
(setq org2ctex-latex-commands '("latexmk -xelatex -gg -pdf %b.tex"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; `Babel-Languages'
(package-require 'ob-elixir)
(package-require 'ob-browser)
(package-require 'ob-crystal)
(package-require 'ob-go)
(package-require 'ob-kotlin)
(package-require 'ob-lfe)
(package-require 'ob-crystal)
(package-require 'ob-fsharp)
(package-require 'ob-http)
(package-require 'ob-nim)
(package-require 'ob-prolog)
(package-require 'ob-rust)
(package-require 'ob-swift)
(package-require 'ob-dart)
(package-require 'ob-coffee)
(package-require 'ob-coffeescript)
(package-require 'ob-hy)
(package-require 'ob-typescript)
(package-require 'ob-sml)

;;(package-require 'ob-php)
;; (package-require 'ob-ipython)
(org-babel-do-load-languages 'org-babel-load-languages ;;
                             '((shell . t) 
                               (octave . t) 
                               (ditaa . t) 
                               (dot . t) 
                               (sql . t) 
                               (sqlite . t) 
                               (makefile . t) 
                               (org . t) 
                               (latex . t) 
                               (browser . t) 
                               (java . t) 
                               (go . t) 
                               (crystal . t) 
                               (kotlin . t) 
                               (js . t) 
                               (typescript . t) 
                               (python . t)
                               ;; (ipython . t)
                               (perl . t) 
                               (ruby . t) 
                               (groovy . t) 
                               (matlab . t) 
                               (R . t) 
                               (lisp . t) 
                               (emacs-lisp .t) 
                               (clojure .t) 
                               (hy . t) 
                               (ocaml . t) 
                               (sml . t) 
                               (haskell . t) 
                               (elixir .t) 
                               (lfe . t) 
                               (fsharp . t) 
                               (http . t) 
                               (nim . t)
                               ;;(php . t)
                               (prolog . t) 
                               (rust . t) 
                               (swift . t) 
                               (dart . t) 
                               (coffee . t) 
                               (coffeescript . t)))

;;
(provide 'mod-orgmode)
;;; mod-orgmode.el ends here
