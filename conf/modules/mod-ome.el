;; -*- lexical-binding: t -*-
;; mod-ome.el --- This is where you apply your OCD.
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
(setq dir-ome-pkgs "~/.oh-my-env/packages/")
(defun ome-open-pkg(arg)
  (interactive "P")
  ;; (interactive "sEnter ome pkg name:")
  ;; (find-file (concat dir-ome-pkgs pkg-name))
  (let ((oldir default-directory))
    (ome-helm-init)
    (setq default-directory dir-ome-pkgs)
    (helm-find-files arg)
    ;; (setq default-directory oldir)
    ))

(global-set-key (kbd "C-x p f") 'ome-open-pkg)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-ome)
;; mod-ome.el ends here
