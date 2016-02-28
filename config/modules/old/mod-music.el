c;;; sydio.el --- 
;; 
;; Filename: sydio.el
;; Description: 
;; Author: Sylvester Y. Shi
;; Maintainer: 
;; Created: ?  5? 26 16:50:58 2011 (+0800)
;; Version: 
;; Last-Updated: ?  6? 18 18:58:38 2011 (+0800)
;;           By: Sylvester Y. Shi
;;     Update #: 247
;; URL: 
;; Keywords: 
;; Compatibility: 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Commentary: 
;; 
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Change Log:
;; 26 May 2011:
;;   1. syncronized music play.            
;; 15 Jun 2011:
;;   1. binding functions to corresponding multimedia kes.
;;   2. asyncronizing music play.
;;   3. fix: no song to get when first run.
;; 16 Jun 2011:
;;   1. reconstruct to make it more friendly.(for redraw die)
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; *This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;; 
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Code:
 
(require 'json)
 
(setq my-songs-list nil)
;;(list-processes)
 
 
(defun content-length (header)
  "deprecated!!"
  (if (string-match "Content-Length:" header)
      (let* ((length-point 
          (+ 16 (string-match "Content-Length:" header)))
         (length-point-end 
          (string-match "\r\n" header length-point))
         (len (string-to-int 
           (substring header length-point length-point-end))))
    len)))
 
 
(defun get-json-filter (proc string)
  (setq string-of-songs 
    (concat string-of-songs string))
  (if (string-match "}]}" string)
      (progn 
    ;; resolve from json to lisp
    (copy-to-my-list (json-read-from-string string-of-songs))
    (sydio-play-song)
    ;; clear temp varible.
    (setq string-of-songs))))
 
 
(defun sydio-play-next-song ()
  (interactive)
  (set-process-filter
   (start-process 
    "curl"
    nil
    "curl"
    "-s"
    "http://douban.fm/j/mine/playlist?type=n&channel=2")
   'get-json-filter))
   
 
(defun copy-to-my-list (songs-list)
  (setq my-songs-list)
  (dotimes (i (length (cdr (elt songs-list 0))))
    (let ((var (aref (cdr (elt songs-list 0)) i)))
      (setq my-songs-list 
        (cons var my-songs-list)))))
 
 
(defun get-song-from-list ()
  ;; wait for songs list from network compeleting.
  (if (listp my-songs-list)
      (car my-songs-list)))
 
 
(defun get-next-song ()
  (get-song-from-list))
 
 
(defun kill-sydio-process ()
  " kill all sydio process, ie. process name matchs
  \"sydio-proc<?[0-9]*>?\"
"
  (dolist (elt (process-list))
    (if (string-match "sydio-proc<?[0-9]*>?" (process-name elt))
    (delete-process elt))))
 
 
(defun my-filter (proc string)
  (if (not (eq 'run (process-status proc)))
      (sydio-play-next-song))
  ;;(message (symbol-name (process-status proc)))
  ;;(message string)
  ;;(process-send-string proc (format "loadfile %s\n" ()))
  (if (string-match "ANS_volume=\\(.*\\)\\." string)
      (message "Volume: %s" (match-string 1 string))))
 
 
(defun sydio-play-song ()
  (interactive)
  (kill-sydio-process)
  (let ((proc (get-process "sydio-proc")))
    (if (processp proc)
    (kill-process proc)))
  (let ((proc (start-process
           "sydio-proc"
           "buf"
           "mplayer"
           "-slave"
           ;; "-idle"
           "-quiet"
           ;; "-really-quiet"
           (aget (get-next-song) 'url))))
    (set-process-filter proc 'my-filter)))
;; (format "-slave -quiet -input file=%s %s" "/tmp/mplayer.fifo" (aget (get-next-song) 'url))
 
 
(defun sydio-play-previous-song ()
  (interactive)
  (message "not supported!"))
 
 
(defun sydio-pause-current-song ()
  (interactive)
  (if (not (let ((value nil))
         (dolist (elt (process-list) value)
           (if (string-match "sydio-proc<?[0-9]*>?" (process-name elt))
           (progn (process-send-string elt "pause\n")
              (setq value t))))))
      (sydio-play-next-song)))
 
 
(defun sydio-stop-current-song ()
  (interactive)
  (kill-process "sydio-proc")
  ;; mplayer doesn't stop if using this.
  ;; (process-send-string "sydio-proc" "stop")
  )
 
 
(defun sydio-lower-volume ()
  (interactive)
  ;;(message "sydio: volume lower")
  (process-send-string "sydio-proc" "volume -2\n")
  (process-send-string "sydio-proc" "get_property volume\n"))
 
 
 
(defun sydio-raise-volume ()
  (interactive)
  ;;(message "sydio: volume raise")
  (process-send-string "sydio-proc" "volume 2\n")
  (process-send-string "sydio-proc" "get_property volume\n"))
 
 
(global-set-key (kbd "<XF86AudioPlay>") 'sydio-pause-current-song)
(global-set-key (kbd "<XF86AudioStop>") 'sydio-stop-current-song)
(global-set-key (kbd "<XF86AudioPrev>") 'sydio-play-previous-song)
(global-set-key (kbd "<XF86AudioNext>") 'sydio-play-next-song)
(global-set-key (kbd "<XF86AudioLowerVolume>") 'sydio-lower-volume)
(global-set-key (kbd "<XF86AudioRaiseVolume>") 'sydio-raise-volume)
 
 
(provide 'sydio-pause-current-song)
(provide 'sydio-stop-current-song)
(provide 'sydio-play-previous-song)
(provide 'sydio-play-next-song)
 
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; sydio.el ends here
