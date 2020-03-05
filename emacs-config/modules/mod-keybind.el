;; -*- lexical-binding: t -*-
;; mod-basic.el --- This is where you apply your OCD.
;;
;; Author: damon-kwok <damon-kwok@outlook.com>
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
(global-set-key (kbd "C-a") 'mwim-beginning)
(global-set-key (kbd "C-e") 'mwim-end)

;;
(package-require 'ripgrep)
;; (define-key helm-map (kbd "<tab>")  'helm-execute-persistent-action)
(define-key ripgrep-search-mode-map (kbd "<tab>") 'compilation-next-error)
(define-key ripgrep-search-mode-map (kbd "<backtab>") 'compilation-previous-error)
(define-key compilation-mode-map (kbd "n") 'compilation-next-error)
(define-key compilation-mode-map (kbd "p") 'compilation-previous-error)
;;

(package-require 'wand)
(setq wand:*rules*
      (list (wand:create-rule :match "\\$ "
                              :capture :after
                              :action #'popup-shell-command)
            (wand:create-rule :match "https?://"
                              :capture :whole
                              :action #'eww) ;;open-url-in-firefox
            (wand:create-rule :match "file:"
                              :capture :after
                              :action #'find-file)
            (wand:create-rule :match "#> "
                              :capture :after
                              :action #'(lambda (string)
                                          (eval (read string))))))

(global-set-key (kbd "<C-return>")       'wand:execute)
(global-set-key (kbd "<C-mouse-1>")      'wand:execute)
(global-set-key (kbd "<C-down-mouse-1>")  nil)


;; (global-set-key (kbd "<C-return>")       'wand:execute)
;; (global-set-key (kbd "<C-mouse-1>")      'wand:execute)
;; (global-set-key (kbd "<C-down-mouse-1>")  nil)
;;-(wand:add-rule-by-pattern :match "\\$ "
;;-                          :capture 

;;-                          :after 
;;-                          :action popup-shell-command)
;;-(wand:add-rule-by-pattern :match "https?://"
;;-                          :capture 
;;-
;;-                          :whole 
;;-                          :action browse-url)
;;-(wand:add-rule-by-pattern :match "file:"
;;-                          :capture 
;;-
;;-                          :after 
;;-                          :action find-file)
;;-(wand:add-rule-by-pattern :match "#> "
;;-                          :capture 
;;-
;;-                          :after 
;;-                          :action add-bracket-and-eval)

;; `folding'
;; (package-require 'vimish-fold)
;; (vimish-fold-global-mode 1)

(package-require 'yafolding)

(global-set-key (kbd "C-M-`") 'yafolding-toggle-all)
(global-set-key (kbd "C-~") 'yafolding-hide-parent-element)
(global-set-key (kbd "C-`") 'yafolding-toggle-element)

;; `anzu' https://github.com/syohex/emacs-anzu
(package-require 'anzu)
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
;;; After that, you can move the line(s) up by M-p or down by M-n.
;;; (move-text-default-bindings)

(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)
;; (global-set-key (kbd "M-<up>") 'move-text-up)
;; (global-set-key (kbd "M-<down>") 'move-text-down)


;;; `buffer-move'
(package-require 'buffer-move)
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
(global-set-key (kbd "C-x o") 'switch-window)

;; `window-numbering'
(package-require 'window-numbering)
(window-numbering-mode)
(setq window-numbering-assign-func (lambda () 
                                     (when (equal (buffer-name) "*Calculator*") 9)))


;; `page-break-lines'
(package-require 'page-break-lines)
(global-page-break-lines-mode)

;;; Swiper
;; (package-require 'swiper)

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
;; (global-set-key (kbd "C-c p") 'htmlize-buffer)
;; (global-set-key (kbd "C-c C-p") 'htmlize-file)


;;; bing-dict
(package-require 'bing-dict)
(setq bing-dict-show-thesaurus 'both)
(setq bing-dict-pronunciation-style 'us) ;;us | uk
(setq bing-dict-save-search-result t)
(setq bing-dict-org-file (concat (getenv "HOME") "/workspace/org/english/vocabulary.org"))
;; (global-set-key (kbd "C-c d") 'ome-bing-dict-brief)
;; (global-set-key (kbd "C-c D") 'ome-bing-dict-brief-web)


(define-key global-map (kbd "C-c f") 'ome-go-to-char-forward)
(define-key global-map (kbd "C-c b") 'ome-go-to-char-backward)

(package-require 'multiple-cursors)
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

;;; `comment-toggle' M-;
(global-set-key [remap comment-dwim] 'ome-comment-or-uncomment-region-or-line)

;; (package-require 'smart-comment)
;; (global-set-key (kbd "M-;") 'smart-comment)
;; (global-set-key (kbd "C-u M-;") 'smart-comment)
;; (global-set-key (kbd "C-u C-u M-;") 'smart-comment)


;;; `guide-key'
;; (package-require 'guide-key)
;; (guide-key-mode 1)			; Enable guide-key-mode
;; (setq guide-key/idle-delay 0.7)
;; (setq guide-key/guide-key-sequence '("C-h" "C-c" "C-x" "C-t" "ESC"))
;; ;;(setq guide-key/guide-key-sequence t)
;; (setq guide-key/recursive-key-sequence-flag t)
;; (setq guide-key/popup-window-position 'bottom)
;; (setq guide-key/text-scale-amount 1)

;;; `guide-key-tip'
;; (package-require 'guide-key-tip)
;; (setq guide-key-tip/enabled nil)


;;; `which-key'
(package-require 'which-key)
(which-key-mode)

;;; `paredit'
(package-require 'paredit)
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
(global-set-key (kbd "C-h f") #'helpful-callable)
(global-set-key (kbd "C-h v") #'helpful-variable)
(global-set-key (kbd "C-h k") #'helpful-key)
(global-set-key (kbd "C-c C-d") #'helpful-at-point)

(package-require 'xkcd)


;; (package-require 'weechat)


;;; `hydra'
(package-require 'hydra)

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
_\\_: calendar    _<escape>_: Quit   <tab>_: <-BACK
" ("l" (helm-buffers-list) "buffers-list")
("m" (ome-show-compilation "*Messages*") "*Messages*")
("w" (ome-show-compilation "*eww*") "*eww*")
;; ("t" (ome-show-compilation "*scratch*") "*scratch*")
("t" switch-to-scratch-buffer "*scratch*")
("c" (ome-show-compilation "*compilation*") "*compilation*")
("C" (ome-show-compilation "*Compile-Log*") "*scratch*")
("s" eshell "*eshell*")
("S" (shell "*shell*"))

("\\" (calendar) "calendar")
("<tab>" (hydra-super-menu/body) "BACK")
("q" nil "Quit")
("<escape>" nil "Quit"))
;; (global-set-key (kbd "C-c s") 'hydra-show-buffer/body)



(defun compile-all-modules() 
  (byte-recompile-directory (expand-file-name (concat (getenv "ROOT") "/emacs-config/modules")) 0))


;;; `hydra-url-menu'
(defhydra hydra-url-menu 
  (:color blue)
  "
^News^       ^Search^          ^Tut^                 ^Awesome^          ^site^
^^^^^^^^------------------------------------------------------------------------------
_1_: Bing    _5_: Weibo#Emacs# _x_: Xahlee           _a_: Awesomeness   _v_: Github
_2_: Baidu   _6_: Tuicool      _m_: Manual           _e_: Emacs         _9_: wego
_3_: Taobao  _7_: oschina      _k_: emacs-tutor      _y_: Clojure       _r_: Reddit
_4_: Amazon  _8_: GAME         _l_: MasteringEmacs   _c_: CommonLisp    _s_: StackOverflow
^^^^^^^^------------------------------------------------------------------------------
_<escape>_: Quit    _\\_: calendar     _<tab>_: <-BACK          ^^ ^^
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
("\\" (calendar) "calendar")
("<tab>" (hydra-super-menu/body) "BACK")
("q" nil "Quit")
("<escape>" nil "Quit"))
;; (global-set-key (kbd "C-c w") 'hydra-url-menu/body)

;;; `hydra-open-module'
(defhydra hydra-config-menu 
  (:color blue)
  "
^Basic^            ^Layout^         ^Editor^          ^Language^      ^Other^
^^^^^^^^-------------------------------------------------------------------------
_i_: init          _t_: tabbar      _o_: orgmode      _1_: elisp      _u_: input
_a_: basic         _h_: helm        _7_: latex        _2_: clojure    _m_: music
_p_: package       _e_: email       _8_: markdown     _3_: csharp     _d_: coding
_k_: keybind       ^^               _9_: reST         _4_: js         _s_: server
_l_: library       ^^               _z_: csv          _5_: cc         _g_: golang
_y_: complete-yas  ^^               _x_: protobuf     _6_: elixir     _C_: compile-all-modules
^^^^^^^^-------------------------------------------------------------------------
_\\_: calendar    _<escape>_: Quit   <tab>_: <-BACK           ^ ^             ^ ^
" ("i" (ome-open-mod "init") "init")
("a" (ome-open-mod "basic") "basic")
("p" (ome-open-mod "package") "package")
("k" (ome-open-mod "keybind") "keybind")
("l" (ome-open-mod "library") "library")
("y" (ome-open-mod "complete") "complete")

("t" (ome-open-mod "tabbar") "tabbar")
("h" (ome-open-mod "helm") "helm")
("e" (ome-open-mod "email") "email")
;;("3" (ome-open-mod "theme") "theme")
;;("4" (ome-open-mod "speedbar") "speedbar")
("T" (ome-open-file "~/emacs-config/themes/m-xemacs-theme.el") "theme")
("1" (ome-open-mod "elisp") "elisp")
("2" (ome-open-mod "clojure") "clojure")
("3" (ome-open-mod "csharp") "csharp")
("4" (ome-open-mod "js") "javascript")
("5" (ome-open-mod "cc") "cc")
("M-5" (ome-open-mod "cquery") "cquery")
("C-5" (ome-open-mod "rtags") "rtags")
("6" (ome-open-mod "elixir") "elixir")
("g" (ome-open-mod "go") "golang")

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

("\\" calendar)
("<tab>" (hydra-super-menu/body) "BACK")
("q" nil "Quit")
("<escape>" nil "Quit"))
;; (global-set-key (kbd "C-c c") 'hydra-open-config/body)
;;
(defhydra hydra-open-menu 
  (:color blue)
  "
^Project^         ^Doc^          ^Blog^            ^dotfiles^      ^dotfiles^        ^English^
^^^^^^^^^^^^-----------------------------------------------------------------------------------------------
_M-1_:libknife    _h_:README.org  _i_: index.org    _1_:ome        _._:.bashrc        _C-b_: english-b.org
_M-2_:memrock     _d_:diary.org   _b_: blog.org     _2_:env        _0_:.emacs         _C-2_: PETS2.org
_M-3_:pkg-manager _t_:todo.org    _l_: link.org     _3_:lib        _9_:.editorconfig  _C-3_: PETS3.org
_M-4_:network     _b_:book.org    ^^                _4_:tool       ^^                 _C-4_: CET4.org
_M-5_:webscrap    _g_:game.org    ^^                _5_:proj       ^^                 _C-6_: CET6.org
_M-6_:medusa      _n_:NEWS.org    ^^                _6_:appwizard  ^^                 _e_:english.org
^^                _m_:me.org      ^^                _7_:git-hook    ^^                _v_:vocabulary.org
^^^^^^^^^^^^-----------------------------------------------------------------------------------------------
_\\_: calendar       _<escape>_: Quit   _<tab>_: <-BACK ^^^^
" ;;

  ;; Project
  ("M-1" (ome-open-file "~/projects/me/libknife/include/knife.h") "libknife")
  ("M-2" (ome-open-file "~/projects/me/memrock/cpp/src/memrock.hpp") "libknife")
  ("M-3" (ome-open-file "~/projects/me/awesome-package-manager/README.org") "pacman") 
  ("M-4" (ome-open-file "~/projects/me/awesome-network-programming/README.org") "network") 
  ("M-5" (ome-open-file "~/projects/me/awesome-web-scraping/README.org") "web-scrap")
  ("M-6" (ome-open-file "~/projects/me/medusa/medusa-cpp/Core/Core.h") "medusa") 

  ;; Doc
  ("h" (ome-open-file "~/.oh-my-emacs/README.org") "README.org") 
  ("d" (ome-open-org-by-month "diary") "diary.org")
  ("t" (ome-open-doc "todo.org") "todo.org") 
  ("b" (ome-open-doc "book.org") "book.org") 
  ("g" (ome-open-doc "game.org") "game.org") 
  ("n" (ome-open-doc "news.org") "news.org")
  ("m" (ome-open-doc "me.org") "me.org")

  ;; Blog
  ("i" (ome-open-blog "index.org") "index.org") 
  ("b" (ome-open-blog "blog.org") "blog.org") 
  ("l" (ome-open-blog "link.org") "link.org")

  ;; dotfiles
  ("1" (ome-open-file "~/.oh-my-env/bin/ome") "ome")
  ("2" (ome-open-file "~/.oh-my-env/env") "env") 
  ("3" (ome-open-file "~/.oh-my-env/bin/lib") "lib") 
  ("4" (ome-open-file "~/.oh-my-env/bin/tool") "tool") 
  ("5" (ome-open-file "~/.oh-my-env/bin/proj") "proj")
  ("6" (ome-open-file "~/.oh-my-env/bin/app_wizard") "app_wizard")
  ("7" (ome-open-file "~/.oh-my-env/bin/git-hook") "git-hook")
  ("." (ome-open-file "~/.bashrc") ".bashrc")
  ("0" (ome-open-file "~/.emacs") ".emacs")
  ("9" (ome-open-file "~/.oh-my-env/conf/project/.editorconfig") "editorconfig")
  ("f" (ome-open-file "~/workspace/elfeed.org") "elfeed")

  ;; English
  ("e" (ome-open-doc "english/english.org") "english")
  ("v" (ome-open-doc "english/vocabulary.org") "english")
  ("C-b" (ome-open-doc "english/english-b.org") "english")
  ("C-2" (ome-open-doc "english/PETS2.org") "english")
  ("C-3" (ome-open-doc "english/PETS3.org") "english")
  ("C-4" (ome-open-doc "english/CET4.org") "english")
  ("C-6" (ome-open-doc "english/CET6.org") "english")
  
  ;;
  ("<tab>" helm-keyboard-quit "back" 
   :exit t) 
  ("\\" (calendar) "calendar") 
  ("<tab>" (hydra-super-menu/body) "BACK") 
  ("q" nil "Quit") 
  ("<escape>" nil "Quit"))


(defhydra hydra-english-menu 
  (:color blue)
  "
^Common^        ^PETS^      ^CET^         ^TEM^         ^Other^
^^^^^^^^^^--------------------------------------------------------------------------------
_a_:english-a   _1_:PETS1   _C-4_:CET-4   _M-4_:TEM-4   _i_:IELTS 
_b_:english-b   _2_:PETS2   _C-6_:CET-6   _M-8_:TEM-8   _t_:TOEFL-IBT
_e_:english     _3_:PETS3   ^^            ^^            _g_:GRE
_v_:vocabulary  _4_:PETS4   ^^            ^^            ^^
^^              _5_:PETS5   ^^            ^^            ^^
^^^^^^^^^^--------------------------------------------------------------------------------
_\\_: calendar    _<escape>_:Quit   _<tab>_: <-BACK     ^^ ^^
" ;;

  ;; Common
  ("a" (ome-open-doc "english/english-a.org") "english")
  ("b" (ome-open-doc "english/english-b.org") "english-a")
  ("e" (ome-open-doc "english/english.org") "english-b")
  ("v" (ome-open-doc "english/vocabulary.org") "vocabulary")
  
  ;; English
  ("1" (ome-open-doc "english/PETS1.org") "english")
  ("2" (ome-open-doc "english/PETS2.org") "english")
  ("3" (ome-open-doc "english/PETS3.org") "english")
  ("4" (ome-open-doc "english/PETS4.org") "english")
  ("5" (ome-open-doc "english/PETS5.org") "english")

  ;; CET
  ("C-4" (ome-open-doc "english/CET4.org") "english")
  ("C-6" (ome-open-doc "english/CET6.org") "english")

  ;; TEM
  ("M-4" (ome-open-doc "english/TEM4.org") "english")
  ("M-8" (ome-open-doc "english/TEM8.org") "english")

  ;; Other
  ("i" (ome-open-doc "english/IELTS.org") "english")
  ("t" (ome-open-doc "english/TOEFL-IBT.org") "english")
  ("g" (ome-open-doc "english/GRE.org") "english")
  
  ;;
  ("<tab>" helm-keyboard-quit "back" 
   :exit t) 
  ("\\" (calendar) "calendar") 
  ("<tab>" (hydra-super-menu/body) "BACK") 
  ("q" nil "Quit") 
  ("<escape>" nil "Quit"))

;;
(defhydra hydra-new-menu 
  (:color blue)
  (concat
   "^^^^^^^^New project wizard:\n";;
   "^^^^^^^^------------------------------------------------------------------------\n";;
   "^C^           ^JVM^           ^.Net^             ^Functional^\n";;
   "^^^^^^^^------------------------------------------------------------------------\n";;
   "_c_:C/C++     _M-j_:Java      ^s:C#^             _r_:Rust\n";;
   "_C_:CL (ROS)  _M-s_:Scala     _C-n_:Nodejs       _e_:Erlang\n";;
   "_g_:Golang    _M-g_:Groovy    ^^                 _E_:Elixir\n";;
   "_p_:Python    ^M-p:Jython^    ^C-p:IronPython^   _h_:Haskell\n";;
   "_n_:Nim       _M-c_:Clojure   ^C-f:F#^           _o_:OCaml\n";;
   "_1_:Ruby      _C-c_:Cljs      ^^                 ^^";;
   "^^^^^^^^------------------------------------------------------------------------\n";;
   "_\\_:calendar   _`_:Shell     _<escape>_:Quit   _<tab>_:<-BACK ^^\n");;

  ("c" (ome-project-wizard "c") "c/c++")
  ("C" (ome-project-wizard "ros") "ROS")
  ("p" (ome-project-wizard "python") "python")
  ("g" (ome-project-wizard "go") "go")
  ("n" (ome-project-wizard "nim") "nim")
  ("1" (ome-project-wizard "ruby") "ruby")

  ("M-j" (ome-project-wizard "java") "java")
  ("M-s" (ome-project-wizard "scala") "scala")
  ("M-g" (ome-project-wizard "groovy") "groovy")
  ("M-c" (ome-project-wizard "clj") "clojure")
  ("C-c" (ome-project-wizard "cljs") "clojure")

  ("C-n" (ome-project-wizard "nodejs") "nodejs")
  
  ("r" (ome-project-wizard "rust") "rust")
  ("e" (ome-project-wizard "erlang") "erlang")
  ("E" (ome-project-wizard "elixir") "elixir")
  ("h" (ome-project-wizard "haskell") "haskell")
  ("o" (ome-project-wizard "ocaml") "ocaml")
  
  ;; Other
  ("<tab>" (hydra-super-menu/body) "back")
  ("`" (show-global-shell) "shell") 
  ("C-`" (show-global-shell-new) "shell-new") 
  ("\\" (calendar) "calendar") 
  ("w" (ome-open-url "http://wttr.in/") "wego") 
  ("q" nil "quit") 
  ("<SPC>" nil "quit") 
  ("<escape>" nil "quit"))

;; string to symbol
;; (symbol-name symbol)

;; funcall function from string
;; (funcall (intern (concat "emacs-lisp-mode" "-menu")) 1)

;; get symbol vale
;; (symbol-value (intern "major-mode"))

;; check function or variable
;; (fboundp (intern "message")) ;;==>t
;; (fboundp major-mode) ;; ==>t
;; (fboundp (symbol-value (intern "major-mode"))) ;;==> t

(defun ome-auto-menu (index)
  (let ((mode (symbol-name major-mode)))
    (let ((fun (intern (concat "automenu--" mode "-menu"))))
      (if (fboundp fun)
          (progn
            (let ((mlist (funcall fun)))
              (let ((mitem (nth index mlist)))
                (if mitem
                    mitem
                  "nil"))))
        "nil"))))

(defun ome-auto-func (index)
  (let ((mode (symbol-name major-mode)))
    (let ((fun (intern (concat "automenu--" mode "-func"))))
      (if (fboundp fun)  
          (funcall fun index)
        (message "run %s item:%d" mode index)))))

;; (defun emacs-lisp-mode-menu (index)
  ;; (concat  "menu-item" (number-to-string index)))

;; (defun emacs-lisp-mode-func (index)
;; (message  "run menu-item%d" index))

;; (setq fun (intern "automenu--xx-mode-menu"))
;; (fboundp fun)

;; (ome-auto-menu 1)
;; (ome-auto-func 2)
;; (nth 5 '(1 2 3))

(defhydra hydra-super-menu 
  (:color blue) 
  (concat ;;
   "^Main^         ^Buffer^          ^Search^             ^View^          ^Navigate^         ^Org^            ^" (symbol-name major-mode) "^\n" ;;
   "^^^^^^^^^^^^^^^^-----------------------------------------------------------------------------------------------------------\n"
   "_n_:New        _r_:rname         _>_:gochar-forward   _M-t_:toolbar   _[_:up             _M-c_:capture    _M-1_:"(ome-auto-menu 1) "\n";;
   "_o_:Open       _R_:remove        _<_:gochar-backward  _M-m_:menubar   _/_:down           _M-l_:store-link _M-2_:"(ome-auto-menu 2) "\n";;
   "_b_:Bookmarks  _k_:kill          _g_:grep-dir         _M-s_:speedbar  _;_:left           _M-a_:agenda     _M-3_:"(ome-auto-menu 3) "\n";;
   "_e_(E):Email   _M-k_:kill-other  _G_:grep-proj        _M-d_:sidebar   _'_:right          _M-b_:switchb    _M-4_:"(ome-auto-menu 4) "\n";;
   "_f_:Feed       _C-k_:kill-all    _d_:dict-bing        _=_:scale+      ^0-9:select^       _M-u_:update     _M-5_:"(ome-auto-menu 5) "\n";;
   "_m_:Module     ^^                _D_:dict-bing-web    _-_:scale-      _u_:URLs           _M-g_:GTD        _M-6_:"(ome-auto-menu 6) "\n";;
   "_i_:IRC        ^^                ^^                   _M_:Message     _C-7_:gitignore    _M-p_:push-blog  _M-7_:"(ome-auto-menu 7) "\n";;
   "_s_(S):Shell   ^^                ^^                   _._:*scratch*   _C-8_:Makefile     _M-e_:en         _M-8_:"(ome-auto-menu 8) "\n";;
   "^^             ^^                ^^                   ^^              _C-9_:CMakeList.txt^^               _M-9_:"(ome-auto-menu 9) "\n";;
   "^^             ^^                ^^                   _M-._:load-menu _C-0_:README.org   ^^               _M-0_:"(ome-auto-menu 0) "\n";;
   "^^^^^^^^^^^^^^^^-----------------------------------------------------------------------------------------------------------\n"
   "_\\_:calendar   _`_:Shell     _<escape>_:Quit   _<tab>_:<-BACK ^^ ^^\n")
  ;; Main
  ("n" (hydra-new-menu/body) "New" 
   :color blue) 
  ("o" (hydra-open-menu/body) "Open" 
   :color blue) 
  ("b" helm-bookmarks "Bookmarks") 
  ("e" ome-mu4e-open "Email" 
   :color blue)
  ("E" ome-mu4e-new "Email")
  ("f" elfeed "Feed" 
   :color blue) 
  ("m" (hydra-config-menu/body) "Module")
  ("i" (ome-find-buffer-by-major 'erc-mode) "IRC")
  ("s" (show-global-shell) "shell")
  ("S" (show-global-shell-new) "shell")

  ;; auto menu
  ("M-1" (ome-auto-func 1) "auto-func")
  ("M-2" (ome-auto-func 2) "auto-func")
  ("M-3" (ome-auto-func 3) "auto-func")
  ("M-4" (ome-auto-func 4) "auto-func")
  ("M-5" (ome-auto-func 5) "auto-func")
  ("M-6" (ome-auto-func 6) "auto-func")
  ("M-7" (ome-auto-func 7) "auto-func")
  ("M-8" (ome-auto-func 8) "auto-func")
  ("M-9" (ome-auto-func 9) "auto-func")
  ("M-0" (ome-auto-func 0) "auto-func")
  
  ;; Org
  ("M-c" org-capture "capture")
  ("M-l" org-store-link "store-link")
  ("M-a" org-agenda "agenda")
  ("M-b" org-switchb "switchb")
  ("M-u" org-update-statistics-cookies)
  ;; ("M-j" (org-capture nil "j") "journal")
  ("M-g" (org-capture nil "t") "GTD")
  ;; ("M-p" (org-publish-project "blog") "publish-blog")  
  ("M-p" (ome-run-command "cd ~/workspace/blog/ && make") "publish-blog")
  ("C-p" (ome-run-command "rm ~/.org-timestamps/* && cd ~/workspace/blog/ && make") "publish-blog")
  ("M-e" (hydra-english-menu/body) "english" 
   :color blue)
  
  ;; Search
  (">" ome-go-to-char-forward "go-to-char-forward") 
  ("<" ome-go-to-char-backward "go-to-char-backward") 
  ("G" projectile-ripgrep "projectile-project-root") 
  ("g" ome-grep-directory "projectile-directory-root") 
  ("d" bing-dict-brief "bing-dict-brief") 
  ("D" ome-bing-dict-brief-web "bing-dict-brief-web")
  ("H" (find-file "~/Cybertron/Modules/Foundation/Source/CybertronLogServer/Main.cpp"))
  ("h" (find-file "~/Cybertron/Modules/Web/WebBridge/main.cpp"))
  
  ;; View
  ("M-t" tool-bar-mode "Toolbar" 
   :color pink) 
  ("M-m" menu-bar-mode "Menubar" 
   :color pink) 
  ("M-s" projectile-speedbar-toggle "Speedbar" 
   :color pink) 
  ("M-d" (dired-sidebar-toggle-sidebar nil) "DiredSideBar" 
   :color pink) 
  ("=" text-scale-increase "text-scale-increase" 
   :color pink) 
  ("-" text-scale-decrease "text-scale-decrease" 
   :color pink)
  ("M" (ome-show-compilation "*Messages*") "*Message*")
  ("." switch-to-scratch-buffer "*scratch")
  ("M-." (load "mod-keybind.el") "load-menu")

  ;; Nav
  (";" tabbar-backward "ome-tabbar-backward" 
   :color pink) 
  ("'" tabbar-forward "tabbar-forward" 
   :color pink) 
  ("[" ome-tabbar-backward-group "tabbar-up" 
   :color pink) 
  ("/" ome-tabbar-forward-group "tabbar-down" 
   :color pink) 
  ("<left>" tabbar-backward "tabbar-backward" 
   :color pink) 
  ("<right>" tabbar-forward "tabbar-forward" 
   :color pink) 
  ("<up>" tabbar-backward-group "tabbar-up" 
   :color pink) 
  ("<down>" tabbar-forward-group "tabbar-down" 
   :color pink)

  ("M-;" tabbar-backward "tabbar-backward" 
   :color pink) 
  ("M-'" tabbar-forward "tabbar-forward" 
   :color pink) 
  ("M-[" tabbar-backward-group "tabbar-up" 
   :color pink) 
  ("M-/" tabbar-forward-group "tabbar-down" 
   :color pink)
  
  ("0" select-window-0 "select-window-0" 
   :color pink) 
  ("1" select-window-1 "select-window-1" 
   :color pink) 
  ("2" select-window-2 "select-window-2" 
   :color pink) 
  ("3" select-window-3 "select-window-3" 
   :color pink) 
  ("4" select-window-4 "select-window-4" 
   :color pink) 
  ("5" select-window-5 "select-window-5" 
   :color pink) 
  ("6" select-window-6 "select-window-6" 
   :color pink) 
  ("7" select-window-7 "select-window-7" 
   :color pink) 
  ("8" select-window-8 "select-window-8" 
   :color pink) 
  ("9" select-window-9 "select-window-9" 
   :color pink) 
  ("u" (hydra-url-menu/body) "URLs")
  ("C-7" (find-file (concat (ome-project-root) ".gitignore")) "gitignore")
  ("C-8" (find-file (concat (ome-project-root) "Makefile")) "Makefile")
  ("C-9" (find-file (concat (ome-project-root) "Makefile")) "CMakefile.txt")
  ("C-0" (find-file (concat (ome-project-root) "README.org")) "README.org")

  ;; Buffer/File
  ("r" ome-rename-file-and-buffer "rename-file-and-buffer") 
  ("R" ome-delete-file-and-buffer "delete-file-and-buffer") 
  ("k" (kill-buffer (buffer-name)) "kill-buffer" 
   :color pink) 
  ("M-k" ome-kill-other-buffers "kill-other-buffers") 
  ("C-k" ome-kill-all-buffers "kill-all-buffers") 
  
  ;; Orgmode

  
  ;; Other
  ("<tab>" helm-recentf "(helm-recentf)")
  ("`" (show-global-shell) "shell") 
  ("C-`" (show-global-shell-new) "shell-new") 
  ("\\" (calendar) "calendar") 
  ("w" (ome-open-url "http://wttr.in/") "wego") 
  ("q" nil "quit") 
  ("<SPC>" nil "quit") 
  ("<escape>" nil "quit"))

;; (package-require 'yahoo-weather)
;; (setq yahoo-weather-location "Shanghai")
;; (yahoo-weather-mode)


(defun show-super-menu () 
  "docstring" 
  (interactive) 
  (load "mod-keybind.el") 
  (hydra-super-menu/body))

;; (global-set-key (kbd "C-M-z") 'show-super-menu1)
(global-set-key (kbd "M-z") 'show-super-menu)
;;
(provide 'mod-keybind)
;; mod-keybind.el ends here
