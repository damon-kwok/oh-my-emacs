;; -*- lexical-binding: t -*-
;; mod-dired.el --- This is where you apply your OCD.
;;
;; Last-saved : 2016-Jan-06
;; Copyright (C) 2015-2016 damon-kwok
;;
;; Author: gww <damon-kwok@outlook.com>
;; Date: 2016-03-25
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'mod-package)
;;
(package-require 'peep-dired)
(require 'peep-dired)

;; When disabling the mode you can choose to kill the buffers that were opened while browsing the directories.
(setq peep-dired-cleanup-on-disable t)

;; Or you can choose to kill the buffer just after you move to another entry in the dired buffer.
(setq peep-dired-cleanup-eagerly t)

;; If you want the dired buffers that were peeped to have the mode enabled set it to true.
(setq peep-dired-enable-on-directories t)

;; Ignoring certain file extensions
(setq peep-dired-ignored-extensions '("mkv" "iso" "mp4"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-dired)
;; mod-dired.el ends here
