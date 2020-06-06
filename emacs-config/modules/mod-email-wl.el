;; -*- lexical-binding: t -*-
;; mod-email-wl.el --- This is where you apply your OCD.
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
(package-download 'wanderlust)
(package-download 'flim)
(package-download 'semi)
(package-download 'apel)

(internal-require 'wl)
;; (package-download-git "wanderlust" "https://github.com/wanderlust/wanderlust.git")
;;
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'wl-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'wl-user-agent
      'wl-user-agent-compose
      'wl-draft-send
      'wl-draft-kill
      'mail-send-hook))

;; RECV
(setq elmo-imap4-default-server "outlook.office265.com"
       elmo-imap4-default-user "damon-kwok@outlook.com"
       elmo-imap4-default-authenticate-type 'clear
       elmo-imap4-default-port '993
       elmo-imap4-default-stream-type 'ssl)
;; SEND
;;...
;; 2
;;

;; elmo-passwd-alist-save
(setq wl-stay-folder-window t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-email-wl)
;; mod-email-wl.el ends here
