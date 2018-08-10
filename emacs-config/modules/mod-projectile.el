;; -*- lexical-binding: t -*-
;; mod-projectile.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2018 damon-kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2018-08-10
;; Modify: 2018-08-10
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
;;; Install Projectile and activate it for all things.
;;; Learn about Projectile: http://batsov.com/projectile/
(package-require 'projectile)
(require 'projectile)
;;; 默认全局使用
(projectile-mode 1)

;;; 默认打开缓存
(setq projectile-enable-caching t)

;;; 使用f5键打开默认文件搜索
(global-set-key [f5] 'projectile-find-file)
(global-set-key [f12] 'projectile-find-other-file)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-projectile)
;; mod-projectile.el ends here
