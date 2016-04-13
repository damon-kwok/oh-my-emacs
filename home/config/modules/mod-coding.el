;; -*- lexical-binding: t -*-
;; mod-coding.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2015-2016 damon-kwok
;;
;; Author: damon-kwok <damon-kwok@outlook.com>
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ENCODING ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C-h C RET
;; M-x describe-current-coding-system

;; (add-to-list 'file-coding-system-alist '("\\.tex" . utf-8))
;; (add-to-list 'file-coding-system-alist '("\\.txt" . utf-8))
;; (add-to-list 'file-coding-system-alist '("\\.el" . utf-8))
;; (add-to-list 'file-coding-system-alist '("\\.scratch" . utf-8))
;; (add-to-list 'file-coding-system-alist '("user_prefs" . utf-8))
;;(add-to-list 'process-coding-system-alist '("\\.txt" . utf-8))
;;(add-to-list 'network-coding-system-alist '("\\.txt" . utf-8))

;; (prefer-coding-system 'utf-8)
(prefer-coding-system 'utf-8-dos)
(prefer-coding-system 'utf-8-unix)

(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;; (set-selection-coding-system 'utf-8)  ;;这个变量用于控制emacs和其他窗口相互发送接收文本的编码
;; (setq locale-coding-system 'utf-8) ;;打开后modeline时间日期会乱码
(setq-default buffer-file-coding-system 'utf-8)

;; Treat clipboard input as UTF-8 string first; compound text next, etc.
;; (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;;; mnemonic for utf-8 is "U", which is defined in the mule.el
(setq eol-mnemonic-dos ":CRLF")
(setq eol-mnemonic-mac ":CR")
(setq eol-mnemonic-unix ":LF")
(setq eol-mnemonic-undecided ":?")

(defalias 'read-buffer-file-coding-system 'lawlist-read-buffer-file-coding-system)
(defun lawlist-read-buffer-file-coding-system ()
  (let* ((bcss (find-coding-systems-region (point-min) (point-max)))
         (css-table
          (unless (equal bcss '(undecided))
            (append '("dos" "unix" "mac")
                    (delq nil (mapcar (lambda (cs)
                                        (if (memq (coding-system-base cs) bcss)
                                            (symbol-name cs)))
                                      coding-system-list)))))
         (combined-table
          (if css-table
              (completion-table-in-turn css-table coding-system-alist)
            coding-system-alist))
         (auto-cs
          (unless find-file-literally
            (save-excursion
              (save-restriction
                (widen)
                (goto-char (point-min))
                (funcall set-auto-coding-function
                         (or buffer-file-name "") (buffer-size))))))
         (preferred 'utf-8-unix)
         (default 'utf-8-unix)
         (completion-ignore-case t)
         (completion-pcm--delim-wild-regex ; Let "u8" complete to "utf-8".
          (concat completion-pcm--delim-wild-regex
                  "\\|\\([[:alpha:]]\\)[[:digit:]]"))
         (cs (completing-read
              (format "Coding system for saving file (default %s): " default)
              combined-table
              nil t nil 'coding-system-history
              (if default (symbol-name default)))))
    (unless (zerop (length cs)) (intern cs))))

;; 支持从外部粘贴中文
;; MS Windows clipboard is UTF-16LE 
;; (set-clipboard-coding-system 'utf-16le-dos) ;;(set-clipboard-coding-system 'ctext) ;; ;;set clipboard format: Firefox

;; (prefer-coding-system 'utf-8)
;; ;;(prefer-coding-system 'utf-8-unix)
;; ;;(prefer-coding-system 'utf-8-dos)

;; (set-default-coding-systems 'utf-8)
;; (set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)
;; (set-selection-coding-system 'utf-8) 
;; (setq locale-coding-system 'utf-8)
;; (setq buffer-file-coding-system 'utf-8)

;;; old coding config
;; (setq default-buffer-file-coding-system 'utf-8)
;; (setq current-language-environment "UTF-8")
;; (set-language-environment "UTF-8")
;; (setq default-input-method "chinese-py")
;; (unless (eq system-type 'windows-nt)
;; (set-selection-coding-system 'utf-8))
;; (setq locale-coding-system 'utf-8)
;; (set-default-coding-systems 'utf-8)
;; (set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)
;; (set-w32-system-coding-system 'utf-8)
;; (set-file-name-coding-system 'utf-8)
;; (prefer-coding-system 'utf-8)

;;
(provide 'mod-coding)
