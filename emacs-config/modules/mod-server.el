;; -*- lexical-binding: t -*-
;; mod-server.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2015-2016 Damon Kwok
;;
;; Author: gww <damon-kwok@outlook.com>
;; Date: 2016-01-19
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
;;
(require 'server)

;; (setq server-auth-dir (concat (getenv "HOME") "~/.emacs.d/server/"))
;; (setq server-name "server")

;; (setq server-file-name (concat server-auth-dir server-name))
;; (server-force-delete)			
;; (if(file-exists-p server-file-name) 
   ;; (delete-file server-file-name))
;; (server-start)

(unless (server-running-p)
  (server-start))

;;(or (server-running-p)(server-start))
;;
(provide 'mod-server)
;; mod-server.el ends here
