;; -*- lexical-binding: t -*-
;; mod-ui-editor.el --- This is where you apply your OCD.
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
(package-require 'editorconfig)
(editorconfig-mode 1)
;; SPC/TABS
;; (setq default-tab-width 4)
;; (setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
;;
;;; when file modify with other program: auto update buffer
(global-auto-revert-mode 1)
(setq view-read-only t)

;;; replace selected context
(delete-selection-mode t)

;;; set word wrap
(global-visual-line-mode t)

;;; set line space(pixel)
(setq line-spacing 2)

;;; empty line with file
(setq require-final-newline t)

;;; clipboard X clipboard
(setq select-enable-clipboard t)
(setq x-select-enable-clipboard t)

;;; kill process buffer without confirmation?
;; https://emacs.stackexchange.com/questions/14509/kill-process-buffer-without-confirmation
(setq kill-buffer-query-functions (delq 'process-kill-buffer-query-function
                                        kill-buffer-query-functions))
;; (setq kill-buffer-query-functions nil)

;; overflow of stack
(setq kill-ring-max 1024) ;用一个很大的kill ring. 这样防止我不小心删掉重要的东西
(setq max-lisp-eval-depth 900000) ;lisp最大执行深度
(setq max-specpdl-size 900000)    ;最大容量
(setq undo-outer-limit 9000000)   ;撤销限制
(setq message-log-max t)          ;设置message记录全部消息, 而不用截去
(setq eval-expression-print-length nil) ;设置执行表达式的长度没有限制
(setq eval-expression-print-level nil)  ;设置执行表达式的深度没有限制
(setq global-mark-ring-max 1024)        ;设置最大的全局标记容量
(setq history-delete-duplicates t)      ;删除minibuffer的重复历史

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; `backup-settings';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; file time stamp
(setq time-stamp-active t)
(setq time-stamp-warn-inactive t)

;;; i don't make backup file
;;(setq-default make-backup-files nil)
(setq make-backup-files nil)

;;; 2 backup
;;(setq version-control t) ;open version control
;;(setq kept-old-versions 2) ;bcakup raw file number:2
;;(setq kept-new-versions 200) ;backup modify number: 200
;;(setq delete-old-versions t) ;delete old version backup file (file version > 200)
;;(setq backup-directory-alist '(("." . "~/.nextide/.backup"))) ;set backup dir

;;; auto save(t:open nil:close)
(setq auto-save-mode nil)

;;; don't create #filename# temp file
(setq auto-save-default nil)

;;; delete file to:Recycle Bin (emacs24)
(setq delete-by-moving-to-trash t)

;;; set highlight rendering mode: only current screen
(setq lazy-lock-defer-on-scrolling t)
;; (setq font-lock-support-mode 'lazy-lock-mode) ; tip: error
(setq font-lock-maximum-decoration t)

;;; set file save dir
;; (setq bm-repository-file "~/.emacs.d/.bm-repository")
;; (setq bookmark-default-file "~/.emacs.d/.bookmark")
;; (setq desktop-base-file-name "~/.emacs.d/.desktop")
;; (setq desktop-base-lock-name "~/.emacs.d/.desktop.lock")
;; (setq save-place-file "~/.emacs.d/.emacs-places")
;; (setq smex-save-file "~/.emacs.d/.smex-items")
;; (setq mail-personal-alias-file "~/.emacs.d/.mailrc")
;; (setq recentf-save-file "~/.emacs.d/.recentf")
;; (setq diary-file "~/.emacs.d/diary")
;; (setq smex-save-file "~/.emacs.d/.smex-items")
;; (setq ido-save-directory-list-file "~/.emacs.d/.ido.last")
;; (setq slime-repl-history-file "~/.emacs.d/.slime-history.eld")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;`desktop' && `session' && `recentf';;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;; `'default-mode'
;; (setq major-mode 'text-mode) ;;set default major mode {sh-mode | text-mode}

;;; session
;; (package-require 'session)
;; (add-hook 'after-init-hook 'session-initialize)

;;; desktop
;; (setq desktop-restore-frames nil)
;; (desktop-save-mode 1)

;;; recentf file list
(recentf-mode nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-ui-editor)
;; mod-ui-editor.el ends here
