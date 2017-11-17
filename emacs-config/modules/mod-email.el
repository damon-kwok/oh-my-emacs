;; -*- lexical-binding: t -*-
;; mod-email.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2017 damon-kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2017-11-17
;; Modify: 2017-11-17
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
;;(require 'mu)
;; libgmime-2.6-dev libxapian-dev
;; (setq dir (concat (expand-file-name libs-user-dir) "/" "mu-1.0-alpha2/mu4e"))
(setq dir (concat (expand-file-name libs-user-dir) "/" "mu-0.9.18/mu4e"))
(add-to-list 'load-path dir)
(require 'mu4e)


;; attempt to show images when viewing messages
(setq mu4e-view-show-images t)

;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

;; save attachment to my desktop (this can also be a function)
(setq mu4e-attachment-dir "~/Downloads/mu4e")

;; show html code
(setq mu4e-view-prefer-html t)
(require 'mu4e-contrib)
(setq mu4e-html2text-command 'mu4e-shr2text)


(setq mu4e-drafts-folder "/[Gmail].Drafts")
(setq mu4e-sent-folder   "/[Gmail].Sent Mail")
(setq mu4e-trash-folder  "/[Gmail].Trash")

;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)

;; (See the documentation for `mu4e-sent-messages-behavior' if you have
;; additional non-Gmail addresses and want assign them different
;; behavior.)

;; setup some handy shortcuts
;; you can quickly switch to your Inbox -- press ``ji''
;; then, when you want archive some messages, move them to
;; the 'All Mail' folder by pressing ``ma''.

(setq mu4e-maildir-shortcuts '( ("/INBOX"               . ?i) 
				("/[Gmail].Sent Mail"   . ?s) 
				("/[Gmail].Trash"       . ?t) 
				("/[Gmail].All Mail"    . ?a)))

;; allow for updating mail using 'U' in the main view:
(setq mu4e-get-mail-command "offlineimap")

;; something about ourselves
(setq user-mail-address "guowangwei@51hitech.com" user-full-name  "郭王伟" mu4e-compose-signature
      (concat "郭王伟\n" "https://damon-kwok.github.io\n"))

;; sending mail -- replace USERNAME with your gmail username
;; also, make sure the gnutls command line utils are installed
;; package 'gnutls-bin' in Debian/Ubuntu

(require 'smtpmail)
;; alternatively, for emacs-24 you can use:
(setq message-send-mail-function 'smtpmail-send-it smtpmail-stream-type 'ssl
      smtpmail-default-smtp-server "smtp.263.net" smtpmail-smtp-server "smtp.263.com"
      smtpmail-smtp-service 465)

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)



(defun show-email-repl() 
  (interactive) 
  (setq temp-email-buffer-name (buffer-name (current-buffer))) 
  (m-show-compilation "*mu4e-headers*")
  (ielm) 
  (switch-to-buffer-other-window temp-email-buffer-name) 
  (m-show-compilation "*mu4e-headers*" t))

(defun show-email-workbuffer() 
  (interactive) 
  (switch-to-buffer-other-window temp-email-buffer-name) 
  (delete-other-windows) 
  (show-email-repl) 
  (switch-to-buffer-other-window temp-email-buffer-name))

;; 
(defun compile-current-buffer() 
  (interactive)
  (kill-buffer (get-buffer "*Compile-Log*"))
  (save-buffer) 
  (delete-other-windows) 
  (byte-compile-file (buffer-file-name)) 
  (delete-file (concat (buffer-file-name) "c"))
  ;;(m-show-compilation "*Warnings*")
  (m-show-compilation "*Compile-Log*"))

(require 'ielm)
(define-key ielm-map (kbd "C-c C-z") 'show-email-workbuffer)

(define-key emacs-lisp-mode-map (kbd "C-c C-z")  'show-email-repl)

(global-set-key (kbd "C-c C-`") 'show-email-repl)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-email)
;; mod-email.el ends here
