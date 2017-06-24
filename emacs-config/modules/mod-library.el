;; -*- lexical-binding: t -*-
;; mod-library.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2015-2015 Damon Kwok
;;
;; Author: gww <DamonKwok@msn.com>
;; Date: 2015-12-31
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
(require 'cl)
(package-require 's)

(require 's)
(package-require 'f)
(require 'f)

(defun m-project-root() 
  (let ((aaa (substring (buffer-only-name) 0 1))) 
    (if (string= aaa "*") "./" (if (projectile-project-p) 
				   (projectile-project-root) 
				 (buffer-path-name)))))

;; (projectile-project-p)
;; (projectile-project-root)
;; (projectile-get-project-directories)
;; (m-run-command (concat "grep -n --include=\"*.el\" \"buffer-\" -R ./"));; (projectile-project-root)))

;;(m-run-command (concat "grep -n --include=\"*.el\" \"buffer-\" -R ./" (projectile-project-root)))
;;(m-run-command (concat "grep -n \"buffer-\" -r ./" (projectile-project-root)))

;;(require 'dash)
;;(require 'json)
;;(require 'files)
;;(require 'ido)
;;(require 'thingatpt)
;;(require 'dash)
;;(require 'compile)
;;(require 'dired)
;;(require 'popup)
;;(require 'etags)
;;(require 'flycheck)

;;(defun fib (n)
;;  (cond ((= n 0) 0)
;;	((= n 1) 1)
;;	(t (+ (fib (- n 1))
;;	      (fib (- n 2))))))

;; (fib 100)

;;(setq default-directory "c:")
;;(concat default-directory "TAGS")

;; (defun remove-dos-eol ()
;;   "Do not show ^M in files containing mixed UNIX and DOS line endings."
;;   (interactive)
;;   (setq buffer-display-table (make-display-table))
;;   (aset buffer-display-table ?\^M []))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `keymap-unset-key'

(defun m-keymap-unset-key (key keymap) 
  "Remove binding of KEY in a keymap
    KEY is a string or vector representing a sequence of keystrokes.

    Example:
    (m-keymap-unset-key (kbd \"C-c <C-left>\") \"tabbar-mode\")
    (m-keymap-unset-key [C-c <C-left>] \"tabbar-mode\")" 
  (interactive (list (call-interactively #'get-key-combo) 
		     (completing-read "Which map: " minor-mode-map-alist nil t))) 
  (let ((map (rest (assoc (intern keymap) minor-mode-map-alist)))) 
    (when map (define-key map key nil) 
	  (message  "%s unbound for %s" key keymap))))


;; http://www.ergoemacs.org/emacs/elisp_idioms_prompting_input.html
(defun m-query-user (x y) 
  (interactive "sEnter friend's name: \nnEnter friend's age: ") 
  (message "Name is: %s, Age is: %d" x y))

(defun m-is-in-terminal() 
  (not (display-graphic-p)))

(defmacro when-terminal 
    (&rest 
     body)
  "Works just like `progn' but will only evaluate expressions in VAR when Emacs is running in a terminal else just nil."
  `(when (m-is-in-terminal) ,@body))

;; (file-name-as-directory buffer-file-name)
;; (file-name-nondirectory buffer-file-name)
;; (file-name-directory buffer-file-name)

(defun buffer-path-name() 
  (directory-file-name (file-name-directory buffer-file-name)))

(defun buffer-dir-name() 
  (nth 0 (last (split-string (buffer-path-name) "/") 1)))

(defun buffer-only-name() 
  (first (split-string (buffer-name) "\\."))) ;;file-name-base

(defun buffer-ext-name() 
  (let ((ext-name (nth 0 (last (split-string (buffer-name) "\\.")))) 
	(buf-name (buffer-name))) 
    (if (string= ext-name buf-name) "" ext-name)))

;;(file-name-sans-extension "222/111.el") ;;==>222/111
;;(file-name-base "222/111.el") ;;==> 111
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (browse-url
;;  (concat "http://www.bing.com/dict/search?q="
;; 	 (url-hexify-string
;; 	  (read-string "Query: "))))

(defun m-bing-dict-brief-eww (arg) 
  "compile project"
  ;;(interactive)
  (m-show-compilation "*Messages*") 
  (other-window 1) 
  (eww (concat "http://www.bing.com/dict/search?q=" arg)))

(defun m-bing-dict-brief-web (word) 
  "Show the explanation of WORD from Bing in the echo area." 
  (interactive (let* ((default (if (use-region-p) 
				   (buffer-substring-no-properties 
				    (region-beginning) 
				    (region-end)) 
				 (let ((text (thing-at-point 'word))) 
				   (if text (substring-no-properties text))))) 
		      (prompt (if (stringp default) 
				  (format "Search Bing web dict (default \"%s\"): " default)
				"Search Bing web dict: ")) 
		      (string (read-string prompt nil 'bing-dict-history default))) 
		 (list string))) 
  (save-match-data (m-bing-dict-brief-eww word)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;comment or uncomment
(defun m-comment-or-uncomment-region-or-line () 
  "Comments or uncomments the region or the current line if there's no active region." 
  (interactive) 
  (let (beg end) 
    (if (region-active-p) 
	(setq beg (region-beginning) end (region-end)) 
      (setq beg (line-beginning-position) end (line-end-position))) 
    (comment-or-uncomment-region beg end) 
    (next-line)))

(defun m-go-to-char-forward (n char) 
  "Move forward to Nth occurence of CHAR.
Typing `wy-go-to-char-key' again will move forwad to the next Nth
occurence of CHAR." 
  (interactive "p\ncGo to char: ") 
  (search-forward (string char) nil nil n) 
  (while (char-equal (read-char) char) 
    (search-forward (string char) nil nil n)) 
  (setq unread-command-events (list last-input-event)))

(defun m-go-to-char-backward (n char) 
  "Move forward to Nth occurence of CHAR.
Typing `wy-go-to-char-key' again will move forwad to the next Nth
occurence of CHAR." 
  (interactive "p\ncGo to char: ") 
  (search-backward (string char) nil nil n) 
  (while (char-equal (read-char) char) 
    (search-backward (string char) nil nil n)) 
  (setq unread-command-events (list last-input-event)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; close all buffer
(defun m-kill-all-buffers () 
  "Kill all other buffers." 
  (interactive) 
  (mapcar 'kill-buffer (buffer-list)))

;; close all buffer but this
(defun m-kill-other-buffers () 
  "Kill all other buffers." 
  (interactive) 
  (delete-other-windows) 
  (mapc 'kill-buffer (delq (current-buffer) 
			   (remove-if-not 'buffer-file-name (buffer-list)))))

;; delete current buffer && file
(defun m-delete-file-and-buffer() 
  (interactive) 
  (cond ((y-or-n-p (concat "delete'" (buffer-name) "'?")) 
	 ((progn) 
	  (delete-file (buffer-file-name) 
		       (kill-this-buffer))))))

;; Originally from stevey, adapted to support moving to a new directory.
(defun m-rename-file-and-buffer (new-name) 
  "Renames both current buffer and file it's visiting to NEW-NAME." 
  (interactive (progn (if (not (buffer-file-name)) 
			  (error 
			   "Buffer '%s' is not visiting a file!"
			   (buffer-name))) 
		      (list (read-file-name (format "Rename %s to: " (file-name-nondirectory
								      (buffer-file-name))))))) 
  (if (equal new-name "") 
      (error 
       "Aborted rename")) 
  (setq old-name-base (file-name-base (buffer-name))) 
  (setq new-name (if (file-directory-p new-name) 
		     (expand-file-name (file-name-nondirectory (buffer-file-name)) new-name) 
		   (expand-file-name new-name)))
  ;; If the file isn't saved yet, skip the file rename, but still update the
  ;; buffer name and visited file.
  (if (file-exists-p (buffer-file-name)) 
      (rename-file (buffer-file-name) new-name 1)) 
  (let ((was-modified (buffer-modified-p)))
    ;; This also renames the buffer, and works with uniquify
    (set-visited-file-name new-name) 
    (if was-modified (save-buffer)
      ;; Clear buffer-modified flag caused by set-visited-file-name
      (set-buffer-modified-p nil))
    ;;(message "Renamed to %s." new-name)))
    (setq new-name-base (file-name-base (buffer-name))) 
    (setq old-line (line-number-at-pos)) 
    (goto-char (point-min))

    ;;cc-mode(c c++)
    (replace-string (concat "_" (upcase old-name-base) "_") 
		    (concat "_" (upcase new-name-base) "_"))

    ;;other files
    (beginning-of-buffer) 
    (replace-string (concat old-name-base) 
		    (concat new-name-base)) 
    (goto-line old-line)

    ;;save
    (save-buffer) 
    (message "Renamed to %s" new-name)))

(defun m-rename-file-and-buffer-ext (ext-name) 
  "rename extname with file and buffer"
  (m-rename-file-and-buffer (concat (buffer-only-name) "." ext-name)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; define function to shutdown emacs server instance
(defun m-server-shutdown () 
  "Save buffers, Quit, and Shutdown (kill) server" 
  (interactive) 
  (save-some-buffers) 
  (kill-emacs))


;;(global-set-key [(control x) (control c)]
;;                (function
;;                 (lambda () (interactive)
;;                   (cond ((y-or-n-p "Exit? ") ;;(y-or-n-p "Relax...? ")
;;                          (if server-clients (server-edit) ;;if has clients , kill client frame.
;;                            (bye)))))))


;; exit
;; prevent kill emacs by mistake
(defun m-play-exit-animate () 
  "say bye-bye !" 
  (interactive)
  ;;(if (sr-speedbar-exist-p)
  ;;    (sr-speedbar-close))
  ;; Make a suitable buffer to display the birthday present in.
  (switch-to-buffer (get-buffer-create "*bye*")) 
  (erase-buffer)
  ;; Display the empty buffer.
  (sit-for 0)
  ;;(animate-string "I'll miss you~" 7)
  ;;(sit-for 1) ;;wait 1 second
  (animate-string " Bye!!!" 9) 
  (sit-for 1) ;;wait 1 second
)

;;`remove' the prompt for killing emacsclient buffers
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

(defun m-exit-animate() 
  (interactive) 
  (cond ((y-or-n-p "Exit? ") 
	 (medusa-bye)
	 (save-buffers-kill-emacs))))

(defun m-exit() 
  (interactive) 
  (cond ((y-or-n-p "Exit? ") ;;(y-or-n-p "Relax...? ")
	 (save-buffers-kill-emacs))))

(defun m-open-file(file-name) 
  (interactive) 
  (delete-other-windows) 
  (m-show-compilation "*Messages*") 
  (other-window 1) ;;(switch-window)
  (find-file file-name) 
  (delete-other-windows))

(defun m-open-mod(mod-name) 
  (interactive) 
  (delete-other-windows) 
  (m-show-compilation "*Messages*") 
  (other-window 1) ;;(switch-window)
  (find-file (concat "~/emacs-config/modules/mod-" mod-name ".el")) 
  (delete-other-windows))

(defun m-open-doc(doc-name) 
  (interactive) 
  (delete-other-windows) 
  (m-show-compilation "*Messages*") 
  (other-window 1) ;;(switch-window)
  (find-file (concat (getenv "ROOT") "/docs/" doc-name)) 
  (delete-other-windows))

(defun m-open-url(url) 
  (interactive) 
  ( m-show-compilation "*eww*") 
  (other-window 1) 
  (eww url))

(defun m-show-compilation(buffer-name &optional dont-return-old-buffer) 
  "shrink compile window, avoid compile window occupy 1/2 hight of whole window" 
  (interactive) 
  (delete-other-windows) 
  (setq temp-buffer-name (buffer-name (current-buffer))) 
  (switch-to-buffer-other-window buffer-name) 
  (if (< (/ (frame-height) 3) 
	 (window-height)) 
      (shrink-window (/ (window-height) 2))) 
  (if dont-return-old-buffer nil (switch-to-buffer-other-window temp-buffer-name)))

(defun m-run-command (command) 
  "compile project"
  (m-show-compilation "*compilation*") ;;
  (compile command))

(defun m-create-project(command openfile) 
  (let  ((project-name (read-file-name "hello:" nil default-directory nil))) 
    (setq default-directory (f-dirname project-name)) 
    (f-mkdir default-directory) 
    (if (= (shell-command (concat (s-replace "%s" (f-filename project-name) command))) 0) 
	(progn (message (concat "shell-cmd:" )) 
	       (find-file (concat project-name "/" openfile)) 
	       (message (concat "created new project '" (f-filename project-name) "'"))) 
      (message (concat "created new project '" (f-filename project-name) "' failed!")))))

(defun m-buffer-reload() 
  (interactive) 
  (save-buffer) 
  (setq old-pos (point)) 
  (goto-char (point-min)) 
  (find-alternate-file (buffer-file-name)) 
  (goto-char old-pos))

(defun m-mark-all-like-this () 
  "Find and mark all the parts of the buffer matching the currently active region" 
  (interactive) 
  (condition-case err (progn (mc/mark-all-like-this)) 
    (error 
     (message "error: %s"(car (cdr err))))))

(defun my-grep-project (word) 
  "Show the explanation of WORD from Bing in the echo area." 
  (interactive (let* ((default (if (use-region-p) 
				   (buffer-substring-no-properties 
				    (region-beginning) 
				    (region-end)) 
				 (let ((text (thing-at-point 'word))) 
				   (if text (substring-no-properties text))))) 
		      (prompt (if (stringp default) 
				  (format "grep (default \"%s\"): " default) "grep: ")) 
		      (string (read-string prompt nil nil default))) 
		 (list string))) 
  (save-match-data (m-grep-project  word) 
		   (other-window 1)))

(defun my-grep-directory (word) 
  "Show the explanation of WORD from Bing in the echo area." 
  (interactive (let* ((default (if (use-region-p) 
				   (buffer-substring-no-properties 
				    (region-beginning) 
				    (region-end)) 
				 (let ((text (thing-at-point 'word))) 
				   (if text (substring-no-properties text))))) 
		      (prompt (if (stringp default) 
				  (format "grep (default \"%s\"): " default) "grep: ")) 
		      (string (read-string prompt nil nil default))) 
		 (list string))) 
  (save-match-data (m-grep-directory  word) 
		   (other-window 1)))

(defun m-grep-project (str) 
  (if (stringp str) 
      (m-run-command (concat "grep -n " "\"" str "\"" " -r " (m-project-root)))))

(defun m-grep-directory (str) 
  (message (concat "grep-dir:" str)) 
  (if (stringp str) 
      (m-run-command (concat "grep -n " "\"" str "\"" " -r " (file-name-directory
							      buffer-file-name)))))

(defun m-open-reddit-channel (word) 
  "Show the explanation of WORD from Bing in the echo area." 
  (interactive (let* ((default (if (use-region-p) 
				   (buffer-substring-no-properties 
				    (region-beginning) 
				    (region-end)) 
				 (let ((text (thing-at-point 'word))) 
				   (if text (substring-no-properties text))))) 
		      (prompt (if (stringp default) 
				  (format "reddit (default \"%s\"): " default) "reddit: ")) 
		      (string (read-string prompt nil nil default))) 
		 (list string))) 
  (m-open-url (concat "https://www.reddit.com/r/" word "/")))

(defun m-open-stackoverflow-channel (word) 
  "Show the explanation of WORD from Bing in the echo area." 
  (interactive (let* ((default (if (use-region-p) 
				   (buffer-substring-no-properties 
				    (region-beginning) 
				    (region-end)) 
				 (let ((text (thing-at-point 'word))) 
				   (if text (substring-no-properties text))))) 
		      (prompt (if (stringp default) 
				  (format "StackOverflow (default \"%s\"): " default)
				"StackOverflow: ")) 
		      (string (read-string prompt nil nil default))) 
		 (list string))) 
  (m-open-url (concat "http://stackoverflow.com/questions/tagged/" word)))
;; http://stackoverflow.com/questions/tagged/f%23



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(package-require-curl "elisp-format" "elisp-format.el"
		      "https://www.emacswiki.org/emacs/download/elisp-format.el")
(package-require-curl "xcowsay" "xcowsay.el" "https://www.emacswiki.org/emacs/download/xcowsay.el")
(package-require-curl "pink-bliss" "pink-bliss-theme.el"
		      "https://raw.githubusercontent.com/kensanata/elisp/master/pink-bliss-theme.el")
(package-require-curl "pink-bliss" "pink-bliss.el"
		      "https://www.emacswiki.org/emacs/download/pink-bliss.el")
(package-require-curl "pink-bliss" "pink-gnu.xpm"
		      "http://www.emacswiki.org/emacs/download/pink-gnu.xpm")

;; (package-require-git "window-layout" "https://github.com/kiwanami/emacs-window-layout.git")
;; (package-require-git "E2WM" "https://github.com/kiwanami/emacs-window-manager.git")

;; (require 'e2wm)

;; (global-set-key (kbd "M-+") 'e2wm:start-management)
;;Example Usage:
;;
;;(when-terminal
;;    (load-my-term-theme)
;;    (set-some-keybindings)
;;    (foo-bar))

;; (symbol-to-string major-mode) ;;cl
;;(find-library (file-name-sans-extension (symbol-file major-mode)))

;;(setq list '(alpha beta gamma delta))
;;(butlast list 2)
;;
(provide 'mod-library)
