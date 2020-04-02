;;; -*- lexical-binding: t -*-
;; mod-input.el --- This is where you apply your OCD.
;;
;; Last-saved : 2016-Jan-06
;; Copyright (C) 2015-2016 Damon Kwok
;;
;; Author: damon-kwok <damon-kwok@outlook.com>
;; Date: 2016-01-28
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

(package-download 'pyim)

(defun pyim-init ()
  (package-require 'pyim 'pyim 'pyim-basedict)
  (pyim-basedict-enable)
  (setq default-input-method "pyim")

  ;; 我使用全拼
  (setq pyim-default-scheme 'quanpin)

  ;; 设置 pyim 探针设置，这是 pyim 高级功能设置，可以实现 *无痛* 中英文切换 :-)
  (setq-default                            ;;
    pyim-english-input-switch-functions '(;;
                                           ;;pyim-probe-dynamic-english ;;2. 当前字符为其他字符时，输入下一个字符时默认开启英文输入
                                           ;; pyim-probe-isearch-mode ;; 使用 isearch 搜索时，强制开启英文输入模式
                                           ;; pyim-probe-program-mode ;;如果当前的 mode 衍生自 prog-mode，那么仅仅在字符串和 comment 中开启中文输入模式
                                           pyim-probe-org-speed-commands ;;解决 org-speed-commands 与 pyim 冲突问题
                                           pyim-probe-org-structure-template)) ;;使用 org-structure-template 时，关闭中文输入模式
  (setq-default ;;
    pyim-punctuation-half-width-functions '(pyim-probe-punctuation-line-beginning ;;行首强制输入半角标点
                                             ;; pyim-probe-punctuation-after-punctuation;;半角标点后强制输入半角标点
                                             ))

  ;; 开启：1/关闭：0 拼音搜索功能
  (pyim-isearch-mode 0)

  ;; option 1.使用 popup 包来绘制选词框 （emacs overlay 机制）
  (setq pyim-page-tooltip 'popup)
  ;; option 2.使用 pos-tip 包来绘制选词框（emacs tooltip 机制）
  ;; (setq pyim-page-tooltip 'pos-tip)
  ;; 2.1 注：Linux平台下emacs可以使用GTK来绘制选词框：
  (if (and (eq system-type 'gnu/linux)
        (display-graphic-p))
    (setq x-gtk-use-system-tooltips t))

  ;; pyim 的 tooltip 选词框默认使用 双行显示 的样式，在一些特 殊的情况下（比如：popup 显示的菜单错位），用户可以使用 单行显示 的样式：
  (setq pyim-page-style 'two-lines) ;;one-line ;;two-lines

  ;; 选词框显示5个候选词
  (setq pyim-page-length 9)

  ;; 让 Emacs 启动时自动加载 pyim 词库
  ;; (add-hook 'emacs-startup-hook
  ;; #'(lambda () (pyim-restart-1 t)))

  ;; (setq pyim-dicts
  ;; '((:name "dict2" :file "~/workspace/pyim-dicts/AutoCAD词汇.txt" :coding utf-8 :dict-type pinyin-dict)
  ;; (:name "dict3" :file "~/workspace/pyim-dicts/编程语言.txt" :coding utf-8 :dict-type pinyin-dict)
  ;; (:name "dict4" :file "~/workspace/pyim-dicts/财经金融词汇大全.txt" :coding utf-8 :dict-type pinyin-dict)
  ;; (:name "dict5" :file "~/workspace/pyim-dicts/法律词汇大全.txt" :coding utf-8 :dict-type pinyin-dict)
  ;; (:name "dict6" :file "~/workspace/pyim-dicts/计算机名词.txt" :coding utf-8 :dict-type pinyin-dict)
  ;; (:name "dict7" :file "~/workspace/pyim-dicts/计算机专业词汇大全.txt" :coding utf-8 :dict-type pinyin-dict)
  ;; (:name "dict8" :file "~/workspace/pyim-dicts/汽车词汇大全.txt" :coding utf-8 :dict-type pinyin-dict)
  ;; (:name "dict9" :file "~/workspace/pyim-dicts/前端工程师必备词库.txt" :coding utf-8 :dict-type pinyin-dict)
  ;; (:name "dict10" :file "~/workspace/pyim-dicts/数学词汇大全.txt" :coding utf-8 :dict-type pinyin-dict)
  ;; (:name "dict11" :file "~/workspace/pyim-dicts/虚拟现实技术.txt" :coding utf-8 :dict-type pinyin-dict)
  ;; (:name "dict12" :file "~/workspace/pyim-dicts/中国高等院校大全.txt" :coding utf-8 :dict-type pinyin-dict)
  ;; (:name "dict13" :file "~/workspace/pyim-dicts/中国医院大全.txt" :coding utf-8 :dict-type pinyin-dict)
  ;; (:name "dict14" :file "~/workspace/pyim-dicts/最详细的全国地名大全.txt" :coding utf-8 :dict-type pinyin-dict)))
  )
(global-set-key (kbd "C-\\")
  (lambda ()
    (interactive)
    (pyim-init)
    (toggle-input-method)))

;; (global-set-key (kbd "C-\\") 'toggle-input-method)
;;
(provide 'mod-input)
;;; mod-input.el ends here
