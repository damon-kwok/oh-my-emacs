;;; -*- lexical-binding: t -*-
;; mod-calendar.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2015-2016 Damon Kwok
;;
;; Author: gww <DamonKwok@msn.com>
;; Date: 2016-02-04
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

(package-require 'cal-china-x)
(require 'cal-china-x)

(setq mark-holidays-in-calendar t)
(setq cal-china-x-important-holidays cal-china-x-chinese-holidays)
(setq calendar-holidays cal-china-x-important-holidays)

(defconst cal-china-x-chinese-holidays 
  '((holiday-fixed 1 1 "元旦") 
    (holiday-fixed 2 14 "情人节") 
    (holiday-fixed 3 8 "妇女节") 
    (holiday-fixed 3 14 "白色情人节") 
    (holiday-fixed 4 1 "愚人节") 
    (holiday-fixed 5 1 "劳动节") 
    (holiday-float 5 0 2 "母亲节") 
    (holiday-fixed 6 1 "儿童节") 
    (holiday-float 6 0 3 "父亲节") 
    (holiday-fixed 9 10 "教师节") 
    (holiday-fixed 10 1 "国庆节") 
    (holiday-fixed 12 25 "圣诞节")
    ;; 农历节日
    (holiday-lunar 1 1 "春节" 0) 
    (holiday-lunar 1 2 "春节" 0) 
    (holiday-lunar 1 3 "春节" 0) 
    (holiday-lunar 1 15 "元宵节" 0) 
    (holiday-solar-term "24-清明" "清明节") 
    (holiday-lunar 5 5 "端午节" 0) 
    (holiday-lunar 8 15 "中秋节" 0)
    ;; 生日
    (holiday-fixed 2 26 "阳历生日") 
    (holiday-lunar 1 118 "阴历生日" 0) )
  "Pre-defined chinese public holidays.
You can add this to your `calendar-holidays'.")

(setq holiday-wwliu-holidays '(	;;公历节日
			       (holiday-fixed 1 1 "元旦") 
			       (holiday-fixed 2 14 "情人节") 
			       (holiday-fixed 3 8 "妇女节") 
			       (holiday-fixed 3 14 "白色情人节") 
			       (holiday-fixed 4 1 "愚人节") 
			       (holiday-fixed 5 1 "劳动节") 
			       (holiday-float 5 0 2 "母亲节") 
			       (holiday-fixed 6 1 "儿童节") 
			       (holiday-float 6 0 3 "父亲节") 
			       (holiday-fixed 9 10 "教师节") 
			       (holiday-fixed 10 1 "国庆节") 
			       (holiday-fixed 12 25 "圣诞节")
			       ;; 农历节日
			       (holiday-lunar 1 1 "春节" 0) 
			       (holiday-lunar 1 2 "春节" 0) 
			       (holiday-lunar 1 3 "春节" 0) 
			       (holiday-lunar 1 15 "元宵节" 0) 
			       (holiday-solar-term "24-清明" "清明节") 
			       (holiday-lunar 5 5 "端午节" 0) 
			       (holiday-lunar 8 15 "中秋节" 0)
			       ;; 生日
			       ;;
			       ))

;; (require 'cal-china-x)
;; only show mysetting
;; (setq calendar-holidays holiday-wwliu-holidays)

(setq christian-holidays nil) ;; 不显示基督教的节日
(setq hebrew-holidays nil)    ;; 不显示希伯来人的节日
(setq islamic-holidays nil)   ;; 不显示伊斯兰教的节日

;;
(provide 'mod-calendar)
;;; mod-calendar.el ends here
