;; -*- lexical-binding: t -*-
;; mod-basic.el --- This is where you apply your OCD.
;;
;; Author: gww <damon-kwok@outlook.com>
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

;;Mac osx: set command to meta
;;; I prefer cmd key for meta
;; (setq mac-option-key-is-meta nil
;; mac-command-key-is-meta t
;; mac-command-modifier 'meta
;; mac-option-modifier 'none)



(global-set-key (kbd "C-c t") 'tool-bar-mode)
(global-set-key (kbd "C-c m") 'menu-bar-mode)
(global-set-key (kbd "C-c s") 'projectile-speedbar-toggle)
(global-set-key (kbd "C-c d") 'dired-sidebar-toggle-sidebar)

;; `repl'
(defun show-global-shell() 
  (interactive) 
  (setq temp-global-buffer-name (buffer-name (current-buffer))) 
  (ome-show-compilation "*shell*") 
  (shell) 
  (switch-to-buffer-other-window temp-global-buffer-name) 
  (ome-show-compilation "*shell*" t))

(defun show-global-shell-new() 
  (interactive) 
  (ome-kill-buffer-by-name "*shell*") 
  (show-global-shell))

(defun show-global-workbuffer() 
  (interactive) 
  (switch-to-buffer-other-window temp-global-buffer-name) 
  (delete-other-windows) 
  (show-global-shell) 
  (switch-to-buffer-other-window temp-global-buffer-name))

(global-set-key (kbd "C-c `") 'show-global-shell)
(define-key shell-mode-map (kbd "C-c `")  'show-global-workbuffer)
(global-set-key (kbd "C-c C-`") 'show-global-shell-new)

(global-set-key (kbd "C-c C-z") 'show-global-shell)
(define-key shell-mode-map (kbd "C-c C-z")  'show-global-workbuffer)

(add-hook 'sh-mode-hook '(lambda()
			   ;;	     (message (concat "you opened cc file:" (buffer-name)))
			   (define-key sh-mode-map (kbd "C-c C-z")  'show-global-shell)))

(global-set-key (kbd "C-M-w") 'ome-copy-line)
(global-set-key (kbd "C-M-z") 'ome-mark-line)


(global-set-key (kbd "M-,") ;;<backtab>
		'(lambda () 
                   (interactive) 
                   (switch-to-buffer (other-buffer (current-buffer) 1))))
;;


(package-require 'mwim)
(require 'mwim)
(global-set-key (kbd "C-a") 'mwim-beginning)
(global-set-key (kbd "C-e") 'mwim-end)

;;
(package-require 'ripgrep)
(require 'ripgrep)
;;


(package-require 'wand)
(require 'wand)
(global-set-key (kbd "<C-return>")       'wand:execute)
;; (global-set-key (kbd "<C-mouse-1>")      'wand:execute)
;; (global-set-key (kbd "<C-down-mouse-1>")  nil)
(wand:add-rule-by-pattern :match "\\$ " 

                          :capture
                          :after 
                          :action popup-shell-command)
(wand:add-rule-by-pattern :match "https?://" 

                          :capture
                          :whole 
                          :action browse-url)
(wand:add-rule-by-pattern :match "file:" 

                          :capture
                          :after 
                          :action find-file)
(wand:add-rule-by-pattern :match "#> " 

                          :capture
                          :after 
                          :action 
                          add-bracket-and-eval)

;; `folding'
;; (package-require 'vimish-fold)
;; (require 'vimish-fold)
;; (vimish-fold-global-mode 1)

(package-require 'yafolding)
(require 'yafolding)

(global-set-key (kbd "C-M-`") 'yafolding-toggle-all)
(global-set-key (kbd "C-~") 'yafolding-hide-parent-element)
(global-set-key (kbd "C-`") 'yafolding-toggle-element)

;; `anzu' https://github.com/syohex/emacs-anzu
(package-require 'anzu)
(require 'anzu)

(setq-default case-fold-search nil)
(setq-default case-replace nil)

(global-anzu-mode +1)
(global-set-key [remap query-replace] 'anzu-query-replace)
(global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)

(set-face-attribute 'anzu-mode-line nil 
                    :foreground "yellow" 
                    :weight 'bold)

(custom-set-variables '(anzu-mode-lighter "") 
                      '(anzu-deactivate-region t) 
                      '(anzu-search-threshold 1000) 
                      '(anzu-replace-threshold 50) 
                      '(anzu-replace-to-string-separator " => "))

(define-key isearch-mode-map [remap isearch-query-replace] #'anzu-isearch-query-replace)
(define-key isearch-mode-map [remap isearch-query-replace-regexp]
  #'anzu-isearch-query-replace-regexp)


(global-set-key (kbd "M-RET") 'toggle-frame-fullscreen)
;; (global-set-key (kbd "C-\\") 'toggle-input-method)
;; (global-set-key "\C-z" 'set-mark-command) ;;C-Space C-@ C-z S-super ;; (global-set-key [?\S- ] 'set-mark-command)


;;; expand region
(package-require 'expand-region)
(require 'expand-region)
(global-set-key (kbd "C-z") 'er/expand-region) ;; (global-set-key "\C-z" 'mark-word)
(global-set-key (kbd "C-x M-u") 'upcase-region)
(global-set-key (kbd "C-x M-l") 'downcase-region)

;; ;;; move line
;; (package-require-git "move-lines" "https://github.com/targzeta/move-lines.git")
;; (require 'move-lines)

;; ;;; After that, you can move the line(s) up by M-p or down by M-n.
;; (global-set-key (kbd "M-p") 'move-lines-up)
;; (global-set-key (kbd "M-n") 'move-lines-down)

;; (global-set-key (kbd "M-<up>") 'move-lines-up)
;; (global-set-key (kbd "M-<down>") 'move-lines-down)


;;; `move-text'
(package-require 'move-text)
(require 'move-text)

;;; After that, you can move the line(s) up by M-p or down by M-n.
;;; (move-text-default-bindings)

(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)
;; (global-set-key (kbd "M-<up>") 'move-text-up)
;; (global-set-key (kbd "M-<down>") 'move-text-down)


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


;;;
(global-set-key (kbd "C-M-d") 'delete-backward-char)
(global-set-key (kbd "C-x C-c") 'ome-exit) ;;[(control x) (control c)]

(global-set-key (kbd "C--") 'shrink-window)
(global-set-key (kbd "C-=") 'enlarge-window)
(global-set-key (kbd "C-M--") 'shrink-window-horizontally)
(global-set-key (kbd "C-M-=") 'enlarge-window-horizontally)

;;; minibuffer (press mouse left, show: shrink-compile-window
;; (define-key minibuffer-local-map [double-mouse-1] 'shrink-compile-window)

;; `switch-window'
(package-require 'switch-window)
(require 'switch-window)
(global-set-key (kbd "C-x o") 'switch-window)

;; `window-numbering'
(package-require 'window-numbering)
(require 'window-numbering)
(window-numbering-mode)
(setq window-numbering-assign-func (lambda () 
                                     (when (equal (buffer-name) "*Calculator*") 9)))


;; `page-break-lines'
(package-require 'page-break-lines)
(require 'page-break-lines)
(global-page-break-lines-mode)

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


;;; htmlize
(package-require 'htmlize)
(require 'htmlize)
;; (global-set-key (kbd "C-c p") 'htmlize-buffer)
;; (global-set-key (kbd "C-c C-p") 'htmlize-file)


;;; bing-dict
(package-require 'bing-dict)
(require 'bing-dict)

(setq bing-dict-show-thesaurus 'both)
(setq bing-dict-pronunciation-style 'us) ;;us | uk
(setq bing-dict-save-search-result t)
(setq bing-dict-org-file (concat (getenv "HOME") "/workspace/vocabulary.org"))
;; (global-set-key (kbd "C-c d") 'ome-bing-dict-brief)
;; (global-set-key (kbd "C-c D") 'ome-bing-dict-brief-web)


(define-key global-map (kbd "C-c f") 'ome-go-to-char-forward)
(define-key global-map (kbd "C-c b") 'ome-go-to-char-backward)

(package-require 'multiple-cursors)
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-M-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-M->") 'mc/mark-all-like-this)

;; C-x r (file rename)
;; (global-set-key (kbd "C-c r") 'ome-rename-file-and-buffer)
;; (global-set-key (kbd "C-c x") 'ome-delete-file-and-buffer)


;;; string replace
;; (global-set-key (kbd "C-M-s") 'replace-string)
;; (global-set-key (kbd "C-M-r") 'replace-rectangle)

;; (define-key sh-mode-map (kbd "C-c C-r") 'replace-string)
;; (add-hook 'shell-mode-hook (lambda () (local-set-key (kbd "M-s") 'replace-string)))


;; (global-set-key (kbd "C-x M-k") 'ome-kill-all-buffers)
(global-set-key (kbd "C-x M-k") 'ome-kill-other-buffers)

;;; `hydra'
(package-require 'hydra)
(require 'hydra)


;;; `tty'
;; (defhydra hydra-show-tty


(defun switch-to-scratch-buffer () 
  "Toggle between *scratch* buffer and the current buffer.
     If the *scratch* buffer does not exist, create it." 
  (interactive) 
  (let ((scratch-buffer-name  "*scratch*") 
        (prev-major-mode major-mode)) 
    (if (equal (buffer-name (current-buffer)) scratch-buffer-name) 
        (switch-to-buffer (other-buffer)) 
      (with-current-buffer (switch-to-buffer  scratch-buffer-name) 
        (when (functionp prev-major-mode) 
          (funcall prev-major-mode )) 
        (when (equal major-mode 'fundamental-mode ) 
          (emacs-lisp-mode)) 
        (goto-char (point-max))))))
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
("m" (ome-show-compilation "*Messages*") "*Messages*")
("w" (ome-show-compilation "*eww*") "*eww*")
;; ("t" (ome-show-compilation "*scratch*") "*scratch*")
("t" switch-to-scratch-buffer "*scratch*")
("c" (ome-show-compilation "*compilation*") "*compilation*")
("C" (ome-show-compilation "*Compile-Log*") "*scratch*")
("s" eshell "*eshell*")
("S" (shell "*shell*"))
("0" (calendar) "calendar")
("<tab>" (hydra-do-super/body) "BACK")
("q" nil "Quit")
("<escape>" nil "Quit"))
;; (global-set-key (kbd "C-c s") 'hydra-show-buffer/body)


;;; `hydra-open-module'
(defhydra hydra-open-config 
  (:color blue)
  "
^Basic^            ^Layout^         ^Editor^          ^Language^      ^Other^
^^^^^^^^-------------------------------------------------------------------------
_i_: init          _t_: tabbar      _o_: orgmode      _1_: elisp      _u_: input
_a_: basic         _h_: helm        _7_: latex        _2_: clojure    _m_: music
_p_: package       ^^               _8_: markdown     _3_: csharp     _d_: coding
_k_: keybind       ^^               _9_: reST         _4_: js         _s_: server
_l_: library       ^^               _z_: csv          _5_: cc         ^^
_y_: complete-yas  ^^               _x_: protobuf     _6_: elixir     _C_: compile-all-modules
^^^^^^^^-------------------------------------------------------------------------
_0_: calendar    _<escape>_: Quit   <tab>_: <-BACK           ^ ^             ^ ^
" ("i" (ome-open-mod "init") "init")
("a" (ome-open-mod "basic") "basic")
("p" (ome-open-mod "package") "package")
("k" (ome-open-mod "keybind") "keybind")
("l" (ome-open-mod "library") "library")
("y" (ome-open-mod "complete") "complete")

("t" (ome-open-mod "tabbar") "tabbar")
("h" (ome-open-mod "helm") "helm")
;;("3" (ome-open-mod "theme") "theme")
;;("4" (ome-open-mod "speedbar") "speedbar")
("T" (ome-open-file "~/emacs-config/themes/m-xemacs-theme.el") "theme")
("1" (ome-open-mod "elisp") "elisp")
("2" (ome-open-mod "clojure") "clojure")
("3" (ome-open-mod "csharp") "csharp")
("4" (ome-open-mod "javascript") "javascript")
("5" (ome-open-mod "rtags") "rtags")
("6" (ome-open-mod "elixir") "elixir")

;;("w" (ome-open-mod "web") "web")

("o" (ome-open-mod "orgmode") "orgmode")
("7" (ome-open-mod "latex") "latex")
("8" (ome-open-mod "markdown") "markdown")
("9" (ome-open-mod "rest") "reST")
("z" (ome-open-mod "csv") "csv")
("x" (ome-open-mod "protobuf") "protobuf")

("u" (ome-open-mod "input") "input")
("m" (ome-open-mod "music") "music")
("d" (ome-open-mod "coding") "coding")
("s" (ome-open-mod "server") "server")

("C" (compile-all-modules) "compile-all-modules")

("0" calendar)
("<tab>" (hydra-do-super/body) "BACK")
("q" nil "Quit")
("<escape>" nil "Quit"))
;; (global-set-key (kbd "C-c c") 'hydra-open-config/body)

(defun compile-all-modules() 
  (byte-recompile-directory (expand-file-name (concat (getenv "ROOT") "/emacs-config/modules")) 0))


;;; `hydra-open-url'
(defhydra hydra-open-url 
  (:color blue)
  "
^News^       ^Search^          ^Tut^                 ^Awesome^          ^site^
^^^^^^^^------------------------------------------------------------------------------
_1_: Bing    _5_: Weibo#Emacs# _x_: Xahlee           _a_: Awesomeness   _v_: Github
_2_: Baidu   _6_: Tuicool      _m_: Manual           _e_: Emacs         _9_: wego
_3_: Taobao  _7_: oschina      _k_: emacs-tutor      _y_: Clojure       _r_: Reddit
_4_: Amazon  _8_: GAME         _l_: MasteringEmacs   _c_: CommonLisp    _s_: StackOverflow
^^^^^^^^------------------------------------------------------------------------------
_<escape>_: Quit    _0_: calendar     _<tab>_: <-BACK          ^^ ^^
" ("1" (ome-open-url "http://cn.bing.com/") "Bing")
("2" (ome-open-url "https://www.baidu.com/") "Baidu")
("3" (ome-open-url "https://www.taobao.com/") "Taobao")
("4" (ome-open-url "http://www.amazon.cn/") "Amazon")
("5" (ome-open-url
      "http://weibo.com/p/100808169bafefac5c96e7ad8b1714ec46c585?k=Emacs&from=501&_from_=huati_topic") "WeiBo #Emacs#")
("6" (ome-open-url "http://www.tuicool.com/topics") "tuicool")
("7" (ome-open-url "http://www.oschina.net/news") "oschina")
("8" (ome-open-url "http://www.3dmgame.com/news/") "3dm-news")
("x" (ome-open-url "http://ergoemacs.org/emacs/elisp.html") "Xahlee Elisp")
("m" (ome-open-url
      "http://www.gnu.org/software/emacs/manual/html_node/elisp/index.html#SEC_Contents") "Manual")
("k" (ome-open-url "http://tuhdo.github.io/emacs-tutor.html") "emacs-tutor")
("l" (ome-open-url "https://masteringemacs.org/book") "MasteringEmacs")
("a" (ome-open-url "https://github.com/bayandin/awesome-awesomeness") "awesome-awesomeness")
("e" (ome-open-url "https://github.com/emacs-tw/awesome-emacs") "awesome-emacs")
("y" (ome-open-url "https://github.com/razum2um/awesome-clojure") "Clojure")
("c" (ome-open-url "https://github.com/CodyReichert/awesome-cl") "CommonLisp")
("v" (ome-open-url "https://github.com/") "github")
("9" (ome-open-url "http://wttr.in/") "wego")
("r" ome-open-reddit-channel "Reddit")
("s" ome-open-stackoverflow-channel "StackOverflow")
("0" (calendar) "calendar")
("<tab>" (hydra-do-super/body) "BACK")
("q" nil "Quit")
("<escape>" nil "Quit"))
;; (global-set-key (kbd "C-c w") 'hydra-open-url/body)


;;; `hydra-open-file'
(defhydra hydra-open-file 
  (:color blue)
  "
^Editor^        ^Export^                ^Blog^               ^Docs^             ^Config^
^^^^^^^^^^--------------------------------------------------------------------------------
_r_:rename      _p_: htmlize-buffer     _h_: README.org      _n_: note.org      _1_:env
_D_:delete      _P_: htmlize-file       _d_: diary.org       _p_: problem.org   _2_:lib
_k_:close-all   _C_: complie-modules    _t_: todo.org        _s_: passwd.org    _3_:.bashrc
_o_:kill-other  _i_: blog-index.org     _b_: book.org        _G_: game.org      _4_:.xbindkeysrc.scm
^^              ^^                      _N_: NEWS.org        _w_: write-blog    _._:.emacs
^^^^^^^^^^--------------------------------------------------------------------------------
_0_: calendar       _<escape>_: Quit   _<tab>_: <-BACK ^^^^
" ("r" ome-rename-file-and-buffer "rename-file-and-buffer")
("D" ome-delete-file-and-buffer "delete-file-and-buffer")
("k" ome-kill-all-buffers "kill-all-buffers")
("o" ome-kill-other-buffers "kill-other-buffers")
("p" htmlize-buffer "htmlize-buffer")
("P" htmlize-file "htmlize-file")
("C" (byte-recompile-directory "~/emacs-config") "byte-recomplie-directory")
("h" (ome-open-file "~/.oh-my-emacs/README.org") "README.org")
("i" (ome-open-blog "index.org") "index.org")
("g" (ome-open-doc "gtd.org") "GTD.org")
("d" (ome-open-doc "diary.org") "diary.org")
("t" (ome-open-doc "todo.org") "todo.org")
("b" (ome-open-doc "book.org") "book.org")
("n" (ome-open-doc "note.org") "note.org")
("p" (ome-open-doc "problem.org") "problem.org")
("s" (ome-open-doc "passwd.org") "passwd.org")
("G" (ome-open-doc "game.org") "game.org")
("w" ome-new-blog "write-blog")
("N" (ome-open-doc "news.org") "news.org")
("1" (ome-open-file "~/.oh-my-emacs/bin/env") "env")
("2" (ome-open-file "~/.oh-my-emacs/bin/lib") "lib")
("3" (ome-open-file "~/.bashrc") ".bashrc")
("4" (ome-open-file "~/.xbindkeysrc.scm") ".xbindkeysrc.scm")
("." (ome-open-file "~/.emacs") ".emacs")
("<tab>" helm-keyboard-quit "back" 
 :exit t)
("0" (calendar) "calendar")
("<tab>" (hydra-do-super/body) "BACK")
("q" nil "Quit")
("<escape>" nil "Quit"))
;; (global-set-key (kbd "C-c f") 'hydra-open-file/body)
;;


(defun major-do () 
  (let ((mod-name (symbol-name major-mode))) 
    (cond ((string= mod-name "clojure-mode") 123) 
          ((string= mod-name "emacs-lisp--mode") 456) 
          ((string= mod-name "sh-mode") 789))))

(defun ome-project-wizard(lang) 
  (cond ((string= lang "clojure") 
         (ome-create-project "lein new %s" "project.clj")) 
        ((string= lang "elixir") 
         (ome-create-project "mix new %s" "mix.exs")) 
        ((string= lang "haskell") 
         (ome-create-project "stack new %s" "src/Main.hs")) 
        ((string= lang "rust") 
         (ome-create-project "cargo new %s --bin" "Cargo.toml")) 
        ((string= lang "go") 
         (ome-create-project "glide create %s" "glide.yaml")) 
        ((string= lang "ros") 
         (ome-create-project "rosman %s " "src/main.cpp"))))


(defun ome-run-*project () 
  (let ((mod-name (symbol-name major-mode))) 
    (cond ((string= mod-name "clojure-mode") 
           (ome-run-command "lein run")) 
          ((string= mod-name "elixir-mode") 
           (ome-run-command "mix run")) 
          ((string= mod-name "haskell-mode") 
           (ome-run-command "stack exec Main")) 
          ((string= mod-name "rust-mode") 
           (ome-run-command "cargo run")) 
          ((string= mod-name "sh-mode") 
           (ome-run-command (concat "bash " (buffer-file-name)))) 
          ((string= mod-name "bat-mode") 
           (ome-run-command (concat "cmd.exe " (buffer-file-name)))) 
          ((string= mod-name "emacs-lisp-mode") 
           (message "hello,emacs")) )))

(defun ome-test-*project() 
  (let ((mod-name (symbol-name major-mode))) 
    (cond ((string= mod-name "clojure-mode") 
           (ome-run-command "lein test")) 
          ((string= mod-name "elixir-mode") 
           (ome-run-command "mix test")) 
          ((string= mod-name "haskell-mode") 
           (ome-run-command "stack test")) 
          ((string= mod-name "rust-mode") 
           (ome-run-command "cargo test")) 
          ((string= mod-name "emacs-lisp-mode") 
           (compile-current-buffer)))))

(defun ome-build-*project() 
  (let ((mod-name (symbol-name major-mode))) 
    (cond ((string= mod-name "clojure-mode") 
           (ome-run-command "lein compile")) 
          ((string= mod-name "elixir-mode") 
           (ome-run-command "mix compile")) 
          ((string= mod-name "haskell-mode") 
           (ome-run-command "stack build")) 
          ((string= mod-name "rust-mode") 
           (ome-run-command "cargo build")) 
          ((string= mod-name "emacs-lisp-mode") 
           (compile-current-buffer)))))

(defun get-major-mode-name () 
  (message (symbol-name major-mode)) 
  (symbol-name major-mode))

(setq current-major-mode-name (symbol-name major-mode))

(defun get-super-menu-string() 
  (concat
   "^SPC^            ^Buffer^               ^Search^              ^UI|View^        ^AppWizard^^   "
   (get-major-mode-name)
   "
^^^^^^^^^^^^^^^-----------------------------------------------------------------------------------------------------------
_`_: Email       _>_: goto-char-f       _G_: grep-project     _;_: <-Tab       _6_: Clojure   _1_:run   ^^
_b_: Buffer=>    _<_: goto-char-b       _g_: grep-directory   _'_: Tab->       _7_: Elixir    ^^ test   ^^
_f_: File  =>    _p_: publish-blog      _d_: bing-dict        _[_: <-Group     _8_: Rust      ^^ build  ^^
_m_: Module=>    _w_: write-blog        _D_: bing-dict-web    _/_: Group->     _9_: Ros       ^^ clean  ^^
_u_: URLs  =>    _e_: mc/mark-all       _>_: goto-char-f      _=_: scale-inc   ^^Python       ^^        ^^
_l_: Bookmarks   _r_: Reload|Refresh    _<_: goto-char-b      _-_: scale-dec   ^^Erlang       ^^        ^^
_<tab>_: recent  _o_: kill-other-buffer _s_: replace-string   _z_: smart-do    ^^Kotlin       ^^        ^^
^^^^^^^^^^^^^^-----------------------------------------------------------------------------------------------------------
_<escape>_: Quit _0_: Calendar          _!_:Weater            ^^               ^^             ^^        ^^"))

(defhydra hydra-do-super 
  (:color blue) 
  (concat "" (get-super-menu-string)) 
  ("`" (mu4e) "Email")
  ;; ("`" mu4e~headers-jump-to-maildir "Email")
  ("b" (hydra-show-buffer/body) "buffer") 
  ("f" (hydra-open-file/body) "file") 
  ("m" (hydra-open-config/body) "module") 
  ("c" (hydra-open-config/body) "module") 
  ("u" (hydra-open-url/body) "url") 
  ("l" helm-bookmarks "bookmarks") 
  ("<tab>" helm-recentf "(helm-recentf)")
  ;;("w" ome-copy-line "copy-line")
  ("w" ome-new-blog "write-blog") 
  (">" ome-go-to-char-forward "go-to-char-forward") 
  ("<" ome-go-to-char-backward "go-to-char-backward") 
  ("s" replace-string "replace-string") 
  ("S" query-replace "query-replace") 
  ("e" (ome-mark-all-like-this) "mc/mark-all-like-this") 
  ("r" (ome-buffer-reload) "Refresh") 
  ("o" (ome-kill-other-buffers) "KillOtherBuffers") 
  ("p" (org-publish-project "blog") "publish-blog") 
  ("G" projectile-ripgrep "projectile-project-root") 
  ("g" ome-grep-directory "projectile-directory-root") 
  ("d" bing-dict-brief "bing-dict-brief") 
  ("D" ome-bing-dict-brief-web "bing-dict-brief-web") 
  (";" tabbar-backward "tabbar-backward") 
  ("'" tabbar-forward "tabbar-forward") 
  ("[" ome-tabbar-backward-group "tabbar-up") 
  ("/" ome-tabbar-forward-group "tabbar-down") 
  ("=" text-scale-increase "text-scale-increase") 
  ("-" text-scale-decrease "text-scale-decrease") 
  ("1" (ome-run-*project) "run project") 
  ("2" (message "smart-do")) 
  ("3" (message "smart-do")) 
  ("4" (message "smart-do")) 
  ("5" (message "smart-do")) 
  ("6" (ome-project-wizard "clojure") "smart-do") 
  ("7" (ome-project-wizard "elixir") "smart-do") 
  ("8" (ome-project-wizard "rust") "smart-do") 
  ("9" (ome-project-wizard "ros") "smart-do") 
  ("z" (message "smart-do")) 
  ("0" (calendar) "calendar") 
  ("!" (ome-open-url "http://wttr.in/") "wego") 
  ("<SPC>" nil "quit") 
  ("q" nil "quit") 
  ("<escape>" nil "quit"))

(defun show-super-menu () 
  "docstring" 
  (interactive) 
  (load "mod-keybind.el") 
  (hydra-do-super/body))


(defhydra hydra-view-menu 
  (:color pink)
  "View" ;;
  ("t" tool-bar-mode "Toolbar") 
  ("m" menu-bar-mode "Menubar") 
  ("s" projectile-speedbar-toggle "Speedbar") 
  ("d" (dired-sidebar-toggle-sidebar nil) "DiredSideBar") 
  (";" tabbar-backward "tabbar-backward") 
  ("'" tabbar-forward "tabbar-forward") 
  ("[" ome-tabbar-backward-group "tabbar-up") 
  ("/" ome-tabbar-forward-group "tabbar-down") 
  ("=" text-scale-increase "text-scale-increase") 
  ("-" text-scale-decrease "text-scale-decrease") 
  ("q" nil "quit") 
  ("<SPC>" nil "quit") 
  ("<escape>" nil "quit"))

(defhydra hydra-new-menu 
  (:color blue)
  "New" ;;
  ("e" mu4e-compose-new "Email") 
  ("m" menu-bar-mode "Menubar") 
  ("s" speedbar-mode "Speedbar") 
  ("d" dired-sidebar "DiredSideBar") 
  ("q" nil "quit") 
  ("<SPC>" nil "quit") 
  ("<escape>" nil "quit"))


(defhydra hydra-super-menu 
  (:color blue 
          :hint nil) 
  (concat                               ;
   "^Main^            ^Search^               ^View^              ^Magic^\n"
   "^^^^^^^^--------------------------------------------------------------------\n"
   "_n_:New           _>_:gochar-forward     _t_:Toolbar    ^^\n"
   "_o_:Open          _<_:gochar-backward    _m_:Menubar    ^^\n"
   "_b_:Bookmarks     _g_:grep-dir           _s_:Speedbar   ^^\n"
   "_e_:Email         _G_:grep-proj          _S_:Sidebar    ^^\n"
   "_f_:Feed          _d_:dict-bing          _=_:Scale+     ^^\n"
   "_c_:Config        _D_:dict-bing-web      _-_:Scale-     ^^\n" "^^^^^^^^")
  ;; Main
  ("n" (hydra-new-menu/body) "New") 
  ("o" (hydra-open-file/body) "Open") 
  ("b" helm-bookmarks "Bookmarks") 
  ("e" mu4e "Email") 
  ("f" elfeed "Feed") 
  ("c" (hydra-open-config/body) "Config")

  ;; Search
  (">" ome-go-to-char-forward "go-to-char-forward") 
  ("<" ome-go-to-char-backward "go-to-char-backward") 
  ("G" projectile-ripgrep "projectile-project-root") 
  ("g" ome-grep-directory "projectile-directory-root") 
  ("d" bing-dict-brief "bing-dict-brief") 
  ("D" ome-bing-dict-brief-web "bing-dict-brief-web")

  ;; Nav
  (";" tabbar-backward "tabbar-backward" 
   :color pink) 
  ("'" tabbar-forward "tabbar-forward" 
   :color pink) 
  ("[" ome-tabbar-backward-group "tabbar-up" 
   :color pink) 
  ("/" ome-tabbar-forward-group "tabbar-down" 
   :color pink) 
  ("<tab>" helm-recentf "(helm-recentf)")

  ;; View
  ("t" tool-bar-mode "Toolbar" 
   :color pink) 
  ("m" menu-bar-mode "Menubar" 
   :color pink) 
  ("s" projectile-speedbar-toggle "Speedbar" 
   :color pink) 
  ("S" (dired-sidebar-toggle-sidebar nil) "DiredSideBar" 
   :color pink) 
  ("=" text-scale-increase "text-scale-increase" 
   :color pink) 
  ("-" text-scale-decrease "text-scale-decrease" 
   :color pink)

  ;; Other
  ("`" (calendar) "calendar") 
  ("w" (ome-open-url "http://wttr.in/") "wego") 
  ("q" nil "quit") 
  ("<SPC>" nil "quit") 
  ("<escape>" nil "quit"))

(global-set-key (kbd "C-M-z") 'show-super-menu)
(global-set-key (kbd "M-z") 'hydra-super-menu/body)

;;; `comment-toggle' M-;
(global-set-key [remap comment-dwim] 'ome-comment-or-uncomment-region-or-line)

;; (package-require 'smart-comment)
;; (require 'smart-comment)
;; (global-set-key (kbd "M-;") 'smart-comment)
;; (global-set-key (kbd "C-u M-;") 'smart-comment)
;; (global-set-key (kbd "C-u C-u M-;") 'smart-comment)


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


;;; `which-key'
(package-require 'which-key)
(require 'which-key)
(which-key-mode)

;;; `paredit'
(package-require 'paredit)
(require 'paredit)

(define-key paredit-mode-map (kbd "C-<left>") 'paredit-backward-slurp-sexp)
(define-key paredit-mode-map (kbd "C-<right>") 'paredit-forward-slurp-sexp)
(define-key paredit-mode-map (kbd "C-M-<left>") 'paredit-backward-barf-sexp)
(define-key paredit-mode-map (kbd "C-M-<right>") 'paredit-forward-barf-sexp)
;;; enable paredit for *
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'emacs-mode-hook            #'enable-paredit-mode)
(add-hook 'inferior-emacs-mode-hook   #'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'common-lisp-mode-hook      #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
(add-hook 'hy-mode-hook               #'enable-paredit-mode)
(add-hook 'newlisp-mode-hook          #'enable-paredit-mode)
(add-hook 'hy-mode-hook               #'enable-paredit-mode)
;;


;;
;; (use-package smartparens-config
;; :ensure smartparens
;; :config
;; (progn
;; (show-smartparens-global-mode t)))

;; (add-hook 'prog-mode-hook 'turn-on-smartparens-strict-mode)
;; (add-hook 'markdown-mode-hook 'turn-on-smartparens-strict-mode)

;; (defmacro def-pairs (pairs)
;; `(progn
;; ,@(loop for (key . val) in pairs
;; collect
;; `(defun ,(read (concat
;; "wrap-with-"
;; (prin1-to-string key)
;; "s"))
;; (&optional arg)
;; (interactive "p")
;; (sp-wrap-with-pair ,val)))))

;; (def-pairs ((paren . "(")
;; (bracket . "[")
;; (brace . "{")
;; (single-quote . "'")
;; (double-quote . "\"")
;; (back-quote . "`")))

;;


;;
;; `comment-toggle' M-;
(define-key paredit-mode-map (kbd "M-;") 'ome-comment-or-uncomment-region-or-line)

(package-require 'helpful)
(require 'helpful)
(global-set-key (kbd "C-h f") #'helpful-callable)
(global-set-key (kbd "C-h v") #'helpful-variable)
(global-set-key (kbd "C-h k") #'helpful-key)
(global-set-key (kbd "C-c C-d") #'helpful-at-point)

(package-require 'xkcd)
(require 'xkcd)


;; (package-require 'weechat)
;; (require 'weechat)


;;
(provide 'mod-keybind)
;; mod-keybind.el ends here
