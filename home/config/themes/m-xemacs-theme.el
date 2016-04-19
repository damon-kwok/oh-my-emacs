;;; m-xemacs.el --- m-xemacs theme

;; Copyright (C) 2005, 2006  Xavier Maillard <zedek@gnu.org>
;; Copyright (C) 2005, 2006  Brian Palmer <bpalmer@gmail.com>
;; Copyright (C) 2013 by Syohei YOSHIDA

;; Author: Syohei YOSHIDA <syohex@gmail.com>
;; URL: https://github.com/emacs-jp/replace-colorthemes
;; Version: 0.01

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Port of m-xemacs theme from `color-themes'

;;; Code:

(if (display-graphic-p)
    (progn
      (setq  m-xemacs-ml-fg "black")
      (setq  m-xemacs-ml-bg "gray80"))
  (progn
     (setq  m-xemacs-ml-fg "black")
     (setq  m-xemacs-ml-bg "gray80")))

(deftheme m-xemacs
  "m-xemacs theme")

(custom-theme-set-faces
 'm-xemacs

 '(default ((t (:foreground "black" :background "gray80"))))
 '(mouse ((t (:foregound "red"))))
 '(cursor ((t (:foregound "yellow"))))
 '(border ((t (:foregound "#330000")))) ;;black

 '(modeline ((t (:foreground "black" :background "gray80"))))
 '(modeline-buffer-id ((t (:foreground "gray80" :background "navy"))))
 '(modeline-mousable ((t (:foreground "black" :background "gray80"))))
 '(modeline-mousable-minor-mode ((t (:foreground "black" :background "gray80"))))

 '(highlight ((t (:background "DarkSeaGreen2"))))
 '(bold ((t (:bold t))))
 '(italic ((t (:italic t))))
 '(bold-italic ((t (:bold t :italic t))))
 '(region ((t (:background "CadetBlue")))) ;;gray80 gray40 gray30
 '(secondary-selection ((t (:background "PaleTurquoise"))))
 '(underline ((t (:underline t))))
 '(show-paren-match-face ((t (:foreground "gold" :background "DarkGreen")))) ;;yellow
 '(show-paren-mismatch-face ((t (:foreground "white" :background "red"))))
 '(font-lock-comment-face ((t (:foreground "DarkGreen":italic t)))) ;; :bold t 
 '(font-lock-string-face ((t (:foreground "DarkGoldenrod" :italic t)))) ;;"DarkSlateBlue "DarkGoldenrod" "gold"
 '(font-lock-keyword-face ((t (:foreground "blue"  :bold t)))) ;;"navy"DarkBlue "blue"
 '(font-lock-builtin-face ((t (:foreground "gray40":italic t)))) ;;white
 '(font-lock-function-name-face ((t (:foreground "blue" :italic t))))
 '(font-lock-variable-name-face ((t (:foreground "navy":italic t)))) ;;DarkBlue
 '(font-lock-type-face ((t (:foreground "navy" :bold t)))) ;; "FireBrick"
 '(font-lock-constant-face ((t (:foreground "#770000" :bold t )))) ;; #00B2BF CadetBlue #00B2FF
 '(font-lock-warning-face ((t (:foreground "orchid" :bold t)))) ;;orchid
 '(font-lock-reference-face ((t (:foreground "SteelBlue")))))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'm-xemacs)

;;; m-xemacs.el ends here
