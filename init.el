;; Add load path to configuration file

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)


(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(add-to-list 'load-path "~/.emacs.d/init")
(add-to-list 'load-path "~/.emacs.d/vendor")
(add-to-list 'load-path "~/.emacs.d/defuns")
(add-to-list 'load-path "~/.emacs.d/modules/android-mode")
(add-to-list 'load-path "~/.emacs.d/modules/highlight-indentation")
(add-to-list 'load-path "~/.emacs.d/modules/jde-2.4.1/lisp")
(add-to-list 'load-path "~/.emacs.d/modules/kotlin-mode")

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))

;;; I use brew cask to install cask, you may want to change that path
(require 'cask "/usr/local/share/emacs/site-lisp/cask/cask.el")
(cask-initialize)

(require 'pallet)
(pallet-mode t)

;; We now set the path for emacs
(when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize))

;; We tune in the Garbage Collector to prevent
;; to fire it too often (every ~20MB)
(setq gc-cons-threshold 20000000)

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

(add-hook 'find-file-hook 'gradle-mode-maybe)

(require 'setup-ido)

;;; Enable mode configuration
(require 'setup-html-mode)
(require 'setup-flycheck)
(require 'setup-js2-mode)
(require 'setup-yasnippet)
(require 'setup-auto-complete)
(require 'setup-coffee-mode)
(require 'setup-python)
(require 'android-mode)
(require 'setup-java)
(require 'setup-powerline)
(require 'setup-kotlin)

;;; Load theme
(load-theme 'solarized-dark t)

;;; Start emacs-server
;;; (server-start)

;;; Some key tuning for Mac OS X
;;;(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)

;;; Remove the toolbar if compiled for X
(tool-bar-mode 0)

;;; Define Tabbing to never use TAB for indent
;;; and use 4 spaces. ALWAYS.
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)


;;; Activate Major Mode on file extension detection
(add-to-list 'auto-mode-alist '("\\.html\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.xml\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.hbs\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.coffee\\'" . coffee-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.java\\'" . java-mode))
(add-to-list 'auto-mode-alist '("\\.elm\\'" . elm-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coffee-tab-width 2)
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(gradle-mode t)
 '(ispell-program-name "/usr/local/bin/aspell")
 '(jde-complete-function (quote jde-complete-menu))
 '(json-reformat:indent-width 1)
 '(kotlin-tab-width 4)
 '(package-selected-packages
   (quote
    (exec-path-from-shell lua-mode swift-mode dockerfile-mode helm-dash slack yaml-mode emamux dash-at-point android-mode visual-regexp solarized-theme smex projectile pallet markdown-mode magit json-mode js2-mode java-snippets ido-vertical-mode helm-git-grep helm handlebars-sgml-mode groovy-mode gradle-mode flymake-json flycheck flx-ido expand-region emmet-mode elm-mode color-theme-solarized coffee-mode auto-complete ace-jump-mode)))
 '(projectile-mode t nil (projectile))
 '(semantic-default-submodes
   (quote
    (global-semantic-idle-completions-mode global-semantic-idle-scheduler-mode global-semanticdb-minor-mode global-semantic-idle-summary-mode global-semantic-mru-bookmark-mode)))
 '(semantic-idle-scheduler-idle-time 10)
 '(semanticdb-javap-classpath
   (quote
    ("/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Classes/classes.jar"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-region 'disabled nil)


(setq magit-last-seen-setup-instructions "1.4.0")

;; make backup to a designated dir, mirroring the full path
(setq backup-directory-alist `(("." . "~/.saves/emacs-backup/")))
(setq auto-save-default nil)
(defun my-backup-file-name (fpath)
  "Return a new file path of a given file path.
If the new path's directories does not exist, create them."
  (let ((backupRootDir "~/.emacs.d/emacs-backup/"))
    (if (not (file-exists-p backupRootDir)) (make-directory backupRootDir))
    (concat backupRootDir (file-name-nondirectory fpath))
    )
  )

(setq make-backup-file-name-function 'my-backup-file-name)
(setq make-backup-files nil)
