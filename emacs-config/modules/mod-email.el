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
;; (package-download-git "mu-git" "https://github.com/djcb/mu.git")
;; (setq mu4e-root-git (expand-file-name (concat ome-lib-dir "/mu-git/mu4e")))
;; (add-to-list 'load-path mu4e-root-git)

;; freebsd
(setq mu4e-root-bsd (expand-file-name "~/.local/share/emacs/site-lisp/mu4e"))
(add-to-list 'load-path mu4e-root-bsd)

;; linux
(setq mu4e-root-linux (expand-file-name "/use/share/emacs/site-lisp/mu4e"))
(add-to-list 'load-path mu4e-root-linux)

;; msys2
(setq mu4e-root-msys2 (expand-file-name (concat ome-lib-dir "/../../../../"
                                                "/usr/share/emacs/site-lisp/mu4e")))
(add-to-list 'load-path mu4e-root-msys2)

(internal-require 'mu4e)
(setenv "XAPIAN_CJK_NGRAM" "1")

(defun mu4e~mark-get-move-target () 
  "Ask for a move target, and propose to create it if it does not exist." 
  (interactive)
  ;;  (mu4e-message-at-point) ;; raises error if there is none
  (let* ((target (mu4e-ask-maildir "Move message to: ")) 
         (target (if (string= (substring target 0 1) "/") target (concat "/" target))) 
         (fulltarget (expand-file-name (concat (mu4e-root-maildir) target)))) 
    (when (or (file-directory-p fulltarget) 
              (and (yes-or-no-p (format "1==>%s does not exist.  Create now?" fulltarget)) 
                   (mu4e~proc-mkdir fulltarget))) target)))

(defun mu4e-create-maildir-maybe (dir) 
  "Offer to create maildir DIR if it does not exist yet.
Return t if the dir already existed, or an attempt has been made to
create it -- we cannot be sure creation succeeded here, since this
is done asynchronously. Otherwise, return nil. NOte, DIR has to be
an absolute path."
  (let ((dir (expand-file-name dir))) 
    (if (and (file-exists-p dir) 
             (not (file-directory-p dir))) 
        (mu4e-error "%s exists, but is not a directory." dir)) 
    (cond ((file-directory-p dir) t) 
          ((yes-or-no-p (mu4e-format "2==>%s does not exist yet. Create now?" dir)) 
           (mu4e~proc-mkdir dir) t) 
          (t nil))))

(defun mu4e-ask-maildir-check-exists (prompt) 
  "Like `mu4e-ask-maildir', but check for existence of the maildir,
and offer to create it if it does not exist yet."
  (let* ((mdir (mu4e-ask-maildir prompt)) 
         (fullpath (expand-file-name (concat (mu4e-root-maildir) mdir)))) 
    (unless (file-directory-p fullpath) 
      (and (yes-or-no-p (mu4e-format "%s does not exist. Create now?" fullpath)) 
           (mu4e~proc-mkdir fullpath))) mdir))

(if (string= "MSYS2" (getenv "OME_OS")) 
    (setq mu4e-doc-dir (expand-file-name (concat ome-lib-dir "/../../../../" "/usr/share/doc/mu"))))

;; `extensions'
;; (package-require 'mu4e-maildirs-extension)
;; (mu4e-maildirs-extension)

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

;; (setq mu4e-maildir-shortcuts '( ("/INBOX" . ?i)
;; ("/INBOX/News" . ?1)
;; ("/INBOX/Notification" . ?2)
;; ("/INBOX/NewMember" . ?3)
;; ("/INBOX/JIRA" . ?4)
;; ("/INBOX/Meeting" . ?m)
;; ("/INBOX/MeetingSummary" . ?M)
;; ("/INBOX/Wage" . ?w)
;; ("/Sent" . ?s)
;; ("/Trash" . ?t)
;; ("/Junk" . ?j)))

(setq mu4e-index-cleanup nil   ;; don't do a full cleanup check
      mu4e-index-lazy-check t) ;; don't consider up-to-date dirs

(setq mu4e-get-mail-command "mbsync -a" ;; or fetchmail, or ...
      mu4e-update-interval 300)         ;; update every 1 minutes

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

(load-email-signature "~/workspace/conf/email/outlook")

;; `send-mail-settting'
;; sending mail -- replace USERNAME with your gmail username
;; also, make sure the gnutls command line utils are installed
;; package 'gnutls-bin' in Debian/Ubuntu
(custom-set-variables '(send-mail-function (quote smtpmail-send-it)) 
                      '(smtpmail-smtp-server "smtp.office365.com") 
                      ;; '(smtpmail-stream-type "ssl") 
                      '(smtpmail-smtp-service 25))
;; (internal-require 'smtpmail)
;; ;; alternatively, for emacs-24 you can use:
;; (setq message-send-mail-function 'smtpmail-send-it      ;
;;       send-mail-function 'smtpmail-send-it              ;
;;       smtpmail-stream-type 'ssl                         ;
;;       smtpmail-default-smtp-server "smtp.office365.com" ;
;;       smtpmail-smtp-server "smtp.office365.com"         ;
;;       smtpmail-smtp-service 25)

;; when switch off queue mode, I still prefer async sending
;; (use-package async
;;   :ensure t
;;   :config (require 'smtpmail-async))

;; (setq
;;  send-mail-function 'async-smtpmail-send-it
;;  message-send-mail-function 'async-smtpmail-send-it
;;  ;; replace with your email provider's settings
;;  smtpmail-smtp-server "smtp.office365.com"
;;  smtpmail-smtp-service 587
;;  smtpmail-stream-type 'ssl

;;  ;; if you need offline mode, set these -- and create the queue dir
;;  ;; with 'mu mkdir', i.e:
;;  ;; mu mkdir /home/user/Mail/queue && touch ~/Maildir/queue/.noindex
;;  ;; https://www.djcbsoftware.nl/code/mu/mu4e/Queuing-mail.html
;;  smtpmail-queue-mail nil
;;  smtpmail-queue-dir  (expand-file-name "~/Mail/Outlook/queue/cur"))


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
(provide 'mod-email)
;; mod-email.el ends here
