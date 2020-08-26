;; -*- lexical-binding: t -*-
;; mod-library.el --- This is where you apply your OCD.
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
(package-require 's)
(package-require 'f)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `keymap-unset-key'

(defun ome-keymap-unset-key (key keymap) 
  "Remove binding of KEY in a keymap
    KEY is a string or vector representing a sequence of keystrokes.

    Example:
    (ome-keymap-unset-key (kbd \"C-c <C-left>\") \"tabbar-mode\")
    (ome-keymap-unset-key [C-c <C-left>] \"tabbar-mode\")" 
  (interactive (list (call-interactively #'get-key-combo) 
                     (completing-read "Which map: " minor-mode-map-alist nil
                                      t))) 
  (let ((map (rest (assoc (intern keymap) minor-mode-map-alist)))) 
    (when map (define-key map key nil) 
          (message  "%s unbound for %s" key keymap))))


;; http://www.ergoemacs.org/emacs/elisp_idioms_prompting_input.html
(defun ome-query-user (x y) 
  (interactive "sEnter friend's name: \nnEnter friend's age: ") 
  (message "Name is: %s, Age is: %d" x y))

(defun ome-is-in-terminal() 
  (not (display-graphic-p)))

(defmacro when-terminal 
    (&rest 
     body)
  "Works just like `progn' but will only evaluate expressions in VAR when Emacs
is running in a terminal else just nil."
  `(when (ome-is-in-terminal) ,@body))

(defun ome-buffer-dirpath () 
  "Return current buffer directory path"
  (directory-file-name (if buffer-file-name (file-name-directory
                                             buffer-file-name)
                         default-directory)))

(defun ome-buffer-directory () 
  (if buffer-file-name (file-name-directory buffer-file-name) default-directory))

(defun ome-buf-dirpath() 
  (directory-file-name (ome-buffer-directory)))

(defun ome-buf-dirname() 
  (nth 0 (last (split-string (ome-buf-dirpath) "/") 1)))

(defun ome-project-file-exists-p (filename) 
  (file-exists-p (concat (ome-project-root) filename)))

(defun ome-project-run-command  (cmd) 
  (let ((oldir default-directory)) 
    (setq default-directory (ome-project-root)) 
    (ome-run-command cmd) 
    (setq default-directory oldir)))

(defun ome-major-mode-name () 
  (->> (symbol-name major-mode) 
       (s-split "-") 
       (reverse) 
       (cdr) 
       (reverse) 
       (s-join "-")))

(defun ome-bufname-no-ext() 
  (file-name-base (buffer-name)))

(defun ome-filename-no-ext() 
  (file-name-sans-extension (buffer-file-name)))

(defun ome-buf-ext() 
  (let ((ext-name (nth 0 (last (split-string (buffer-name) "\\.")))) 
        (buf-name (buffer-name))) 
    (if (string= ext-name buf-name) "" ext-name)))

(defun ome-project-root-p (path) 
  (setq-local files '("corral.json" "v.mod"                    ;;
                      ".projectile" ".git" ".svn" ".hg" ".bzr" ;;
                      "Makefile" "CMakeLists.txt" "make.bat" "make.ps1" ;;
                      "Dockerfile" ".editorconfig" ".gitignore" )) 
  (setq-local foundp nil) 
  (while (and files 
              (not foundp)) 
    (let* ((filename (car files)) 
           (filepath (concat (file-name-as-directory path) filename))) 
      (setq-local files (cdr files)) 
      (setq-local foundp (file-exists-p filepath))))
  foundp)

(defun ome-project-root 
    (&optional 
     path) 
  (let* ((bufdir (if buffer-file-name   ;
                     (file-name-directory buffer-file-name) default-directory)) 
         (curdir (if path (file-name-as-directory path) bufdir)) 
         (parent (file-name-directory (directory-file-name curdir))) 
         (parent-basename (file-name-base (directory-file-name parent)))) 
    ;; (message "cur: %s | base:%s | parent:%s" curdir parent-basename parent) 
    (if (or (not parent)
            (string= parent "")
            (string= parent "/")
            (string= parent curdir) 
            (string= parent (file-name-as-directory (getenv "HOME"))) 
            (and (>= (length parent-basename) 10) 
                 (string= (substring parent-basename 0 10) "smb-share:")) 
            (ome-project-root-p curdir)) ;
        curdir                           ;
      (ome-project-root parent))))

(defun ome-project-name () 
  (file-name-base (directory-file-name (ome-project-root))))

(defalias 'ome-project-dirname 'ome-project-name)

(defun ome-parent-dirpath (path) 
  (file-name-directory (directory-file-name path)))

(defun f-filename-no-ext (path) 
  (f-no-ext (f-filename path)))

(defun ome-search-file (filename &optional path) 
  (let* ((from (if path (file-name-as-directory path) 
                 (file-name-as-directory (ome-buf-dirpath)))) 
         (parent (ome-parent-dirpath from))) 
    (message "ome-search-file:%s, from:%s" filename from) 
    (if (file-exists-p (concat from filename)) 
        (progn (message from) from) 
      (if (or (eq parent nil) 
              (eq parent path) 
              (eq parent form) 
              (string= parent "/"))     ;
          nil (ome-search-file filename parent)))))

(defun ome-smart-find-file (filename &optional create) 
  " create cmake file with current directory!" 
  (interactive) 
  (let* ((dir (ome-buf-dirpath)) 
         (root-dir (ome-search-file filename dir))) 
    (if (eq root-dir nil) 
        (if create (find-file filename)) 
      (find-file (concat root-dir filename)))))

(defun ome-bing-dict-brief-eww (arg) 
  "compile project"
  (ome-show-compilation "*Messages*") 
  (other-window 1) 
  (eww (concat "https://www.bing.com/dict/search??mkt=zh-cn&q=" arg)))

(defun ome-bing-dict-brief-web (word) 
  "Show the explanation of WORD from Bing in the echo area." 
  (interactive (let* ((default (if (use-region-p) 
                                   (buffer-substring-no-properties 
                                    (region-beginning) 
                                    (region-end)) 
                                 (let ((text (thing-at-point 'word))) 
                                   (if text (substring-no-properties text))))) 
                      (prompt (if (stringp default) 
                                  (format
                                   "Search Bing web dict (default \"%s\"): "
                                   default) "Search Bing web dict: ")) 
                      (string (read-string prompt nil 'bing-dict-history
                                           default))) 
                 (list string))) 
  (save-match-data (ome-bing-dict-brief-eww word)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; copy a line
(defun ome-copy-line () 
  "copy a line" 
  (interactive) 
  (let ((pos (point))) 
    (beginning-of-visual-line) 
    (kill-visual-line) 
    (yank) 
    (goto-char pos)))

(defun ome-mark-line () 
  "copy a line" 
  (interactive) 
  (beginning-of-visual-line) 
  (let ((pos (point))) 
    (set-mark pos) 
    (end-of-visual-line)))

(defun ome-quick-copy-line () 
  "Copy the whole line that point is on and move to the beginning of the next line.
 Consecutive calls to this command append each line to the kill-ring." 
  (interactive) 
  (let ((beg (line-beginning-position 1)) 
        (end (line-beginning-position 2))) 
    (if (eq last-command 'quick-copy-line) 
        (kill-append 
         (buffer-substring 
          beg
          end) 
         (< end beg)) 
      (kill-new 
       (buffer-substring 
        beg
        end)))) 
  (beginning-of-line 2))

(defun ome-quick-cut-line () 
  "Cut the whole line that point is on.  Consecutive calls to this command
append each line to the kill-ring." 
  (interactive) 
  (let ((beg (line-beginning-position 1)) 
        (end (line-beginning-position 2))) 
    (if (eq last-command 'quick-cut-line) 
        (kill-append 
         (buffer-substring 
          beg
          end) 
         (< end beg)) 
      (kill-new 
       (buffer-substring 
        beg
        end))) 
    (delete-region beg end)) 
  (beginning-of-line 1) 
  (setq this-command 'quick-cut-line))

;; comment or uncomment
(defun ome-comment-or-uncomment-region-or-line () 
  "Comments or uncomments the region or the current line if there's no active region." 
  (interactive) 
  (let (beg end) 
    (if (region-active-p) 
        (setq beg (region-beginning) end (region-end)) 
      (setq beg (line-beginning-position) end (line-end-position))) 
    (comment-or-uncomment-region beg end) 
    (next-line)))

(defun ome-go-to-char-forward (n char) 
  "Move forward to Nth occurence of CHAR.
Typing `wy-go-to-char-key' again will move forwad to the next Nth
occurence of CHAR." 
  (interactive "p\ncGo to char: ") 
  (search-forward (string char) nil nil n) 
  (while (char-equal (read-char) char) 
    (search-forward (string char) nil nil n)) 
  (setq unread-command-events (list last-input-event)))

(defun ome-go-to-char-backward (n char) 
  "Move forward to Nth occurence of CHAR.
Typing `wy-go-to-char-key' again will move forwad to the next Nth
occurence of CHAR." 
  (interactive "p\ncGo to char: ") 
  (search-backward (string char) nil nil n) 
  (while (char-equal (read-char) char) 
    (search-backward (string char) nil nil n)) 
  (setq unread-command-events (list last-input-event)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun switch-to-buffer-by-major )
(defun ome-count-buffer-by-major (mode) 
  "Count buffers number by `major-mode'." 
  (interactive) 
  (let ((count-buf 0)) 
    (mapcar #'(lambda (BUFFER_OR_NAME) 
                (if (eq mode (buffer-local-value 'major-mode (get-buffer
                                                              BUFFER_OR_NAME))) 
                    (setq count-buf (+ 1 count-buf)))) 
            (buffer-list)) 
    (message "count:%d" count-buf) count-buf))

(defun ome-find-buffer-by-major (mode) 
  "Find buffers by `major-mode'." 
  (interactive) 
  (if ( >  (ome-count-buffer-by-major mode) 0) 
      (mapcar #'(lambda (BUFFER_OR_NAME) 
                  (if (eq mode (buffer-local-value 'major-mode (get-buffer
                                                                BUFFER_OR_NAME))) 
                      (switch-to-buffer BUFFER_OR_NAME))) 
              (buffer-list)) 
    (erc)))

(defun ome-kill-all-buffers () 
  "Kill all buffers." 
  (interactive) 
  (mapcar 'kill-buffer (buffer-list)))

(defun ome-kill-buffer-by-name (NAME) 
  (if (get-buffer NAME) 
      (kill-buffer NAME)    ))

(defun ome-kill-other-buffers () 
  "Close all buffers but this." 
  (interactive) 
  (delete-other-windows) 
  (mapc 'kill-buffer (delq (current-buffer) 
                           (remove-if-not 'buffer-file-name (buffer-list)))))

;; http://rejeep.github.io/emacs/elisp/2010/11/16/delete-file-and-buffer-in-emacs.html
(defun ome-delete-file-and-buffer () 
  "Removes file connected to current buffer and kills buffer." 
  (interactive) 
  (let ((filename (buffer-file-name)) 
        (buffer (current-buffer)) 
        (name (buffer-name))) 
    (if (not (and filename 
                  (file-exists-p filename))) 
        (progn (message "Buffer '%s' is not visiting a file!" name) 
               (kill-buffer buffer)) 
      (when (yes-or-no-p "Are you sure you want to remove this file? ") 
        (delete-file filename) 
        (kill-buffer buffer) 
        (message "File '%s' successfully removed" filename)))))

;; Originally from stevey, adapted to support moving to a new directory.
(defun ome-rename-file-and-buffer (new-name) 
  "Renames both current buffer and file it's visiting to NEW-NAME." 
  (interactive (progn (if (not (buffer-file-name)) 
                          (error 
                           "Buffer '%s' is not visiting a file!"
                           (buffer-name))) 
                      (list (read-file-name (format "Rename %s to: "
                                                    (file-name-nondirectory
                                                     (buffer-file-name))))))) 
  (if (equal new-name "") 
      (error 
       "Aborted rename")) 
  (setq old-name-base (file-name-base (buffer-name))) 
  (setq new-name (if (file-directory-p new-name) 
                     (expand-file-name (file-name-nondirectory
                                        (buffer-file-name)) new-name) 
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

(defun ome-rename-file-and-buffer-ext (ext-name) 
  "rename extname with file and buffer"
  (ome-rename-file-and-buffer (concat (ome-bufname-no-ext) "." ext-name)))

(defun ome-server-shutdown () 
  "Save buffers, Quit, and Shutdown (kill) server" 
  (interactive) 
  (save-some-buffers) 
  (kill-emacs))

;; exit
(defun ome-play-exit-animate () 
  "say bye-bye !" 
  (interactive)
  ;; Make a suitable buffer to display the birthday present in.
  (switch-to-buffer (get-buffer-create "*bye*")) 
  (erase-buffer)
  ;; Display the empty buffer.
  (sit-for 0)
  ;;(animate-string "I'll miss you~" 7)
  ;;(sit-for 1) ;;wait 1 second
  (animate-string " Bye!!!" 9)
  ;;wait 1 second
  (sit-for 1))

(defun ome-exit-animate() 
  (interactive) 
  (cond ((y-or-n-p "Exit? ") 
         (medusa-bye) 
         (save-buffers-kill-emacs))))

(defun ome-exit() 
  (interactive)
  ;;`remove' the prompt for killing emacsclient buffers
  (remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function) 
  (cond ((y-or-n-p "Exit? ") ;;(y-or-n-p "Relax...? ")
         (save-buffers-kill-emacs))))

(defun ome-open-file(file-name) 
  (interactive) 
  (delete-other-windows) 
  (ome-show-compilation "*Messages*") 
  (other-window 1) ;;(switch-window)
  (find-file file-name) 
  (delete-other-windows))

(defun ome-open-mod(mod-name) 
  (interactive) 
  (delete-other-windows) 
  (ome-show-compilation "*Messages*") 
  (other-window 1) 
  (find-file                            ;
   (concat "~/.oh-my-emacs/emacs-config/modules/mod-" mod-name ".el")))

(defun ome-open-doc(doc-name) 
  (interactive) 
  (delete-other-windows) 
  (ome-show-compilation "*Messages*") 
  (other-window 1) ;;(switch-window)
  (find-file (concat (getenv "HOME") "/workspace/org/" doc-name)) 
  (delete-other-windows))

(defun ome-open-org-by-month(name) 
  (interactive) 
  (delete-other-windows) 
  (ome-show-compilation "*Messages*") 
  (other-window 1) 
  (let ((filename (concat name (format-time-string "-%Y-%m") ".org"))) 
    (find-file (concat (getenv "HOME") "/workspace/org/" filename))) 
  (delete-other-windows))

(defun ome-open-blog(doc-name) 
  (interactive) 
  (delete-other-windows) 
  (ome-show-compilation "*Messages*") 
  (other-window 1) 
  (find-file (concat (getenv "HOME") "/workspace/blog/src/index.org")) 
  (find-file (concat (getenv "HOME") "/workspace/blog/src/blog.org")) 
  (find-file (concat (getenv "HOME") "/workspace/blog/src/link.org")) 
  (find-file (concat (getenv "HOME") "/workspace/blog/src/" doc-name)) 
  (delete-other-windows))

(defun ome-new-blog() 
  (interactive) 
  (let ((oldir default-directory)) 
    (setq default-directory (concat (getenv "HOME") "/workspace/blog/src/")) 
    (helm-find-files nil) 
    (setq default-directory oldir)))

(defun ome-open-url_1(url) 
  (interactive) 
  (ome-show-compilation "*eww*") 
  (other-window 1) 
  (eww url))

(defun ome-open-url(url) 
  (interactive) 
  (if (string= (getenv "OME_OS") "MSYS2") 
      (ome-run-command (concat "cygstart " url)) 
    (ome-run-command (concat "xdg-open " url))))

(defun ome-find-file-doc() 
  (interactive) 
  (let  ((oldir default-directory)) 
    (setq default-directory  (concat (getenv "HOME") "/workspace/docs/")) 
    (helm-find-files nil) 
    (setq default-directory oldir)))

(defun ome-find-file-blog() 
  (interactive) 
  (let ((oldir default-directory)) 
    (setq default-directory  (concat (getenv "HOME") "/workspace/blog/src/")) 
    (helm-find-files nil) 
    (setq default-directory oldir)))

(defun ome-show-compilation (buffer-name &optional dont-return-old-buffer) 
  "shrink compile window, avoid compile window occupy 1/2 hight of whole window" 
  (interactive) 
  (delete-other-windows) 
  (let ((temp-buffer-name (buffer-name (current-buffer)))) 
    (switch-to-buffer-other-window buffer-name) 
    (if (< (/ (frame-height) 2) 
           (window-height)) 
        (shrink-window (/ (window-height) 2))) 
    (if dont-return-old-buffer nil (switch-to-buffer-other-window
                                    temp-buffer-name))))

(defun ome-compilation-buffer-name-function (mode-name) 
  (message "OME-COMPILE-BUFFER-NAME:%s" OME-COMPILE-BUFFER-NAME)
  ;; (format "*compilation:%d*" (random 65535))
  (if OME-COMPILE-BUFFER-NAME OME-COMPILE-BUFFER-NAME "*compilation*"))

;; (defun compilation-buffer-name (name-of-mode mode-command name-function)
;;   "Return the name of a compilation buffer to use.
;; If NAME-FUNCTION is non-nil, call it with one argument NAME-OF-MODE
;; to determine the buffer name.
;; Likewise if `compilation-buffer-name-function' is non-nil.
;; If current buffer has the major mode MODE-COMMAND,
;; return the name of the current buffer, so that it gets reused.
;; Otherwise, construct a buffer name from NAME-OF-MODE."
;;   ;;(message "name:%s, cmd:%s, func:%s" name-of-mode mode-command name-function)
;;   (cond (name-function (funcall name-function name-of-mode))
;;     (compilation-buffer-name-function (funcall compilation-buffer-name-function name-of-mode))
;;     ((eq mode-command major-mode)
;;       (buffer-name))
;;     (t (concat "*" (downcase name-of-mode) "*"))))

(defun ome-run-command (COMMAND &optional OUTPUT-BUFFER-NAME CURRENT-DIR) 
  "compile project" 
  (setq OME-COMPILE-BUFFER-NAME OUTPUT-BUFFER-NAME) 
  (if CURRENT-DIR 
      (setq default-directory CURRENT-DIR)) 
  (let* ((compilation-buffer-name-function
          'ome-compilation-buffer-name-function)) 
    (compile COMMAND)))

(defun ome-project-command (COMMAND) 
  (ome-run-command COMMAND nil (ome-project-root)))

;; (defun ome-run-command (command)
;;   "compile project"
;;   (setq temp-elisp-buffer-name (buffer-name (current-buffer)))
;;   (ome-show-compilation "*compilation*")
;;   (switch-to-buffer-other-window temp-elisp-buffer-name)
;;   (compile command)
;;   (ome-show-compilation "*compilation*" t))

;; (defun ome-run-command (command)
;;   "compile project"
;;   (ome-show-compilation "*Shell Command Output*")
;;   (shell-command command))

(defun ome-ask-new-project(command openfile) 
  (let*  ((oldir default-directory) 
          (project-path (read-file-name "choice project path:" oldir))) 
    (message "proj-path:%s" project-path) 
    (setq default-directory (f-dirname project-path))
    ;; (f-mkdir default-directory)
    (if (= (shell-command (concat (s-replace "%s" (f-filename project-path)
                                             command))) 0) 
        (progn (message (concat "shell-cmd:" )) 
               (find-file (concat project-path "/" (s-replace "%s" (f-filename
                                                                    project-path)
                                                              openfile))) 
               (message (concat "created new project '" (f-filename
                                                         project-path)
                                "' succeed:)"))) 
      (message (concat "creat new project '" (f-filename project-path)
                       "' failed:("))) 
    (setq default-directory oldir)))

(defun ome-project-wizard(lang) 
  (let* ((default-path "~/projects/") 
         (project-path (directory-file-name (read-file-name
                                             "choice project path:"
                                             default-path))) 
         (COMMAND (concat "bash -c \"" "app_wizard" " " lang " " project-path
                          "\""))
         ;; (OUTPUT-BUFFER-NAME (->> "ok"
         ;; (file-name-base)
         ;; (s-wrap "<" ">")
         ;; (s-concat "[app_wizard::" "lang" "]")
         ;; (s-wrap "*")))
         (OUTPUT-BUFFER-NAME (concat "*[wizard:" lang "] <" (file-name-base
                                                             project-path)
                                     ">*"))) 
    (message "*OUTPUT-BUFFER-NAME*:%s" OUTPUT-BUFFER-NAME) 
    (server-start) 
    (ome-run-command COMMAND OUTPUT-BUFFER-NAME)))

;; `cmake-file'
(defun ome-gen-cmake-file () 
  (if (string= (ome-project-root) "") 
      (message "project root not found!") 
    (shell-command (concat "gen_cmake_file " (ome-project-root)))))

(defun ome-cmake-build() 
  (interactive) 
  (message (concat "root:" (ome-project-root))) 
  (if (file-exists-p (concat (projectile-project-root) "CMakeLists.txt")) 
      (let ((cmd (concat "bash -c \"cmake_build " (projectile-project-root) "
\""))) 
        (message "emacs run:%s" cmd) 
        (ome-run-command cmd))))

(defun ome-buffer-reload() 
  (interactive) 
  (save-buffer) 
  (let ((old-pos (point))) 
    (find-alternate-file (buffer-file-name)) 
    (goto-char (point-min)) 
    (goto-char old-pos)))

(defun ome-mark-all-like-this () 
  "Find and mark all the parts of the buffer matching the currently active region" 
  (interactive) 
  (condition-case err (progn (mc/mark-all-like-this)) 
    (error 
     (message "error: %s"(car (cdr err))))))

(defun ome-grep-project (word) 
  "Show the explanation of WORD from Bing in the echo area." 
  (interactive (let* ((default (if (use-region-p) 
                                   (buffer-substring-no-properties 
                                    (region-beginning) 
                                    (region-end)) 
                                 (let ((text (thing-at-point 'word))) 
                                   (if text (substring-no-properties text))))) 
                      (prompt (if (stringp default) 
                                  (format "grep (default \"%s\"): " default)
                                "grep: ")) 
                      (string (read-string prompt nil nil default))) 
                 (list string))) 
  (save-match-data (--ome-grep-project  word) 
                   (other-window 1)))

(defun ome-grep-directory (word) 
  "Show the explanation of WORD from Bing in the echo area." 
  (interactive (let* ((default (if (use-region-p) 
                                   (buffer-substring-no-properties 
                                    (region-beginning) 
                                    (region-end)) 
                                 (let ((text (thing-at-point 'word))) 
                                   (if text (substring-no-properties text))))) 
                      (prompt (if (stringp default) 
                                  (format "grep (default \"%s\"): " default)
                                "grep: ")) 
                      (string (read-string prompt nil nil default))) 
                 (list string))) 
  (save-match-data (--ome-grep-directory  word) 
                   (other-window 1)))

(defun --ome-grep-project (str) 
  (if (stringp str) 
      (ome-run-command (concat "grep -n " "\"" str "\"" " -r "
                               (ome-project-root)))))

(defun --ome-grep-directory (str) 
  (message (concat "grep-dir:" str)) 
  (if (stringp str) 
      (ome-run-command (concat "grep -n " "\"" str "\"" " -r "
                               (ome-buffer-directory)))))

(defun ome-open-reddit-channel (word) 
  "Show the explanation of WORD from Bing in the echo area." 
  (interactive (let* ((default (if (use-region-p) 
                                   (buffer-substring-no-properties 
                                    (region-beginning) 
                                    (region-end)) 
                                 (let ((text (thing-at-point 'word))) 
                                   (if text (substring-no-properties text))))) 
                      (prompt (if (stringp default) 
                                  (format "reddit (default \"%s\"): " default)
                                "reddit: ")) 
                      (string (read-string prompt nil nil default))) 
                 (list string))) 
  (ome-open-url (concat "https://www.reddit.com/r/" word "/")))

(defun ome-open-stackoverflow-channel (word) 
  "Show the explanation of WORD from Bing in the echo area." 
  (interactive (let* ((default (if (use-region-p) 
                                   (buffer-substring-no-properties 
                                    (region-beginning) 
                                    (region-end)) 
                                 (let ((text (thing-at-point 'word))) 
                                   (if text (substring-no-properties text))))) 
                      (prompt (if (stringp default) 
                                  (format "StackOverflow (default \"%s\"): "
                                          default) "StackOverflow: ")) 
                      (string (read-string prompt nil nil default))) 
                 (list string))) 
  (ome-open-url (concat "http://stackoverflow.com/questions/tagged/" word)))
;; http://stackoverflow.com/questions/tagged/f%23

(defun ome-load-file-to-string (path) 
  "Return path's file content."
  (with-temp-buffer (insert-file-contents path) 
                    (buffer-string)))

(defun ome-read-lines (path) 
  "Return a list of lines of a file at path."
  (if (file-exists-p path) 
      (with-temp-buffer (insert-file-contents path) 
                        (split-string (buffer-string) "\n" t)) ""))

(defun ome-eval-string (string) 
  "Evaluate elisp code stored in a string. (ome-eval-string \"(+ 1 2)\") is 3"
  (eval (car (read-from-string string))))

(defun ome-mu4e-open () 
  (interactive) 
  (if (and (executable-find "mu") 
           (executable-find "mbsync")) 
      (progn ;;
        (module-require 'mod-email) 
        (mu4e)) 
    (message "Please install 'mu' and 'isync'!")))

(defun ome-mu4e-new () 
  (interactive) 
  (if (and (executable-find "mu") 
           (executable-find "mbsync")) 
      (progn ;;
        (module-require 'mod-email) 
        (mu4e-compose-new)) 
    (message "Please install 'mu' and mbsync!")))

(package-download 'ascii-table)
(defun ome-ascii-table () 
  (interactive) 
  (internal-require 'ascii-table) 
  (ascii-table))
;;
(provide 'mod-library)
