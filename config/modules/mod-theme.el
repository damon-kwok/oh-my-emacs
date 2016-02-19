;;; lexical-binding: t -*-
;; mod-theme.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2015-2016 Damon Kwok
;;
;; Author: gww <DamonKwok@msn.com>
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
(require 'mod-package)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Theme
;;(package-require 'django-theme)
;; (when  (package-installed-p 'django-theme)
;;   (require 'django-theme))


;; (if (display-graphic-p) 
;;     (require 'django-theme)
;;   (load-theme 'deeper-blue))

;; (load-theme 'wombat)
(load-theme 'deeper-blue)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Sexy tail
;; (package-require 'highlight-tail)
;; (require 'highlight-tail)
;; (highlight-tail-mode)

;;; 1. -----
;; (setq highlight-tail-colors '(("black" . 0)
;; 			      ("#bc2525" . 25)
;; 			      ("black" . 66)))

;; (setq highlight-tail-colors '(("#c1e156" . 0) 
;; 			      ("#b8ff07" . 25) 
;; 			      ("#00c377" . 60)))
;;; 2. -----
;; (setq highlight-tail-steps 14 highlight-tail-timer 1)

;;; 3. highlight-tail-posterior-type控制渐变的方式
;; (setq highlight-tail-const-width 5)
;; (setq highlight-tail-posterior-type 'const) 
					;const :渐变highlight-tail-const-width指定固定长度 t:渐变所有修改
;; (message "Highlight-tail loaded - now your Emacs will be even more sexy!")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;emojify
;; (package-require 'emojify)
;; (require 'emojify)

;; Set emojify to only replace Unicode emoji, and do it everywhere.
;; (setq emojify-emoji-styles '(unicode) emojify-inhibit-major-modes '())

;; Patch emojify to replace emoji everywhere in programming modes.
;; (defun emojify-valid-prog-context-p (beg end) 't)

;; Enable it globally.
;; (add-hook 'after-init-hook #'global-emojify-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(package-require 'mode-icons)
(require 'mode-icons)
(mode-icons-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;tdd-status-mode-line
;; (package-require 'tdd-status-mode-line)
;; (require 'tdd-status-mode-line)
;; (make-variable-buffer-local 'tdd-status/current-status-index)
;; (tdd-status-global-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
(provide 'mod-theme)
;;; mod-theme.el ends here
