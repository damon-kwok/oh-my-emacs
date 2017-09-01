;;; -*- lexical-binding: t -*-
;; mod-latex.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2015-2016 Damon Kwok
;;
;; Author: gww <DamonKwok@msn.com>
;; Date: 2016-02-16
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

;;; `load-auctex'
;; (package-require-git "auctex" "https://github.com/jwiegley/auctex.git")
(package-require 'auctex)
(load "auctex.el" nil t t)
;; (load "preview.el" nil t t)
(setq Tex-auto-save t)
(setq Tex-parse-self t)
(setq-default Tex-master nil)

(if (string-equal system-type "windows-nt") 
    (require 'tex-mik))

;; turn on image file support
(auto-image-file-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; set xelatex is default edit command
(setq Tex-output-view-style (quote (("^pdf$" "." "evince &o %(outpage)"))))

(add-hook 'LaTex-mode-hook (lambda() 
			     (add-to-list 'Tex-command-list '("XeLaTex" "%`xelatex%(mode)'%t"
							      Tex-run-Tex nil t)) 
			     (setq Tex-command-default "XeLaTex")))


;;; set org export tex template, can use chinese
;;(require 'org-latex)
;;(unless (boundp 'org-export-latex-classes)
;;  (setq org-export-latex-classes nil))

;; ;;; output latex template
;;(add-to-list 'org-export-latex-classes
;;	     '("article"
;;	       "\\documentclass{article} \\usepackage{ctex}"
;;	       ("\\section{%s}" . "\\section*{%s}")
	       ;;("\\subsection{%s}" . "\\subsection{%s}")
	       ;;("\\subsubsection{%s}" . "\\subsubsection{%s}")
;;	       ("\\paragraph{%s}" . "\\paragraph{%s}")
;;	       ("\\subparagraph{%s}" . "\\subparagraph{%s}")))

(with-eval-after-load 'ox-latex
   (add-to-list 'org-latex-classes
                '("report"
                  "\\documentclass{report}"
                  ("\\chapter{%s}" . "\\chapter*{%s}")
                  ("\\section{%s}" . "\\section*{%s}")
                  ("\\subsection{%s}" . "\\subsection*{%s}")
                  ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `cdlatex'
(package-require 'cdlatex)
(require 'cdlatex)

;;; cdlatex is AUCtex's helper
(add-hook 'LaTex-mode-hook 'turn-on-cdlatex)

;;
(provide 'mod-latex)
;;; mod-latex.el ends here
