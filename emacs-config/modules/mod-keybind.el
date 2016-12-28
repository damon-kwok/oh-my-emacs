;;; -*- lexical-binding: t -*-
;;; mod-basic.el --- This is where you apply your OCD.
;;;
;;; Author: gww <damon-kwok@outlook.com>
;;; Date: 2016-02-16
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
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'mod-package)



;;Mac osx: set command to meta
;;; I prefer cmd key for meta
;; (setq mac-option-key-is-meta nil
      ;; mac-command-key-is-meta t
      ;; mac-command-modifier 'meta
      ;; mac-option-modifier 'none)

(global-set-key (kbd "C-\\") 'toggle-input-method)
(global-set-key "\C-z" 'set-mark-command) ;;C-Space C-@ C-z S-space ;; (global-set-key [?\S- ] 'set-mark-command)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; expand region
(package-require 'expand-region)
(require 'expand-region)
(global-set-key (kbd "M-z") 'er/expand-region) ;; (global-set-key "\M-z" 'mark-word)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;; move line
;; (package-require-git "move-lines" "https://github.com/targzeta/move-lines.git")
;; (require 'move-lines)

;; ;;; After that, you can move the line(s) up by M-p or down by M-n.
;; (global-set-key (kbd "M-p") 'move-lines-up)
;; (global-set-key (kbd "M-n") 'move-lines-down)

;; (global-set-key (kbd "M-<up>") 'move-lines-up)
;; (global-set-key (kbd "M-<down>") 'move-lines-down)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `move-text'
(package-require 'move-text)
(require 'move-text)

;;; After that, you can move the line(s) up by M-p or down by M-n.
;;; (move-text-default-bindings)

(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)
;; (global-set-key (kbd "M-<up>") 'move-text-up)
;; (global-set-key (kbd "M-<down>") 'move-text-down)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `buffer-move'
(package-require 'buffer-move)
(require 'buffer-move)

(global-set-key (kbd "<C-M-up>")     'buf-move-up)
(global-set-key (kbd "<C-M-down>")   'buf-move-down)
(global-set-key (kbd "<C-M-left>")   'buf-move-left)
(global-set-key (kbd "<C-M-right>")  'buf-move-right)

;;; Alternatively, you may let the current window switch back to the previous buffer,
;;; instead of swapping the buffers of both windows.
;;; Set the following customization variable to 'move to activate this behavior:
(setq buffer-move-behavior 'move)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
(global-set-key (kbd "C-M-d") 'delete-backward-char)
(global-set-key (kbd "C-x C-c") 'medusa-exit) ;;[(control x) (control c)]

(global-set-key (kbd "C--") 'shrink-window)
(global-set-key (kbd "C-=") 'enlarge-window)
(global-set-key (kbd "C-M--") 'shrink-window-horizontally)
(global-set-key (kbd "C-M-=") 'enlarge-window-horizontally)

;;; minibuffer (press mouse left, show: shrink-compile-window
;; (define-key minibuffer-local-map [double-mouse-1] 'shrink-compile-window)


(package-require 'switch-window)
(require 'switch-window)
(global-set-key (kbd "C-x o") 'switch-window)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Swiper
;; (package-require 'swiper)
;; (require 'swiper)

;; (ivy-mode 1)
;; (setq ivy-use-virtual-buffers t)

;; (global-set-key "\C-s" 'swiper)

;; (global-set-key (kbd "C-c C-r") 'ivy-resume)
;; (global-set-key (kbd "<f6>") 'ivy-resume)
;; (global-set-key (kbd "M-x") 'counsel-M-x)
;; (global-set-key (kbd "C-x C-f") 'counsel-find-file)
;; (global-set-key (kbd "<f1> f") 'counsel-describe-fu4nction)
;; (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
;; (global-set-key (kbd "<f1> l") 'counsel-load-library)
;; (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
;; (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
;; (global-set-key (kbd "C-c g") 'counsel-git)
;; (global-set-key (kbd "C-c j") 'counsel-git-grep)
;; (global-set-key (kbd "C-c k") 'counsel-ag)
;; (global-set-key (kbd "C-x l") 'counsel-locate)
;; (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; htmlize
(package-require 'htmlize)
(require 'htmlize)
;; (global-set-key (kbd "C-c p") 'htmlize-buffer)
;; (global-set-key (kbd "C-c C-p") 'htmlize-file)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; bing-dict
(package-require 'bing-dict)
(require 'bing-dict)
;; (global-set-key (kbd "C-c d") 'bing-dict-brief)
;; (global-set-key (kbd "C-c D") 'bing-dict-brief-web)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (define-key global-map (kbd "C-c f") 'go-to-char-forward)
;; (define-key global-map (kbd "C-c b") 'go-to-char-backward)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(package-require 'neotree)
(require 'neotree)
(global-set-key [f1] 'neotree-toggle)
;; (global-set-key (kbd "C-c t") 'neotree-toggle)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(package-require 'multiple-cursors)
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-M-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-M->") 'mc/mark-all-like-this)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C-x r (file rename)
;; (global-set-key (kbd "C-c r") 'rename-file-and-buffer)
;; (global-set-key (kbd "C-c x") 'delete-file-and-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; string replace
;; (global-set-key (kbd "C-M-s") 'replace-string)
;; (global-set-key (kbd "C-M-r") 'replace-rectangle)

;; (define-key sh-mode-map (kbd "C-c C-r") 'replace-string)
;; (add-hook 'shell-mode-hook (lambda () (local-set-key (kbd "M-s") 'replace-string)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (global-set-key (kbd "C-x M-k") 'kill-all-buffers)
;; (global-set-key (kbd "C-x M-k") 'kill-other-buffers)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `hydra'
(package-require 'hydra)
(require 'hydra)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `tty'
;; (defhydra hydra-show-tty

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `buffer'
(defhydra hydra-show-buffer 
  (:color blue)
  "
^Cmooand^            ^Buffer1^         ^Buffer2^
^^^^^^^^-------------------------------------------------------------------------
_l_: buffers-list    _m_: Messages       _s_: *eshell*
^^                   _w_: eww            _S_: *shell*
^^                   _t_: scratch       ^^
^^                   _c_: compilation   ^^
^^                   _C_: Compile-Log   ^^
^^                   ^^                 ^^
^^                   ^^                 ^^
^^^^^^^^-------------------------------------------------------------------------
_0_: calendar    _<escape>_: Quit   <tab>_: <-BACK
" ("l" (helm-buffers-list) "buffers-list")
("m" (m-show-buffer "*Messages*") "*Messages*")
("w" (m-show-buffer "*eww*") "*eww*")
("t" (m-show-buffer "*scratch*") "*scratch*")
("c" (m-show-buffer "*compilation*") "*compilation*")
("C" (m-show-buffer "*Compile-Log*") "*scratch*")
("s" eshell "*eshell*")
("S" (shell "*shell*"))
("0" (calendar) "calendar")
("<tab>" (hydra-do-space/body) "BACK")
("q" nil "Quit")
("<escape>" nil "Quit"))
;; (global-set-key (kbd "C-c s") 'hydra-show-buffer/body)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `hydra-open-module'
(defhydra hydra-open-config 
  (:color blue)
  "
^Basic^            ^Layout^         ^Editor^          ^Language^      ^Other^
^^^^^^^^-------------------------------------------------------------------------
_i_: init          _t_: tabbar      _6_: orgmode      _1_: elisp      _z_: input
_a_: basic         _h_: helm        _7_: latex        _2_: clojure    _m_: music
_p_: package       ^^               _8_: markdown     _3_: csharp     _d_: coding
_k_: keybind       ^^               _9_: reST         _4_: js         _s_: server
_l_: library       ^^               _z_: csv          _5_: cc         ^^
_y_: complete-yas  ^^               _x_: protobuf     ^^              ^^
^^                 ^^               ^^                ^^              ^^
^^^^^^^^-------------------------------------------------------------------------
_0_: calendar    _<escape>_: Quit   <tab>_: <-BACK           ^ ^             ^ ^
" ("i" (m-open-mod "init") "init")
("a" (m-open-mod "basic") "basic")
("p" (m-open-mod "package") "package")
("k" (m-open-mod "keybind") "keybind")
("l" (m-open-mod "library") "library")
("y" (m-open-mod "complete") "complete")

("t" (m-open-mod "tabbar") "tabbar")
("h" (m-open-mod "helm") "helm")
;;("3" (m-open-mod "theme") "theme")
;;("4" (m-open-mod "speedbar") "speedbar")
("T" (m-open-file "~/emacs-config/themes/m-xemacs-theme.el") "theme")
("1" (m-open-mod "elisp") "elisp")
("2" (m-open-mod "clojure") "clojure")
("3" (m-open-mod "csharp") "csharp")
("4" (m-open-mod "javascript") "javascript")
("5" (m-open-mod "cc") "cc")

;;("w" (m-open-mod "web") "web")

("6" (m-open-mod "orgmode") "orgmode")
("7" (m-open-mod "latex") "latex")
("8" (m-open-mod "markdown") "markdown")
("9" (m-open-mod "rest") "reST")
("z" (m-open-mod "csv") "csv")
("x" (m-open-mod "protobuf") "protobuf")

("z" (m-open-mod "chinese-py") "input")
("m" (m-open-mod "music") "music")
("d" (m-open-mod "coding") "coding")
("s" (m-open-mod "server") "server")

("0" calendar)
("<tab>" (hydra-do-space/body) "BACK")
("q" nil "Quit")
("<escape>" nil "Quit"))
;; (global-set-key (kbd "C-c c") 'hydra-open-config/body)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `hydra-open-url'
(defhydra hydra-open-url 
  (:color blue)
  "
^News^       ^Search^          ^Tut^                 ^Awesome^          ^site^
^^^^^^^^------------------------------------------------------------------------------
_1_: Bing    _5_: Weibo#Emacs# _x_: Xahlee           _a_: Awesomeness   _v_: Github
_2_: Baidu   _6_: Tuicool      _m_: Manual           _e_: Emacs         _9_: wego
_3_: Taobao  _7_: oschina      _k_: emacs-tutor      _y_: Clojure        ^ ^
_4_: Amazon  _8_: GAME         _l_: MasteringEmacs   _c_: CommonLisp     ^ ^
^^^^^^^^------------------------------------------------------------------------------
_<escape>_: Quit    _0_: calendar     _<tab>_: <-BACK          ^^ ^^
" ("1" (m-open-url "http://cn.bing.com/") "Bing")
("2" (m-open-url "https://www.baidu.com/") "Baidu")
("3" (m-open-url "https://www.taobao.com/") "Taobao")
("4" (m-open-url "http://www.amazon.cn/") "Amazon")
("5" (m-open-url
      "http://weibo.com/p/100808169bafefac5c96e7ad8b1714ec46c585?k=Emacs&from=501&_from_=huati_topic") "WeiBo #Emacs#")
("6" (m-open-url "http://www.tuicool.com/topics") "tuicool")
("7" (m-open-url "http://www.oschina.net/news") "oschina")
("8" (m-open-url "http://www.3dmgame.com/news/") "3dm-news")
("x" (m-open-url "http://ergoemacs.org/emacs/elisp.html") "Xahlee Elisp")
("m" (m-open-url "http://www.gnu.org/software/emacs/manual/html_node/elisp/index.html#SEC_Contents")
 "Manual")
("k" (m-open-url "http://tuhdo.github.io/emacs-tutor.html") "emacs-tutor")
("l" (m-open-url "https://masteringemacs.org/book") "MasteringEmacs")
("a" (m-open-url "https://github.com/bayandin/awesome-awesomeness") "awesome-awesomeness")
("e" (m-open-url "https://github.com/emacs-tw/awesome-emacs") "awesome-emacs")
("y" (m-open-url "https://github.com/razum2um/awesome-clojure") "Clojure")
("c" (m-open-url "https://github.com/CodyReichert/awesome-cl") "CommonLisp")
("v" (m-open-url "https://github.com/") "github")
("9" (m-open-url "http://wttr.in/") "wego")
("0" (calendar) "calendar")
("<tab>" (hydra-do-space/body) "BACK")
("q" nil "Quit")
("<escape>" nil "Quit"))
;; (global-set-key (kbd "C-c w") 'hydra-open-url/body)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `hydra-open-file'
(defhydra hydra-open-file 
  (:color blue)
  "
^Editor^        ^Export^                ^Docs^              ^Docs^
^^^^^^^^-----------------------------------------------------------------
_r_:rename      _p_: htmlize-buffer     _h_: README.org      _n_: note.org
_d_:delete      _P_: htmlize-file       _d_: diary.org       _p_: problem.org
_k_:close-all   _C_: complie-modules    _t_: todo.org        _s_: passwd.org
_o_:kill-other  ^^                      _b_: book.org        _g_: game.org
^^                 ^^                   _N_: NEWS.org ^^
^^^^^^^^-----------------------------------------------------------------
_0_: calendar       _<escape>_: Quit   _<tab>_: <-BACK ^^
" ("r" rename-file-and-buffer "rename-file-and-buffer")
("d" delete-file-and-buffer "delete-file-and-buffer")
("k" kill-all-buffers "kill-all-buffers")
("o" kill-other-buffers "kill-other-buffers")
("p" htmlize-buffer "htmlize-buffer")
("P" htmlize-file "htmlize-file")
("C" (byte-recompile-directory "~/emacs-config") "byte-recomplie-directory")
("h" (m-open-file "~/../README.org") "README.org")
("g" (m-open-doc "gtd.org") "GTD.org")
("t" (m-open-doc "todo.org") "todo.org")
("b" (m-open-doc "book.org") "book.org")
("n" (m-open-doc "note.org") "note.org")
("p" (m-open-doc "problem.org") "problem.org")
("s" (m-open-doc "passwd.org") "passwd.org")
("g" (m-open-doc "game.org") "game.org")
("N" (m-open-doc "news.org") "news.org")
("<tab>" helm-keyboard-quit "back" 
 :exit t)
("0" (calendar) "calendar")
("<tab>" (hydra-do-space/body) "BACK")
("q" nil "Quit")
("<escape>" nil "Quit"))
;; (global-set-key (kbd "C-c f") 'hydra-open-file/body)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `C-SPC'
(defhydra hydra-do-space 
  (:color blue)
  "
^SPC^            ^Buffer^               ^Search^              ^UI|View^
^^^^^^^^---------------------------------------------------------------------------------
^^               _>_: goto-char-f       _G_: grep-project     _;_: <-
_b_: Buffer=>    _<_: goto-char-b       _g_: grep-directory   _'_: ->
_f_: File  =>    _s_: replace-string    _d_: bing-dict        _[_: up
_m_: Module=>    _S_: query-replace     _D_: bing-dict-web    _/_: down
_w_: URLs  =>    _e_: mc/mark-all       ^^                    _=_: scale-inc
^^               _r_: Reload|Refresh    ^^                    _-_: scale-dec
_<tab>_: recent  ^^                     ^^                    ^^
^^^^^^^^---------------------------------------------------------------------------------
_<escape>_: Quit        _0_: Calendar          ^^                    ^^
" ("b" (hydra-show-buffer/body) "buffer")
("f" (hydra-open-file/body) "file")
("m" (hydra-open-config/body) "module")
("c" (hydra-open-config/body) "module")
("w" (hydra-open-url/body) "url")
("<tab>" helm-recentf "(helm-recentf)")
(">" go-to-char-forward "go-to-char-forward")
("<" go-to-char-backward "go-to-char-backward")
("s" replace-string "replace-string")
("S" query-replace "query-replace")
("e" (m-mark-all-like-this) "mc/mark-all-like-this")
("r" (m-buffer-reload) "Refresh")
("G" my-grep-project "projectile-project-root")
("g" my-grep-directory "projectile-directory-root")
("d" bing-dict-brief "bing-dict-brief")
("D" bing-dict-brief-web "bing-dict-brief-web")
(";" tabbar-backward "tabbar-backward")
("'" tabbar-forward "tabbar-forward")
("[" tabbar-backward-group "tabbar-up")
("/" tabbar-forward-group "tabbar-down")
("=" text-scale-increase "text-scale-increase")
("-" text-scale-decrease "text-scale-decrease")
("0" (calendar) "calendar")
("<SPC>" nil "quit")
("<escape>" nil "quit"))
(global-set-key (kbd "C-SPC") 'hydra-do-space/body)
(global-set-key (kbd "M-SPC") 'hydra-do-space/body)

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
  (m-run-command (concat "grep -n " "\"" str "\"" " -r " (file-name-directory buffer-file-name)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `comment-toggle' M-;
(global-set-key [remap comment-dwim] 'comment-or-uncomment-region-or-line)

;; (package-require 'smart-comment)
;; (require 'smart-comment)
;; (global-set-key (kbd "M-;") 'smart-comment)
;; (global-set-key (kbd "C-u M-;") 'smart-comment)
;; (global-set-key (kbd "C-u C-u M-;") 'smart-comment)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `guide-key'
;; (package-require 'guide-key)
;; (require 'guide-key)
;; (guide-key-mode 1)			; Enable guide-key-mode
;; (setq guide-key/idle-delay 0.7)
;; (setq guide-key/guide-key-sequence '("C-h" "C-c" "C-x" "C-t" "ESC"))
;; ;;(setq guide-key/guide-key-sequence t)
;; (setq guide-key/recursive-key-sequence-flag t)
;; (setq guide-key/popup-window-position 'bottom)
;; (setq guide-key/text-scale-amount 1)

;;; `guide-key-tip'
;; (package-require 'guide-key-tip)
;; (require 'guide-key-tip)
;; (setq guide-key-tip/enabled nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `which-key'
(package-require 'which-key)
(require 'which-key)
(which-key-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `disable-mouse'
;; (global-set-key [mouse-1] nil)
;; (global-set-key [mouse-2] nil)
;; (global-set-key [mouse-3] nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `disable-mouse-mode'
(define-minor-mode disable-mouse-mode
  "A minor-mode that disables all mouse keybinds."
  :global t
  :lighter " :mouse:"
  :keymap (make-sparse-keymap))

(dolist (type '(mouse down-mouse drag-mouse
                      double-mouse triple-mouse))
  (dolist (prefix '("" C- M- S- M-S- C-M- C-S- C-M-S-))
    ;; Yes, I actually HAD to go up to 7 here.
    (dotimes (n 7)
      (let ((k (format "%s%s-%s" prefix type n)))
        (define-key disable-mouse-mode-map
          (vector (intern k)) #'ignore)))))

(disable-mouse-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
(provide 'mod-keybind)
;;; mod-keybind.el ends here
