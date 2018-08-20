;;; -*- lexical-binding: t -*-
;; mod-markdown.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2015-2016 damon-kwok
;;
;; Author: gww <damon-kwok@outlook.com>
;; Date: 2016-01-21
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
(require 'mod-package)
(package-require 'markdown-mode)
(require 'markdown-mode)

(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.text" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.MD" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.markdown" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.mdown" . markdown-mode) auto-mode-alist))
;;(setq auto-mode-alist (cons '("^*markdown-output*$" . html-mode) auto-mode-alist))

(defun show-markdown-output() 
  (interactive) 
  (setq temp-buffer-name (buffer-name (current-buffer))) 
  (ome-show-compilation "*markdown-output*") 
  (markdown) 
  (switch-to-buffer-other-window temp-buffer-name) 
  (ome-show-compilation "*markdown-output*"))

(defun markdown-custom-settings () 
  "markdown-mode-hook" 
  (setq markdown-command "markdown | smartypants") 
  (define-key markdown-mode-map [f1] 'show-markdown-output) 
  (define-key markdown-mode-map (kbd "C-c C-z") 'show-markdown-output))

(add-hook 'markdown-mode-hook '(lambda() 
                                 (markdown-custom-settings)))
;;
(provide 'mod-markdown)
;; mod-markdown.el ends here
