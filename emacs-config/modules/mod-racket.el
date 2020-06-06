;; -*- lexical-binding: t -*-
;; mod-racket.el --- This is where you apply your OCD.
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
(package-download 'racket-mode)
(add-to-list 'auto-mode-alist '("\\.rkt$" . racket-mode))

(add-hook 'racket-mode-hook;;
  (lambda ()
    (setq font-lock-maximum-decoration t)
    ;;`xp'
    (require 'racket-xp)
    (racket-xp-mode)
    (setq tab-always-indent 'complete)
    ;;
    (define-key racket-mode-map (kbd "<f5>") 'racket-run)))

(add-hook 'racket-mode-hook #'racket-unicode-input-method-enable)
(add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable)

;; Either (require 'racket-mode) here, or, if you use
;; use-package, put the code below in the :config section.
(with-temp-buffer (racket-unicode-input-method-enable)
  (set-input-method "racket-unicode")
  (let ((quail-current-package (assoc "racket-unicode" quail-package-alist)))
    (quail-define-rules ((append . t))
      ("^o" ["ᵒ"]))))



;;
;; `automenu:racket'
(defun automenu--racket-mode-menu ()
  '("0" "run" "debug" "profile" "4" "5" "6" "test" "8" "logger"))

(defun automenu--racket-mode-func (index)
  (cond ((= 0 index)
          (message  "racket menu:%d" index))
    ((= 1 index)
      (racket-run))
    ((= 2 index)
      (racket-debug-mode))
    ((= 3 index)
      (racket-profile-mode))
    ((= 4 index)
      (message  "racket menu:%d" index))
    ((= 5 index)
      (message  "racket menu:%d" index))
    ((= 6 index)
      (message  "racket menu:%d" index))
    ((= 7 index)
      (racket-fold-all-tests))
    ((= 8 index)
      (message  "racket menu:%d" index))
    ((= 9 index)
      (racket-repl-mode))
    (t (message  "racket menu:%d" index))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-racket)
;; mod-racket.el ends here
