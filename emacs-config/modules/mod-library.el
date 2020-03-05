;; -*- lexical-binding: t -*-
;; mod-library.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2015-2015 Damon Kwok
;;
;; Author: damon-kwok <damon-kwok@outlook.com>
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
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;
;; Code:
(internal-require 'cl)
(package-require 's)
(package-require 'f)

;; (projectile-project-p)
;; (projectile-project-root)
;; (projectile-get-project-directories)
;; (ome-run-command (concat "grep -n --include=\"*.el\" \"buffer-\" -R ./"));; (projectile-project-root)))

;;(ome-run-command (concat "grep -n --include=\"*.el\" \"buffer-\" -R ./" (projectile-project-root)))
;;(ome-run-command (concat "grep -n \"buffer-\" -r ./" (projectile-project-root)))

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

(defun ome-keymap-unset-key (key keymap) 
  "Remove binding of KEY in a keymap
    KEY is a string or vector representing a sequence of keystrokes.

    Example:
    (ome-keymap-unset-key (kbd \"C-c <C-left>\") \"tabbar-mode\")
    (ome-keymap-unset-key [C-c <C-left>] \"tabbar-mode\")" 
  (interactive (list (call-interactively #'get-key-combo) 
                     (completing-read "Which map: " minor-mode-map-alist nil t))) 
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
  "Works just like `progn' but will only evaluate expressions in VAR when Emacs is running in a terminal else just nil."
  `(when (ome-is-in-terminal) ,@body))


(defun ome-buf-dirpath() 
  (directory-file-name (file-name-directory buffer-file-name)))

(defun ome-buf-dirname() 
  (nth 0 (last (split-string (ome-buf-dirpath) "/") 1)))

(defun ome-project-dirname() 
  (nth 0 (last (split-string (directory-file-name (ome-project-root)) "/") 1)))

(defun ome-project-file-exists-p (filename) 
  (file-exists-p (concat (ome-project-root) filename)))

(defun ome-project-run-command  (cmd) 
  (let ((oldir default-directory)) 
    (setq default-directory (ome-project-root)) 
    (ome-run-command cmd) 
    (setq default-directory oldir)))

;; (defun ome-bufname-no-ext()
;; (first (split-string (buffer-name) "\\."))) ;;file-name-base
(defun ome-bufname-no-ext() 
  (file-name-base (buffer-name)))

(defun ome-filename-no-ext() 
  (file-name-sans-extension (buffer-file-name)))

(defun ome-buf-ext() 
  (let ((ext-name (nth 0 (last (split-string (buffer-name) "\\.")))) 
        (buf-name (buffer-name))) 
    (if (string= ext-name buf-name) "" ext-name)))

(defun ome-project-root() 
  (let ((fist-char (substring (ome-bufname-no-ext) 0 1))) 
    (if (string= fist-char "*") "./" (if (projectile-project-p) 
                                         (projectile-project-root) 
                                       (ome-buf-dirpath)))))

;; (ome-parent-dirpath "c/haha/aaa/index.org")
;; (ome-buf-dirname)
;; (buffer-name)
;; (concat (ome-buf-dirname) "/" (buffer-name))

(defun ome-parent-dirpath (path) 
  (file-name-directory (directory-file-name path)))

(defun f-filename-no-ext (path) 
  (f-no-ext (f-filename path)))

(defun ome-search-file (filename &optional path) 
  (let* ((from (if path path (ome-buf-dirpath))) 
         (parent (ome-parent-dirpath from))) 
    (message (concat "check:" from)) 
    (if (file-exists-p (concat from filename)) 
        (progn (message from) from) 
      (if (or (eq parent nil) 
              (string= parent "/")) nil (ome-search-file filename parent)))))

(defun ome-smart-find-file (filename &optional create) 
  " create cmake file with current directory!" 
  (interactive) 
  (let* ((dir (ome-buf-dirpath)) 
         (cmake-dir (ome-search-file filename dir))) 
    (if (eq cmake-dir nil) 
        (if create (find-file filename)) 
      (find-file (concat cmake-dir filename)))))

;; (buffer-name)                  ;;=> "hello.txt"
;; (buffer-file-name)             ;;=> "/home/damon/docs/hello.txt"
;; (file-name-as-directory "/home/damon/docs") ;;=> "/home/damon/docs/"
;; (directory-file-name "/home/damon/docs/");;=> "/home/damon/docs"
;; (file-name-nondirectory "/home/damon/docs/hello.txt") ;;=> "hello.txt"
;; (file-name-directory "/home/damon/docs/1/2/3") ;;=> "home/damon/dacs/1/2/"
;; (file-name-directory "/home/damon/docs/1/2/");;=> "/home/damon/docs/1/2/" oooooooooooh!no!
;; (ome-file-directory "/home/damon/docs/1/2/") ;;=> "/home/damon/docs/1/" nice:)
;; (f-dirname "path/to/file.ext/") ;;=> "path/to/"


;; (f-filename-no-ext "path/to/file.txt") ;;=> "file"

;; (ome-filename-no-ext) ;;=>"file”
;; (ome-bufname-no-ext);;=>"file"
;; (ome-parent-dirpath "/path/to/hello.txt")
;; (ome-parent-dirpath "C:/")
;; (ome-buf-dirpath)                ;;=> "/home/damon/docs"
;; (ome-buf-dirname)      ;;=> "docs"
;; (ome-buffer-name-sans-extension) ;;=> "hello"
;; (ome-buffer-file-name-sans-extension) ;;=> "/home/damon/docs/hello"
;; (file-name-directory "/home/damon/docs/hello.txt");;=> "/home/damon/docs"
;; (ome-buf-ext)      ;;=> "el"

;; (ome-project-root)               ;;=> "/home/damon/docs"
;; (file-name-sans-extension "222/111.el") ;;==>222/111
;; (file-name-base "222/111.el") ;;==> 111
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (browse-url
;;  (concat "https://www.bing.com/dict/search?q="
;; 	 (url-hexify-string
;; 	  (read-string "Query: "))))

(defun ome-bing-dict-brief-eww (arg) 
  "compile project"
  ;;(interactive)
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
                                  (format "Search Bing web dict (default \"%s\"): " default)
                                "Search Bing web dict: ")) 
                      (string (read-string prompt nil 'bing-dict-history default))) 
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
    Consecutive calls to this command append each line to the
    kill-ring." 
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
  "Cut the whole line that point is on.  Consecutive calls to this command append each line to the kill-ring." 
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
  "Kill all other buffers." 
  (interactive) 
  (let ((count-buf 0)) 
    (mapcar #'(lambda (BUFFER_OR_NAME) 
                (if (eq mode (buffer-local-value 'major-mode (get-buffer BUFFER_OR_NAME))) 
                    (setq count-buf (+ 1 count-buf)))) 
            (buffer-list)) 
    (message "count:%d" count-buf) count-buf))

(defun ome-find-buffer-by-major (mode) 
  "Kill all other buffers." 
  (interactive) 
  (if ( >  (ome-count-buffer-by-major mode) 0) 
      (mapcar #'(lambda (BUFFER_OR_NAME) 
                  (if (eq mode (buffer-local-value 'major-mode (get-buffer BUFFER_OR_NAME))) 
                      (switch-to-buffer BUFFER_OR_NAME))) 
              (buffer-list)) 
    (erc)))

;; (>  (ome-count-buffer-by-major 'erc-mode) 0)

;; close all buffer
(defun ome-kill-all-buffers () 
  "Kill all other buffers." 
  (interactive) 
  (mapcar 'kill-buffer (buffer-list)))

;; kill buffer by name
;; (defun ome-kill-buffer-by-name (NAME)
;; (let ((buf (get-buffer NAME)))
;; (if buf (kill-buffer buf t)
;; (message "buffer '%s' not exist!" NAME))))
(defun ome-kill-buffer-by-name (NAME) 
  (if (get-buffer NAME) 
      (kill-buffer NAME)
    ;; (message "buffer '%s' not exist!" NAME)
    ))

;; close all buffer but this
(defun ome-kill-other-buffers () 
  "Kill all other buffers." 
  (interactive) 
  (delete-other-windows) 
  (mapc 'kill-buffer (delq (current-buffer) 
                           (remove-if-not 'buffer-file-name (buffer-list)))))

;; delete current buffer && file
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
;; ome-rename-file-and-buffer
(defun ome-rename-file-and-buffer (new-name) 
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

(defun ome-rename-file-and-buffer-ext (ext-name) 
  "rename extname with file and buffer"
  (ome-rename-file-and-buffer (concat (ome-bufname-no-ext) "." ext-name)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; define function to shutdown emacs server instance
(defun ome-server-shutdown () 
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
(defun ome-play-exit-animate () 
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

  ;;wait 1 second
  (sit-for 1))

;;`remove' the prompt for killing emacsclient buffers
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

(defun ome-exit-animate() 
  (interactive) 
  (cond ((y-or-n-p "Exit? ") 
         (medusa-bye) 
         (save-buffers-kill-emacs))))

(defun ome-exit() 
  (interactive) 
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
  (other-window 1) ;;(switch-window)
  (find-file (concat "~/.oh-my-emacs/emacs-config/modules/mod-" mod-name ".el")) 
  (delete-other-windows))

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
  (other-window 1) ;;(switch-window)
  (let ((filename (concat name (format-time-string "-%Y-%m") ".org"))) 
    (find-file (concat (getenv "HOME") "/workspace/org/" filename))) 
  (delete-other-windows))

(defun ome-open-blog(doc-name) 
  (interactive) 
  (delete-other-windows) 
  (ome-show-compilation "*Messages*") 
  (other-window 1) ;;(switch-window)
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

(defun ome-open-url(url) 
  (interactive) 
  (ome-show-compilation "*eww*") 
  (other-window 1) 
  (eww url))

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


(defun ome-show-compilation(buffer-name &optional dont-return-old-buffer) 
  "shrink compile window, avoid compile window occupy 1/2 hight of whole window" 
  (interactive) 
  (delete-other-windows) 
  (let ((temp-buffer-name (buffer-name (current-buffer)))) 
    (switch-to-buffer-other-window buffer-name) 
    (if (< (/ (frame-height) 3) 
           (window-height)) 
        (shrink-window (/ (window-height) 2))) 
    (if dont-return-old-buffer nil (switch-to-buffer-other-window temp-buffer-name))))

(defun ome-run-command (command) 
  "compile project"
  (ome-show-compilation "*compilation*") ;;
  (compile command))


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
    (f-mkdir default-directory) 
    (if (= (shell-command (concat (s-replace "%s" (f-filename project-path) command))) 0) 
        (progn (message (concat "shell-cmd:" )) 
               (find-file (concat project-path "/" (s-replace "%s" (f-filename project-path)
                                                              openfile))) 
               (message (concat "created new project '" (f-filename project-path) "' succeed:)"))) 
      (message (concat "creat new project '" (f-filename project-path) "' failed:("))) 
    (setq default-directory oldir)))

(defun ome-project-wizard(lang) 
  (let* ((default-path (expand-file-name "~/projects/")) 
         (project-path (read-file-name "choice project path:" default-path)) 
         (str-cmd (concat "mkdir -p " default-path " ; "(expand-file-name
                                                         "~/.oh-my-env/bin/app_wizard") " " lang " "
                                                         project-path))) 
    (ome-run-command str-cmd) ))

(defun ome-project-wizard-old(lang) 
  (cond ((string= lang "clojure") 
         (ome-ask-new-project "lein new %s" "project.clj")) 
        ((string= lang "elixir") 
         (ome-ask-new-project "mix new %s" "mix.exs"))
        ;; ((string= lang "java")
        ;; (ome-ask-new-project "mkdir -p %s && cd %s && gradle init --type java-application" "src/main/java/App.java"))
        ((string= lang "java") 
         (ome-ask-new-project "mkdir -p %s && cd %s && gradle init --type java-application"
                              "src/main/java/App.java")) 
        ((string= lang "scala") 
         (ome-ask-new-project "mkdir -p %s && cd %s && gradle init --type scala-library"
                              "src/main/scala/Library.scala")) 
        ((string= lang "groovy") 
         (ome-ask-new-project "mkdir -p %s && cd %s && gradle init --type groovy-application"
                              "src/main/groovy/App.groovy")) 
        ((string= lang "python") 
         (ome-ask-new-project "mkdir -p %s && cd %s && pipenv --three" "Pipfile")) 
        ((string= lang "ruby") 
         (ome-ask-new-project "mkdir -p %s && cd %s && bundle init" "Gemfile")) 
        ((string= lang "c") 
         (ome-ask-new-project "gen_cmake_file %s" "CMakeLists.txt")) 
        ((string= lang "haskell") 
         (ome-ask-new-project "stack new %s" "src/Main.hs")) 
        ((string= lang "nim") 
         (ome-ask-new-project "nimble init %s" "src/%s.nim")) ;; not invalid
        ((string= lang "rust") 
         (ome-ask-new-project "cargo new %s --bin" "Cargo.toml"))
        ;; ((string= lang "go")
        ;; (ome-ask-new-project "mkdir -p %s && cd %s && rubigo init" "rubigo.json"))
        ((string= lang "go") 
         (ome-ask-new-project "mkdir -p %s && cd %s && dep init" "Gopkg.toml")) 
        ((string= lang "ros") 
         (ome-ask-new-project "rosman %s" "src/main.cpp"))))

(defun ome-cmake-build() 
  (if (file-exists-p (concat (projectile-project-root) "CMakeLists.txt")) 
      (ome-run-command (concat "cmake_build" " " (projectile-project-root)))))

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
                                  (format "grep (default \"%s\"): " default) "grep: ")) 
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
                                  (format "grep (default \"%s\"): " default) "grep: ")) 
                      (string (read-string prompt nil nil default))) 
                 (list string))) 
  (save-match-data (--ome-grep-directory  word) 
                   (other-window 1)))

(defun --ome-grep-project (str) 
  (if (stringp str) 
      (ome-run-command (concat "grep -n " "\"" str "\"" " -r " (ome-project-root)))))

(defun --ome-grep-directory (str) 
  (message (concat "grep-dir:" str)) 
  (if (stringp str) 
      (ome-run-command (concat "grep -n " "\"" str "\"" " -r " (file-name-directory
                                                                buffer-file-name)))))

(defun ome-open-reddit-channel (word) 
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
                                  (format "StackOverflow (default \"%s\"): " default)
                                "StackOverflow: ")) 
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
  (if (and (executable-find "offlineimap") 
           (executable-find "mu")) 
      (mu4e) 
    (message "Please install 'mu' and 'offlineimap'!")))

(defun ome-mu4e-new () 
  (interactive) 
  (if (and (executable-find "offlineimap") 
           (executable-find "mu")) 
      (mu4e-compose-new) 
    (message "Please install 'mu' and offlineimap!")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(package-download-curl "elisp-format" "elisp-format.el"
                       "https://www.emacswiki.org/emacs/download/elisp-format.el")
(package-download-curl "xcowsay" "xcowsay.el" "https://www.emacswiki.org/emacs/download/xcowsay.el")
(package-download-curl "pink-bliss" "pink-bliss-theme.el"
                       "https://raw.githubusercontent.com/kensanata/elisp/master/pink-bliss-theme.el")
(package-download-curl "pink-bliss" "pink-bliss.el"
                       "https://www.emacswiki.org/emacs/download/pink-bliss.el")
(package-download-curl "pink-bliss" "pink-gnu.xpm"
                       "http://www.emacswiki.org/emacs/download/pink-gnu.xpm")

(package-download-curl "multi-term" "multi-term.el"
                       "https://www.emacswiki.org/emacs/download/multi-term.el")
(package-download-curl "visws" "visws.el" "https://www.emacswiki.org/emacs/download/visws.el")

(setq multi-term-program "/bin/bash")
;; (package-download-git "window-layout" "https://github.com/kiwanami/emacs-window-layout.git")
;; (package-download-git "E2WM" "https://github.com/kiwanami/emacs-window-manager.git")

;; (internal-require 'e2wm)

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
