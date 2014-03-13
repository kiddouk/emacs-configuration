;; Add load path to configuration file
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/defuns")
(add-to-list 'load-path "~/.emacs.d/site-lisp/slime")
(add-to-list 'load-path "~/.emacs.d/site-lisp/swank-js")
(add-to-list 'load-path "~/.emacs.d/site-lisp/highlight-indentation")

;; Uses Marmelade package repository
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; We tune in the Garbage Collector to prevent
;; to fire it too often (every ~20MB)
(setq gc-cons-threshold 20000000)

;; Make sure that the .emacs.d is up to date
;; This is using Cask (and Pallet) to manage dependencies
;; And it should be installed and in the path first
(require 'cask "~/.cask/cask.el")
(cask-initialize)

;;; Font is probably the most important setting. I want to read code.
(set-face-attribute 'default nil :family "Source Code Pro")
(set-face-attribute 'default nil :height 140)

;;; Rebind awful Emacs bindings.
;;; Mostly because it forces me to learn them and discover
;;; some super new features

(require 'key-bindings)
(load "~/.emacs.d/defuns/defuns-buffer.el")

;;; Enable minor modes
;;; A collection of extra modes used everywhere nearly
(require 'magit)
(require 'smex)
(require 'expand-region)
(require 'ace-jump-mode)
(require 'markdown-mode)


(require 'visual-regexp)

;; I want projectile to manage as many projects as possible
(require 'projectile)
(projectile-global-mode)

(require 'setup-ido)

;;; Enable mode configuration
(require 'setup-html-mode)
(require 'setup-flycheck)
(require 'setup-js2-mode)
(require 'setup-swank)
(require 'setup-yasnippet)
(require 'setup-auto-complete)
(require 'setup-python)

;;; Load theme
(load-theme 'solarized-dark)

;;; Start emacs-server
;;; (server-start)

;;; Prevent backup file
(setq make-backup-files nil)
(setq auto-save-default nil)

;;; Some key tuning for Mac OS X
;;;(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)

;;; Remove the toolbar if compiled for X
(tool-bar-mode 0)

;;; Define Tabbing 
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)


;;; Activate Major Mode on file extension detection
(add-to-list 'auto-mode-alist '("\\.html\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
