;;; early-init.el --- Early init.
;;; -*- lexical-binding: t; -*-
;;; Commentary:

;; Author: Chris Henderson

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Code:

;; Defer garbage collection further back in the startup process.
(setq-default gc-cons-threshold (expt 2 24))

;; In Emacs 27+, package initialization occurs before `user-init-file' is
;; loaded, but after `early-init-file'.
(setq-default package-enable-at-startup nil)
(advice-add #'package--ensure-init-file :override #'ignore)

;; Prevent the glimpse of un-styled Emacs by disabling these UI elements early.
(setq-default tool-bar-mode nil
              menu-bar-mode 1)

(when (fboundp 'set-scroll-bar-mode)
  (set-scroll-bar-mode nil))

;; (set-face-attribute 'default nil  :family "Source Code Pro" :height 80 :weight 'normal)

;; Resizing the Emacs frame can be a terribly expensive part of changing the
;; font. By inhibiting this, we easily halve startup times with fonts that are
;; larger than the system default.
(setq-default frame-inhibit-implied-resize t)

;; Ignore X resources; its settings would be redundant with the other settings
;; in this file and can conflict with later config (particularly where the
;; cursor color is concerned).
(advice-add #'x-apply-session-resources :override #'ignore)
;;; early-init.el ends here