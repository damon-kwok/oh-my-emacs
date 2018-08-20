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

;;-(set-language-environment 'Chinese-GB)

;; (prefer-coding-system 'utf-8)
;;-(prefer-coding-system 'utf-8-unix)
;;-(prefer-coding-system 'utf-8-dos)
;; (prefer-coding-system 'iso-latin-1-dos)

;;-(set-default-coding-systems 'utf-8-unix)
;;-(set-terminal-coding-system 'utf-8-unix)
;;-(set-keyboard-coding-system 'utf-8-unix)
;; (set-selection-coding-system 'utf-8)  ;;这个变量用于控制emacs和其他窗口相互发送接收文本的编码
;; (setq locale-coding-system 'utf-8) ;;打开后modeline时间日期会乱码
;;-(setq-default buffer-file-coding-system 'utf-8-unix)

;; Treat clipboard input as UTF-8 string first; compound text next, etc.
;; (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;;; mnemonic for utf-8 is "U", which is defined in the mule.el
(setq eol-mnemonic-mac ":LF") ;;CR
(setq eol-mnemonic-dos ":LF") ;;CRLF
(setq eol-mnemonic-unix ":LF")
(setq eol-mnemonic-undecided ":?")

(defalias 'read-buffer-file-coding-system 'lawlist-read-buffer-file-coding-system)
(defun lawlist-read-buffer-file-coding-system () 
  (let* ((bcss (find-coding-systems-region (point-min) 
                                           (point-max))) 
         (css-table (unless (equal bcss '(undecided)) 
                      (append '("dos" "unix" "mac") 
                              (delq nil (mapcar (lambda (cs) 
                                                  (if (memq (coding-system-base cs) bcss) 
                                                      (symbol-name cs))) coding-system-list))))) 
         (combined-table (if css-table (completion-table-in-turn css-table coding-system-alist)
                           coding-system-alist)) 
         (auto-cs (unless find-file-literally (save-excursion (save-restriction (widen) 
                                                                                (goto-char
                                                                                 (point-min)) 
                                                                                (funcall
                                                                                 set-auto-coding-function
                                                                                 (or
                                                                                  buffer-file-name 
                                                                                  "") 
                                                                                 (buffer-size)))))) 
         (preferred 'utf-8-unix) 
         (default 'utf-8-unix) 
         (completion-ignore-case t) 
         (completion-pcm--delim-wild-regex ; Let "u8" complete to "utf-8".
          (concat completion-pcm--delim-wild-regex "\\|\\([[:alpha:]]\\)[[:digit:]]")) 
         (cs (completing-read (format "Coding system for saving file (default %s): " default)
                              combined-table nil t nil 'coding-system-history (if default
                                                                                  (symbol-name
                                                                                   default))))) 
    (unless (zerop (length cs)) 
      (intern cs))))

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
(set-language-environment 'Chinese-GB)
;; default-buffer-file-coding-system变量在emacs23.2之后已被废弃，使用buffer-file-coding-system代替
(set-default buffer-file-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(setq-default pathname-coding-system 'euc-cn)
(setq file-name-coding-system 'euc-cn)
(set-terminal-coding-system 'euc-cn)
(set-keyboard-coding-system 'euc-cn)
;; (set-selection-coding-system 'euc-cn)  ;;这个变量用于控制emacs和其他窗口相互发送接收文本的编码
;; 另外建议按下面的先后顺序来设置中文编码识别方式。
;; 重要提示:写在最后一行的，实际上最优先使用; 最前面一行，反而放到最后才识别。
;; utf-16le-with-signature 相当于 Windows 下的 Unicode 编码，这里也可写成
;; utf-16 (utf-16 实际上还细分为 utf-16le, utf-16be, utf-16le-with-signature等多种)
(prefer-coding-system 'cp950)
(prefer-coding-system 'gb2312)
(prefer-coding-system 'cp936)
(prefer-coding-system 'gb18030)
                                        ;(prefer-coding-system 'utf-16le-with-signature)
(prefer-coding-system 'utf-16)
;; 新建文件使用utf-8-unix方式
;; 如果不写下面两句，只写
;; (prefer-coding-system 'utf-8)
;; 这一句的话，新建文件以utf-8编码，行末结束符平台相关
(prefer-coding-system 'utf-8-dos)
(prefer-coding-system 'utf-8-unix)

;;
(provide 'mod-coding)
