;;; -*- lexical-binding: t -*-
;;; mod-scheme.el --- This is where you apply your OCD.
;;;
;;; Copyright (C) 2015-2016 damon-kwok
;;;
;;; Author: gww <damon-kwok@outlook.com>
;;; Date: 2016-02-28
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

;;; geiser
(package-require 'geiser)
(require 'geiser)

;;; quack
;; (package-require-curl "quack" "http://www.neilvandyke.org/quack/quack.el")
;; (require 'quack)

;;;racket-mode
(package-require 'racket-mode)
(require 'mod-package)

(setq tab-always-indent 'complete)
(add-hook 'racket-mode-hook
          (lambda ()
            (define-key racket-mode-map (kbd "C-c r") 'racket-run)))

(add-hook 'racket-mode-hook      #'racket-unicode-input-method-enable)
(add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-scheme)
;;; mod-scheme.el ends here
