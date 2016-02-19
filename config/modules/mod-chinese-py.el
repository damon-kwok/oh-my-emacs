;;; -*- lexical-binding: t -*-
;; mod-chinese-py.el --- This is where you apply your OCD.
;;
;; Author     : Dylan R. E. Moonfire (original)
;; Maintainer : Jostein Kjønigsen <jostein@gmail.com>
;; Created    : Feburary 2005
;; Modified   : November 2015
;; Version    : 0.8.12
;; Keywords   : emacs elisp
;; Package-Version: 20160117.1321
;; X-URL      : https://github.com/josteink/csharp-mode
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

(package-require 'chinese-pyim)
(require 'chinese-pyim)
(setq pyim-dicts
      '((:name "dict1" :file "~/dict//pyim-bigdict.pyim" :coding utf-8-unix :dict-type pinyin-dict)
        (:name "dict2" :file "~/dict//pyim-bigdict2.pyim" :coding utf-8-unix :dict-type pinyin-dict)))

(setq default-input-method "chinese-pyim")
;; (global-set-key (kbd "C-\\") 'toggle-input-method)
;;
(provide 'mod-chinese-py)
;;; mod-chinese-py.el ends here
