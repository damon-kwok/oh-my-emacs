;; -*- lexical-binding: t -*-
;; mod-dumbjump.el --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2018 damon-kwok
;;
;; Author: damon <damon-kwok@outlook.com>
;; Create: 2018-08-08
;; Modify: 2018-08-08
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'mod-package)
;;
;; (package-require 'dumb-jump)

(use-package 
  dumb-jump 
  :bind (("M-g o" . dumb-jump-go-other-window) 
         ("M-g j" . dumb-jump-go) 
         ("M-g i" . dumb-jump-go-prompt) 
         ("M-g x" . dumb-jump-go-prefer-external) 
         ("M-g z" . dumb-jump-go-prefer-external-other-window)) 
  :config (setq dumb-jump-selector 'helm) ;; (setq dumb-jump-selector 'ivy)
  :ensure)

(defhydra dumb-jump-hydra 
  (:color blue 
          :columns 3)
  "Dumb Jump" ("j" dumb-jump-go "Go") 
  ("o" dumb-jump-go-other-window "Other window") 
  ("e" dumb-jump-go-prefer-external "Go external") 
  ("x" dumb-jump-go-prefer-external-other-window "Go external other window") 
  ("i" dumb-jump-go-prompt "Prompt") 
  ("l" dumb-jump-quick-look "Quick look") 
  ("b" dumb-jump-back "Back"))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'mod-dumbjump)
;; mod-dumbjump.el ends here
