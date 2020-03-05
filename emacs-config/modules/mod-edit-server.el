;; -*- lexical-binding: t -*-
;; mod-edit-server.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2018 damon-kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2018-12-27
;; Modify: 2018-12-27
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
(package-require 'edit-server)
;; To open pages for editing in new buffers in your existing Emacs
;; instance:
;;
  (when (require 'edit-server nil t)
    (setq edit-server-new-frame nil)
    (edit-server-start))
;;
;; To open pages for editing in new frames using a running emacs
;; started in --daemon mode:
;;
;;   (when (and (require 'edit-server nil t) (daemonp))
;;     (edit-server-start))
;;
;; Buffers are edited in `text-mode' by default; to use a different
;; major mode, change `edit-server-default-major-mode' or customize
;; `edit-server-url-major-mode-alist' to specify major modes based
;; on the remote URL:
;;
  (setq edit-server-url-major-mode-alist
        '(("github\\.com" . markdown-mode)
          ("gitlab\\.com" . markdown-mode)
          ("code\\.orgmode\\.org" . markdown-mode)
          ("leetcode\\.com/discuss" . markdown-mode)))
;;
;; Alternatively, set the mode in `edit-server-start-hook'.  For
;; example:
;;
;; (add-hook 'edit-server-start-hook
;;           (lambda ()
;;             (when (string-match "github.com" (buffer-name))
;;               (markdown-mode))))

;; uncomment to debug
;; (setq debug-on-error t)
;; (setq edebug-all-defs t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-edit-server)
;; mod-edit-server.el ends here
