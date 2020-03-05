;; -*- lexical-binding: t -*-
;; mod-ros.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2015-2017 damon-kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2017-11-06
;; Modify: 2017-11-06
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
                                        ; roslaunch highlighting
(add-to-list 'auto-mode-alist '("\\.launch$" . xml-mode))

;; (package-require 'helm-ros)
;; (getenv "ROS_PACKAGE_PATH")

;; `rosemacs'
;; (add-to-list 'load-path "/opt/ros/kinetic/share/emacs/site-lisp")
;; (internal-require 'rosemacs-config)
;; (interlnal-require 'slime-config "/opt/ros/kinetic/share/slime_ros/slime-config.el")
;; (internal-require 'slime-config "PATH_TO_SLIME_ROS/slime-config.el")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-ros)
;; mod-ros.el ends here
