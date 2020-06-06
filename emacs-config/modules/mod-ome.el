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
(setq dir-ome-plugins "~/.oh-my-env/plugins/")
(defun ome-open-plugin(arg)
  (interactive "P")
  ;; (interactive "sEnter ome plugin name:")
  ;; (find-file (concat dir-ome-plugins plugin-name))
  (let ((oldir default-directory))
    (ome-helm-init)
    (setq default-directory dir-ome-plugins)
    (helm-find-files arg)
    ;; (setq default-directory oldir)
    ))

(global-set-key (kbd "C-x p f") 'ome-open-plugin)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-ome)
;; mod-ome.el ends here
