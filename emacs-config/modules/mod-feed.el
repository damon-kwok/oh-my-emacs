;; -*- lexical-binding: t -*-
;; mod-feed.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2018 damon-kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2018-07-10
;; Modify: 2018-07-10
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
(package-require 'elfeed)
(require 'elfeed)

;; (setq elfeed-feeds '("http://nullprogram.com/feed/" "http://planet.emacsen.org/atom.xml"))

(setq elfeed-feeds '(;;
                     ;; ("http://nullprogram.com/feed/" blog emacs)
                     ;; ("https://www.reddit.com/subreddits.rss" emacs lisp google facebook nvidia)
                     ;; ("https://www.tuicool.com/topics" Lisp)
                     "https://www.reddit.com/r/emacs/.rss"   ;
                     "https://www.reddit.com/r/lisp/.rss"    ;
                     "https://www.reddit.com/r/clojure/.rss" ;
                     "https://www.reddit.com/r/elixir/.rss"  ;
                     "https://www.reddit.com/r/rust/.rss"    ;
                     "https://www.reddit.com/r/nim/.rss"     ;
                     "https://www.reddit.com/r/ocaml/.rss"   ;
                     "https://www.reddit.com/r/golang/.rss"  ;
                     "https://www.reddit.com/r/hylang/.rss"  ;
                     ;; ("https://www.reddit.com/.rss" steam)
                     ("http://www.reddit.com/r/news+wtf.rss" steam)
                     ;; "https://www.reddit.com/search.xml?q=RSS+Readers&sort=new"
                     ;; ("https://www.tuicool.com/articles/" Lisp)
                     ;; "http://www.50ply.com/atom.xml" ; no autotagging
                     ;; ("http://nedroid.com/feed/" webcomic)
                     ;;
                     ))

(global-set-key (kbd "C-x w") 'elfeed)
(setf url-queue-timeout 30)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `elfeed-org'
(defconst elfeed-conf "~/workspace/conf/elfeed.org")

(if (file-exists-p elfeed-conf) 
    (progn ;;
      (package-require 'elfeed-org) 
      (require 'elfeed-org)

      ;; Initialize elfeed-org
      ;; This hooks up elfeed-org to read the configuration when elfeed
      ;; is started with =M-x elfeed=
      (elfeed-org)

      ;; Optionally specify a number of files containing elfeed
      ;; configuration. If not set then the location below is used.
      ;; Note: The customize interface is also supported.
      (setq rmh-elfeed-org-files (list elfeed-conf))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `elfeed-goodies'
(package-require 'elfeed-goodies)
(require 'elfeed-goodies)
(elfeed-goodies/setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-feed)
;; mod-feed.el ends here
