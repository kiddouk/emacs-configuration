(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/yasnippet")
(add-to-list 'load-path "~/.emacs.d/Pymacs")
(add-to-list 'load-path "~/.emacs.d/pylookup")
(add-to-list 'load-path "~/.emacs.d/flymake-python")
(add-to-list 'load-path "/usr/local/share/emacs/23.3/lisp/")
(add-to-list 'load-path "/usr/local/share/emacs/23.3/lisp/net")
(add-to-list 'load-path "/usr/local/share/emacs/23.3/lisp/progmodes")
(add-to-list 'load-path "~/.emacs.d/themes/emacs-color-theme-solarized")
(add-to-list 'load-path "~/.emacs.d/coffee-mode")

;;; Major modes
(autoload 'python-mode "python" "Python Major Mode" t)
(autoload 'coffee-mode "coffee" "Coffee Script mode" t)

;;; Activate theme on file extension detection
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.coffee\\'" . coffee-mode))

;;; Load theme
(require 'color-theme-solarized)

;;; Some key tuning for Mac OS X
;;;(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)


;;; Speedbar
(setq speedbar-use-images nil) ; No images in the speed bar
(setq sr-speedbar-right-side nil) ; Speedbar should be on the left ?
(speedbar 1)
;;;(add-to-list 'linum-disabled-modes-list '(speedbar-mode))


;;; Define Tabbing as PEP8
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;;
;;; PYTHON RELATED CALLS 
;;;

;;; Virtualenv dependancy
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
          (list "~/.emacs.d/lintrunner.py" (list local-file))))
    
      (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pylint-init)))



(add-hook 'find-file-hook 'flymake-find-file-hook)

;;; Pymacs for Ropemacs
(require 'pymacs)
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

;;; Activate ropemacs module under the rope- namespace
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)


(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)


;;; Enable yassnippet for snippet completion
;;; By default, the TAB key is used and fall back to whatever
;;; action is what suppose to do (code completion, then indentation fix)
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")

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

