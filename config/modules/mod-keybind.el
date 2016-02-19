(require 'mod-package)

;;Mac osx: set command to meta
;;; I prefer cmd key for meta
;;(setq mac-option-key-is-meta nil
;;	mac-command-key-is-meta t
;;	mac-command-modifier 'meta
;;	mac-option-modifier 'none)

(global-set-key (kbd "C-\\") 'toggle-input-method)
(global-set-key "\C-z" 'set-mark-command) ;;C-Space C-@ C-z S-space ;; (global-set-key [?\S- ] 'set-mark-command)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; expand region
(package-require 'expand-region)
(require 'expand-region)
(global-set-key (kbd "M-z") 'er/expand-region) ;; (global-set-key "\M-z" 'mark-word)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-M-d") 'delete-backward-char)
(global-set-key (kbd "C-x C-c") 'medusa-exit) ;;[(control x) (control c)]

(global-set-key (kbd "C-=") 'enlarge-window)
(global-set-key (kbd "C--") 'shrink-window)

;; minibuffer (press mouse left, show: shrink-compile-window
(define-key minibuffer-local-map [double-mouse-1] 'shrink-compile-window)


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
;; (global-set-key (kbd "C-c C-d") 'bing-dict-brief-web)
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
(global-set-key (kbd "C-c <") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c >") 'mc/mark-all-like-this)
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
(global-set-key (kbd "C-x M-k") 'kill-all-buffers)
;; (global-set-key (kbd "C-x M-k") 'kill-other-buffers)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; hydra
(package-require 'hydra)
(require 'hydra)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; `C-SPC' function couter: bm hydra edit-select

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `Action'
;;; swiper d:bing-dict  f:forward b:backward

(defhydra hydra-do-action 
  (:color blue 
	  :hint nil)
  "
^Search^               ^Buffer-and-File^    ^Dict^           ^Export^
^^^^^^^^-----------------------------------------------------------------
_f_: goto-char-f       _r_: rename          _b_: bing        _p_: htmlize-buffer
_b_: goto-char-b       _x_: delete          _w_: bing-web    _P_: htmlize-file
_1_: replace-string    _>_: scale-inc  ^^^^
_2_: query-replace     _<_: scale-dec  ^^^^
^^^^^^^^-----------------------------------------------------------------
_q_: quit              _d_: calendar   ^^ ^^
"
("f" go-to-char-forward "go-to-char-forward")
("b" go-to-char-backward "go-to-char-backward")

("1" replace-string "replace-string")
("2" query-replace "query-replace")

("r" rename-file-and-buffer "rename-file-and-buffer")
("x" delete-file-and-buffer "delete-file-and-buffer")
(">" text-scale-increase "text-scale-increase")
("<" text-scale-decrease "text-scale-decrease")

("b" bing-dict "bing-dict-brief")
("w" bing-dict-web "bing-dict-brief-web")

("p" htmlize-buffer "htmlize-buffer")
("P" htmlize-file "htmlize-file")

("d" (calendar) "calendar")
("q" nil "quit"))
;; (global-set-key (kbd "C-c a") 'hydra-do-action/body)
;; (global-set-key (kbd "C-SPC") 'hydra-do-action/body)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `tty'
;; (defhydra hydra-show-tty

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `buffer'
(defhydra hydra-show-buffer
  (:color blue)
"hydra-show-buffer"
("m" (m-show-buffer "*Messages*") "*Messages*")
("w" (m-show-buffer "*eww*") "*eww*")
("t" (m-show-buffer "*scratch*") "*scratch*")
("c" (m-show-buffer "*compilation*") "*compilation*")
("l" (m-show-buffer "*Compile-Log*") "*scratch*")
("s" eshell "*eshell*")
("S" (shell "*shell*"))

("d" (calendar) "calendar")
("q" nil "quit"))
;; (global-set-key (kbd "C-c s") 'hydra-show-buffer/body)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `hydra-open-file'
(defhydra hydra-open-file
  (:color blue)
"
^README^            ^GTD^           ^Blog^              ^Editor^
^^^^^^^^-----------------------------------------------------------------
_h_: README.org     _g_: GTD.org         ^^^^
^^                  _t_: todo.org        ^^^^
^^^^       ^^^^
^^^^^^^^-----------------------------------------------------------------
_d_: calendar       _q_: quit              ^^^^"

("h" (m-open-file "~/../README.org") "README.org")
("g" (m-open-doc "GTD.org") "GTD.org")
("t" (m-open-doc "todo.org") "todo.org")

("d" (calendar) "calendar")
("q" nil "quit"))
;; (global-set-key (kbd "C-c f") 'hydra-open-file/body)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `hydra-open-module'
(defhydra hydra-open-config 
  (:color blue)
  "
^Basic^            ^Layout^         ^Editor^          ^Language^      ^Other^
^^^^^^^^-------------------------------------------------------------------------
_i_: init          _1_: tabbar      _6_: orgmode      _e_: elisp      _z_: chinese-py
_b_: basic         _2_: helm        _7_: latex        _j_: clojure    _m_: music 
_p_: package       _3_: theme       _8_: markdown     _e_: cc         _d_: coding
_k_: keybind       _4_: speedbar    _9_: reST         _w_: web        _s_: server
_l_: library       _5_: nil         _z_: csv          _c_: csharp     ^^
_a_: ac(complete)  ^^               _x_: protobuf     ^^              ^^
^^                 ^^               ^^                ^^              ^^
^^^^^^^^-------------------------------------------------------------------------
_d_: calendar    _q_: quit      ^ ^             ^ ^
"
  ("i" (m-open-file "~/../config/init.el") "Bing")
  ("b" (m-open-mod "basic") "basic")
  ("p" (m-open-mod "package") "package")
  ("k" (m-open-mod "keybind") "keybind")
  ("l" (m-open-mod "library") "library")
  ("a" (m-open-mod "complete") "complete")
  
  ("1" (m-open-mod "tabbar") "tabbar")
  ("2" (m-open-mod "helm") "helm")
  ("3" (m-open-mod "theme") "theme")
  ("4" (m-open-mod "speedbar") "speedbar")
  ("5" nil)
  
  
  ("6" (m-open-mod "orgmode") "orgmode")
  ("7" (m-open-mod "latex") "latex")
  ("8" (m-open-mod "markdown") "markdown")
  ("9" (m-open-mod "rest") "reST")
  
  ("z" (m-open-mod "csv") "csv")
  ("x" (m-open-mod "protobuf") "protobuf")

  ("z" (m-open-mod "chinese-py") "chinese-py")
  ("m" (m-open-mod "music") "music")
  ("d" (m-open-mod "coding") "coding")
  ("s" (m-open-mod "server") "server")

  ("e" (m-open-mod "elisp") "elisp")
  ("j" (m-open-mod "clojure") "clojure")
  ("c" (m-open-mod "cc") "cc")
  ("w" (m-open-mod "web") "web")
  ("c" (m-open-mod "csharp") "csharp")

  ("d" calendar)
  ("q" nil "quit"))
;; (global-set-key (kbd "C-c c") 'hydra-open-config/body)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; `hydra-open-url'
(defhydra hydra-open-url 
  (:color blue)
  "
^News^       ^Search^          ^Tut^                 ^Awesome^          ^site^
^^^^^^^^------------------------------------------------------------------------------
_1_: Bing    _5_: Weibo#Emacs# _x_: Xahlee           _a_: Awesomeness   _v_: Github
_2_: Baidu   _6_: Tuicool      _j_: gad.qq           _e_: Emacs         _9_: wego
_3_: Taobao  _7_: oschina      _k_: emacs-tutor      _y_: Clojure        ^ ^
_4_: Amazon  _8_: GAME         _l_: MasteringEmacs   _c_: CommonLisp     ^ ^
^^^^^^^^------------------------------------------------------------------------------
_d_: calendar       _q_: quit              ^^^^^^
"
  ("1" (m-open-url "http://cn.bing.com/") "Bing")
  ("2" (m-open-url "https://www.baidu.com/") "Baidu")
  ("3" (m-open-url "https://www.taobao.com/") "Taobao")
  ("4" (m-open-url "http://www.amazon.cn/") "Amazon")
  
  ("5" (m-open-url "http://weibo.com/p/100808169bafefac5c96e7ad8b1714ec46c585?k=Emacs&from=501&_from_=huati_topic") "WeiBo #Emacs#")
  ("6" (m-open-url "http://www.tuicool.com/topics") "tuicool")
  ("7" (m-open-url "http://www.oschina.net/news") "oschina")
  ("8" (m-open-url "http://www.3dmgame.com/news/") "3dm-news")
  
  ("x" (m-open-url "http://ergoemacs.org/emacs/elisp.html") "Xahlee Elisp")
  ("j" (m-open-url "http://gad.qq.com/") "gad-qq")
  ("k" (m-open-url "http://tuhdo.github.io/emacs-tutor.html") "emacs-tutor")
  ("l" (m-open-url "https://masteringemacs.org/book") "MasteringEmacs")

  ("a" (m-open-url "https://github.com/bayandin/awesome-awesomeness") "awesome-awesomeness")
  ("e" (m-open-url "https://github.com/emacs-tw/awesome-emacs") "awesome-emacs")
  ("y" (m-open-url "https://github.com/razum2um/awesome-clojure") "Clojure")
  ("c" (m-open-url "https://github.com/CodyReichert/awesome-cl") "CommonLisp")

  ("v" (m-open-url "https://github.com/") "github")
  ("9" (m-open-url "http://wttr.in/") "wego")
  ("d" (calendar) "calendar")
  ("q" nil "quit"))
;; (global-set-key (kbd "C-c w") 'hydra-open-url/body)

(defhydra hydra-do-space (:color blue)
  "hydra-do-esc"
  
("a" (hydra-do-action/body) "action")
("s" (hydra-show-buffer/body) "buffer")
("f" (hydra-open-file/body) "file")
("c" (hydra-open-config/body) "config")
("w" (hydra-open-url/body) "url")

(">" text-scale-increase "text-scale-increase")
("<" text-scale-decrease "text-scale-decrease")

("d" (calendar) "calendar")
("q" nil "quit"))
(global-set-key (kbd "C-SPC") 'hydra-do-space/body)

;; (defhydra hydra-zoom (global-map "C-c w")
;;   "zoom"
;;   ("g" text-scale-increase "in")
;;   ("l" text-scale-decrease "out"))

;; (defhydra hydra-zoom (global-map "ESC")
;;   "Press _g_ to zoom in."
;;   ("g" text-scale-increase "in" :color blue)
;;   ("l" text-scale-decrease "out" :color red))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;M-;
(global-set-key [remap comment-dwim] 'comment-or-uncomment-region-or-line)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(package-require 'guide-key)
(require 'guide-key)
(guide-key-mode 1)			; Enable guide-key-mode
(setq guide-key/idle-delay 0.7)
(setq guide-key/guide-key-sequence '("C-h" "C-c" "C-x" "C-t" "ESC"))
;;(setq guide-key/guide-key-sequence t)
(setq guide-key/recursive-key-sequence-flag t)
(setq guide-key/popup-window-position 'bottom)
(setq guide-key/text-scale-amount 1)
;;; `guide-key-tip'
;; (package-require 'guide-key-tip)
;; (require 'guide-key-tip)
;; (setq guide-key-tip/enabled nil)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
(provide 'mod-keybind)
