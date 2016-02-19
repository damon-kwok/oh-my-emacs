;; -*- lexical-binding: t -*-
;; mod-coding.el --- This is where you apply your OCD.
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ENCODING ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C-h C RET
;; M-x describe-current-coding-system

(add-to-list 'file-coding-system-alist '("\\.tex" . utf-8))
(add-to-list 'file-coding-system-alist '("\\.txt" . utf-8))
(add-to-list 'file-coding-system-alist '("\\.el" . utf-8))
(add-to-list 'file-coding-system-alist '("\\.scratch" . utf-8))
(add-to-list 'file-coding-system-alist '("user_prefs" . utf-8))
(add-to-list 'process-coding-system-alist '("\\.txt" . utf-8))
(add-to-list 'network-coding-system-alist '("\\.txt" . utf-8))

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(setq-default buffer-file-coding-system 'utf-8)

;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;; mnemonic for utf-8 is "U", which is defined in the mule.el
(setq eol-mnemonic-dos ":CRLF")
(setq eol-mnemonic-mac ":CR")
(setq eol-mnemonic-unix ":LF")
(setq eol-mnemonic-undecided ":?")

;;
(provide 'mod-coding)
