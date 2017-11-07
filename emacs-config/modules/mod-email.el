;;; -*- lexical-binding: t -*-
;;; mod-email.el --- This is where you apply your OCD.
;;;
;;; Copyright (C) 2015-2017 damon-kwok
;;;
;;; Author: damon <damon-kwok@outlook.com>
;;; Create: 2017-11-07
;;; Modify: 2017-11-07
;;;
;;; This program is free software; you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation, either version 3 of the License, or
;;; (at your option) any later version.
;;;
;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this program.  If not, see <http:;;www.gnu.org/licenses/>.
;;;
;;; Code:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'mod-package)
;;;
(package-require 'wanderlust)
(autoload 'wl "wl" "Wanderlust" t)

;; IMAP, gmail:
;; (setq elmo-imap4-default-server "imap.263.net"
;;       elmo-imap4-default-user "guowangwei@51hitech.net"
;;       elmo-imap4-default-authenticate-type 'clear
;;       elmo-imap4-default-port '993
;;       elmo-imap4-default-stream-type 'ssl

;;       ;; For non ascii-characters in folder-names
;;       elmo-imap4-use-modified-utf7 t)

(setq elmo-pop3-default-server "pop.263.net"
      elmo-pop3-default-user "guowangwei@51hitech.net"
      elmo-pop3-default-authenticate-type 'clear
      elmo-pop3-default-port '995
      elmo-pop3-default-stream-type 'ssl)


;; SMTP
(setq wl-smtp-connection-type 'starttls
      wl-smtp-posting-port 465
      wl-smtp-authenticate-type "plain"
      wl-smtp-posting-user "guowangwei"
      wl-smtp-posting-server "smtp.263.net"
      wl-local-domain "51hitech.com"
      wl-message-id-domain "smtp.263.net")

(setq wl-from "guowangwei <guowangwei@51hitech.com>"

      ;; All system folders (draft, trash, spam, etc) are placed in the
      ;; [Gmail]-folder, except inbox. "%" means it's an IMAP-folder
      wl-default-folder "%inbox"
      wl-draft-folder   "%[51Hitech]/Drafts"
      wl-trash-folder   "%[51Hitech]/Trash"
      ;; The below is not necessary when you send mail through Gmail's SMTP server,
      ;; see https://support.google.com/mail/answer/78892?hl=en&rd=1
      ;; wl-fcc            "%[Gmail]/Sent"

      ;; Mark sent messages as read (sent messages get sent back to you and
      ;; placed in the folder specified by wl-fcc)
      wl-fcc-force-as-read    t

      ;; For auto-completing foldernames
      wl-default-spec "%")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-email)
;;; mod-email.el ends here
