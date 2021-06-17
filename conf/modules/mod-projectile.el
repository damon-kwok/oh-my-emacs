;; -*- lexical-binding: t -*-
;; mod-projectile.el --- This is where you apply your OCD.
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
;;; Install Projectile and activate it for all things.
;;; Learn about Projectile: http://batsov.com/projectile/
(package-require 'projectile)
(package-download 'helm-projectile)
(package-download 'treemacs-projectile)
;; (package-download 'projectile-speedbar)
;;; 默认全局使用
(projectile-mode 1)

(add-hook 'projectile-mode-hook;;
          (lambda ()
            ;; 默认打开缓存
            (setq projectile-enable-caching t)
            ;; 使用f5键打开默认文件搜索
            ;; (global-set-key [f5] 'projectile-find-file)
            ;; (global-set-key [f12] 'projectile-find-other-file)

            ;; `treemacs-projectile'
            (internal-require 'treemacs-projectile)
            ;; (internal-require 'projectile-speedbar)

            ;; Sometimes, when I am deep in a project tree,
            ;; I like to use this shortcut to see full context:
            ;; (global-set-key (kbd "C-c s") 'projectile-speedbar-toggle)
            ;; (global-set-key (kbd "C-M-z") 'projectile-speedbar-open-current-buffer-in-tree)

            ;; You can also disable the feature completely:
            ;; (setq projectile-speedbar-projectile-speedbar-enable nil)

            ;; `helm-projectile'
            ;; A binding for using Helm to pick files using Projectile,
            ;; and override the normal grep with a Projectile based grep.
            (internal-require 'helm-projectile)
            ;; (global-set-key (kbd "C-c C-f") 'helm-projectile-find-file-dwim)
            ;; (global-set-key (kbd "C-x C-g") 'helm-projectile-grep)
            (global-set-key [f5] 'helm-projectile)
            (global-set-key [f12] 'helm-projectile-find-other-file)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-projectile)
;; mod-projectile.el ends here
