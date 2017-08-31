;;; -*- lexical-binding: t -*-
;; mod-input.el --- This is where you apply your OCD.
;;
;; Last-saved : 2016-Jan-06
;; Copyright (C) 2015-2016 Damon Kwok
;;
;; Author: gww <DamonKwok@msn.com>
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

(package-require 'pyim)
(require 'pyim)
(require 'pyim-basedict)
(pyim-basedict-enable)
(setq default-input-method "pyim")
  
;;(package-require 'chinese-pyim)
;;(require 'chinese-pyim)
(setq pyim-dicts
      '((:name "dict1" :file "~/dict/pyim-bigdict.pyim" :coding utf-8 :dict-type pinyin-dict)
        (:name "dict2" :file "~/dict/AutoCAD词汇.txt" :coding utf-8 :dict-type pinyin-dict)
	(:name "dict3" :file "~/dict/编程语言.txt" :coding utf-8 :dict-type pinyin-dict)
	(:name "dict4" :file "~/dict/财经金融词汇大全.txt" :coding utf-8 :dict-type pinyin-dict)
	(:name "dict5" :file "~/dict/法律词汇大全.txt" :coding utf-8 :dict-type pinyin-dict)
	(:name "dict6" :file "~/dict/计算机名词.txt" :coding utf-8 :dict-type pinyin-dict)
	(:name "dict7" :file "~/dict/计算机专业词汇大全.txt" :coding utf-8 :dict-type pinyin-dict)
	(:name "dict8" :file "~/dict/汽车词汇大全.txt" :coding utf-8 :dict-type pinyin-dict)
	(:name "dict9" :file "~/dict/前端工程师必备词库.txt" :coding utf-8 :dict-type pinyin-dict)
	(:name "dict10" :file "~/dict/数学词汇大全.txt" :coding utf-8 :dict-type pinyin-dict)
	(:name "dict11" :file "~/dict/虚拟现实技术.txt" :coding utf-8 :dict-type pinyin-dict)
	(:name "dict12" :file "~/dict/中国高等院校大全.txt" :coding utf-8 :dict-type pinyin-dict)
	(:name "dict13" :file "~/dict/中国医院大全.txt" :coding utf-8 :dict-type pinyin-dict)
	(:name "dict14" :file "~/dict/最详细的全国地名大全.txt" :coding utf-8 :dict-type pinyin-dict)))
 
;;(setq default-input-method "chinese-pyim")

 ;;; 使用popup包来绘制选词框 (emacs overlay)
;; (setq pyim-use-tooltip 'popup)

 ;;; 使用pos-top包来绘制选词框 (emacs tooltip)
 (setq pyim-use-tooltip 'pos-tip)

;; (global-set-key (kbd "C-\\") 'toggle-input-method)
;;
(provide 'mod-input)
;;; mod-input.el ends here

