;;; -*- lexical-binding: t -*-
;;; mod-tree.el --- This is where you apply your OCD.
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
(package-require 'treemacs)
(use-package treemacs
  :ensure t
  :defer t
  :config
  (progn
    (use-package treemacs-evil
      :ensure t
      :demand t)
    (setq treemacs-follow-after-init          t
          treemacs-width                      35
          treemacs-indentation                2
          treemacs-git-integration            t
          treemacs-collapse-dirs              3
          treemacs-silent-refresh             nil
          treemacs-change-root-without-asking nil
          treemacs-sorting                    'alphabetic-desc
          treemacs-show-hidden-files          t
          treemacs-never-persist              nil
          treemacs-is-never-other-window      nil
          treemacs-goto-tag-strategy          'refetch-index)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t))
  :bind (:map global-map
        ([f8]         . treemacs-toggle)
        ("C-M-0"        . treemacs-select-window)
        ("C-c 1"      . treemacs-delete-other-windows)
        ("C-M-m ft"     . treemacs-toggle)
        ("C-M-m fT"     . treemacs)
        ("C-M-m fB"     . treemacs-bookmark)
        ("C-M-m f C-t"  . treemacs-find-file)
        ("C-M-m f M-t") . treemacs-find-tag))
(use-package treemacs-projectile
  :defer t
  :ensure t
  :config
  (setq treemacs-header-function #'treemacs-projectile-create-header)
  :bind (:map global-map
              ("C-M-m fP" . treemacs-projectile)
              ("C-M-m fp" . treemacs-projectile-toggle)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-tree)
;;; mod-tree.el ends here
