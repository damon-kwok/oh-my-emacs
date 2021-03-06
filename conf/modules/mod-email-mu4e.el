;; -*- lexical-binding: t -*-
;; mod-email.el --- This is where you apply your OCD.
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
(setq mu4e-root-git (concat ome-lib-dir "/mu-git/mu4e"))
(add-to-list 'load-path mu4e-root-git)

;; freebsd
(setq mu4e-root "~/.local/share/emacs/site-lisp/mu4e")
(add-to-list 'load-path mu4e-root)

(internal-require 'mu4e)
(setenv "XAPIAN_CJK_NGRAM" "1")

;; `extensions'
(package-require 'mu4e-maildirs-extension)
(mu4e-maildirs-extension)

;; (package-require 'mu4e-jump-to-list)

;; (package-require 'mu4e-query-fragments)
;; (setq mu4e-query-fragments-list
;; '(("%junk" . "maildir:/Junk OR subject:SPAM")
;; ("%hidden" . "flag:trashed OR %junk")))
;; (setq mu4e-query-fragments-append "AND NOT %hidden")


;; attempt to show images when viewing messages
(setq mu4e-view-show-images t)

;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

;; save attachment to my desktop (this can also be a function)
(setq mu4e-attachment-dir "~/Downloads/mu4e")

;; show html code
(setq mu4e-view-prefer-html t)
(internal-require 'mu4e-contrib)
(setq mu4e-html2text-command 'mu4e-shr2text)

(setq mu4e-drafts-folder "/Draft")
(setq mu4e-sent-folder   "/Sent")
(setq mu4e-trash-folder  "/Trash")
;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)

;; (See the documentation for `mu4e-sent-messages-behavior' if you have
;; additional non-Gmail addresses and want assign them different
;; behavior.)

;; setup some handy shortcuts
;; you can quickly switch to your Inbox -- press ``ji''
;; then, when you want archive some messages, move them to
;; the 'All Mail' folder by pressing ``ma''.

(setq mu4e-maildir-shortcuts '( ("/INBOX" . ?i)
                                ("/INBOX/News" . ?1)
                                ("/INBOX/Notification" . ?2)
                                ("/INBOX/NewMember" . ?3)
                                ("/INBOX/JIRA" . ?4)
                                ("/INBOX/Meeting" . ?m)
                                ("/INBOX/MeetingSummary" . ?M)
                                ("/INBOX/Wage" . ?w)
                                ("/Sent" . ?s)
                                ("/Trash" . ?t)
                                ("/Junk" . ?j)))

(setq mu4e-index-cleanup nil   ;; don't do a full cleanup check
      mu4e-index-lazy-check t) ;; don't consider up-to-date dirs

(setq mu4e-get-mail-command "offlineimap" ;; or fetchmail, or ...
      mu4e-update-interval 300)           ;; update every 1 minutes

;; `set-play-sound'
;; (add-hook 'mu4e-index-updated-hook
;; (defun new-mail-sound ()
;; (shell-command "aplay ~/Music/open.wav&")
;; (mu4e)))

;; `set-signature'
;; something about ourselves
(setq  mu4e-compose-signature-auto-include t)

(setq user-mail-address "yourname@xxx.com" ;
      user-full-name  "yourname"           ;
      mu4e-compose-signature "hello,world!")

(defun load-email-signature (conf-dir)
  (setq mu4e-compose-signature (s-trim (ome-load-file-to-string (concat conf-dir "/signature"))) ;
        user-full-name (s-trim (ome-load-file-to-string (concat conf-dir "/name"))) ;
        user-mail-address (s-trim (ome-load-file-to-string (concat conf-dir "/addr")))))

(load-email-signature "~/workspace/conf/email/default")

;; `send-mail-settting'
;; sending mail -- replace USERNAME with your gmail username
;; also, make sure the gnutls command line utils are installed
;; package 'gnutls-bin' in Debian/Ubuntu

(internal-require 'smtpmail)
;; alternatively, for emacs-24 you can use:
(setq message-send-mail-function 'smtpmail-send-it ;
      smtpmail-stream-type 'ssl                    ;
      smtpmail-default-smtp-server "smtp.263.net"  ;
      smtpmail-smtp-server "smtp.263.net"          ;
      smtpmail-smtp-service 465)

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)

;; (define-key mu4e-headers-mode-map (kbd "SPC") ;;RET
;;   '(lambda ()
;;      (interactive)
;;      (delete-other-windows)
;;      (mu4e-headers-view-message)
;;      (sit-for 0.1)
;;      (switch-window)))

;; `automenu'
(defun automenu--mu4e-main-mode-menu ()
  '("compose" "heads-search" "" "" "" "" "" "" "" "mark-execute"))

(defun automenu--mu4e-main-mode-func (index)
  (cond ((= 0 index)
         (mu4e-compose-new))
        ((= 1 index)
         (mu4e-headers-search))
        ((= 9 index)
         (mu4e-mark-execute-all))
        (t (message  "mu4e-main-mode menu:%d" index))))

;; `automenu'
(defun automenu--mu4e-headers-mode-menu ()
  '("compose" "delete" "" "" "" "" "" "" "" "mark-execute"))

(defun automenu--mu4e-headers-mode-func (index)
  (cond ((= 0 index)
         (mu4e-compose-new))
        ((= 1 index)
         (mu4e-compose-delete))
        ((= 9 index)
         (mu4e-mark-execute-all))
        (t (message  "mu4e-headers-mode menu:%d" index))))

;; `automenu'
(defun automenu--mu4e-view-mode-menu ()
  '("compose" "delete" "reply" "forward" "" "" "" "" "" "mark-execute"))

(defun automenu--mu4e-view-mode-func (index)
  (cond ((= 0 index)
         (mu4e-compose-new))
        ((= 1 index)
         (mu4e-compose-delete))
        ((= 2 index)
         (mu4e-compose-reply))
        ((= 3 index)
         (mu4e-compose-forward))
        ((= 9 index)
         (mu4e-mark-execute-all))
        (t (message  "mu4e-view-mode menu:%d" index))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-email-mu4e)
;; mod-email.el ends here
