(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/yasnippet")
(add-to-list 'load-path "~/.emacs.d/pylookup")
(add-to-list 'load-path "~/.emacs.d/w3m")
(add-to-list 'load-path "~/.emacs.d/flymake-python")
(add-to-list 'load-path "/usr/local/share/emacs/23.3/lisp/")
(add-to-list 'load-path "/usr/local/share/emacs/23.3/lisp/net")
(add-to-list 'load-path "/usr/local/share/emacs/23.3/lisp/progmodes")
(add-to-list 'load-path "~/.emacs.d/themes/emacs-color-theme-solarized")

;;; Load theme
(require 'color-theme-solarized)

;;; Some key tuning for Mac OS X
(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)


;;; Speedbar
(setq speedbar-use-images nil)
(setq sr-speedbar-right-side nil)
;;;(add-to-list 'linum-disabled-modes-list '(speedbar-mode))


;;; Define Tabbing as PEP8
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)


;;; Virtualenv dependancy
(require 'python)
(add-hook 'python-mode-hook '(lambda () (require 'virtualenv)))

;;; Electric Pairs
(add-hook 'python-mode-hook
     (lambda ()
      (define-key python-mode-map "\"" 'electric-pair)
      (define-key python-mode-map "\'" 'electric-pair)
      (define-key python-mode-map "(" 'electric-pair)
      (define-key python-mode-map "[" 'electric-pair)
      (define-key python-mode-map "{" 'electric-pair)))
(defun electric-pair ()
  "Insert character pair without sournding spaces"
  (interactive)
  (let (parens-require-spaces)
    (insert-pair)))

;;; bind RET to py-newline-and-indent
(add-hook 'python-mode-hook '(lambda () 
     (define-key python-mode-map "\C-m" 'newline-and-indent)))


(add-hook 'before-save-hook 'delete-trailing-whitespace)


;;; inline syntax checking with pylin
(require 'flymake)
(require 'flymake-cursor)
(global-set-key [f4] 'flymake-goto-next-error)
(when (load "flymake" t)
      (defun flymake-pylint-init ()
        (let* ((temp-file (flymake-init-create-temp-buffer-copy
                           'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
          (list "~/.emacs.d/flymake-python/pyflymake.py" (list local-file))))
          ;;;(list "epylint" (list local-file))))
    
      (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pylint-init)))



(add-hook 'find-file-hook 'flymake-find-file-hook)
;;; Pymacs for Ropemacs
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
;;(eval-after-load "pymacs"
;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))

;;; Activate ropemacs module under the rope- namespace
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)


;;; Enable autocomplete from ropemacs
(require 'auto-complete)
(global-auto-complete-mode t)

;;; Enable yassnippet for snippet completion
;;; By default, the TAB key is used and fall back to whatever
;;; action is what suppose to do (code completion, then indentation fix)
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")


;;; Activate w3m browser (mainly used for pylookup)
(require 'w3m-load)

;;; PYlookUp
;; add pylookup to your loadpath, ex) "~/.lisp/addons/pylookup"
(setq pylookup-dir "~/.emacs.d/pylookup")
;; load pylookup when compile time
(eval-when-compile (require 'pylookup))

;; set executable file and db file
(setq pylookup-program (concat pylookup-dir "/pylookup.py"))
(setq pylookup-db-file (concat pylookup-dir "/pylookup.db"))

;; to speedup, just load it on demand
(autoload 'pylookup-lookup "pylookup"
  "Lookup SEARCH-TERM in the Python HTML indexes." t)
(autoload 'pylookup-update "pylookup" 
  "Run pylookup-update and create the database at `pylookup-db-file'." t)

;;; Change the keybind for pylookup
(global-set-key "\C-ch" 'pylookup-lookup)

;;; Set w3m browser
(require 'browse-url)
(setq browse-url-browser-function 'browse-url-default-macosx-browser)





;;; Fix the "" in pythonpath
(defun python-reinstate-current-directory ()
  "When running Python, add the current directory ('') to the head of sys.path.
For reasons unexplained, run-python passes arguments to the
interpreter that explicitly remove '' from sys.path. This means
that, for example, using `python-send-buffer' in a buffer
visiting a module's code will fail to find other modules in the
same directory.

Adding this function to `inferior-python-mode-hook' reinstates
the current directory in Python's search path."
  (python-send-string "sys.path[0:0] = ['']"))

(add-hook 'inferior-python-mode-hook 'python-reinstate-current-directory)

