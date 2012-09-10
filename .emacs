(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/yasnippet")
(add-to-list 'load-path "~/.emacs.d/Pymacs")
(add-to-list 'load-path "~/.emacs.d/pylookup")
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "/usr/local/share/emacs/23.3/lisp/")
(add-to-list 'load-path "/usr/local/share/emacs/23.3/lisp/net")
(add-to-list 'load-path "/usr/local/share/emacs/23.3/lisp/progmodes")
(add-to-list 'load-path "~/.emacs.d/themes/emacs-color-theme-solarized")
(add-to-list 'load-path "~/.emacs.d/coffee-mode")
(add-to-list 'load-path "~/.emacs.d/popup")
(add-to-list 'load-path "~/.emacs.d/highlight-identation")
(add-to-list 'load-path "~/.emacs.d/magit")


;;; Major modes
(autoload 'python-mode "python" "Python Major Mode" t)
(autoload 'coffee-mode "coffee" "Coffee Script mode" t)

;;; Activate theme on file extension detection
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.coffee\\'" . coffee-mode))

;;; Start emacs-server
(server-start)
(desktop-save-mode 1)


;;; Load theme
(require 'color-theme-solarized)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-solarized-dark)))

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

;;; Remove the toolbar if compiled for X
(tool-bar-mode 0)

;;; GIT with Magit
(require 'magit)

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

(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map (kbd "<f5>") 'magit-status)))


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

;;(require 'highlight-indentation)
;;(add-hook 'python-mode-hook 'highlight-indentation-mode)


;;; inline syntax checking with pylin
(require 'flymake)
;;; (require 'flymake-cursor)
;;; (global-set-key [f4] 'flymake-goto-next-error)
(when (load "flymake" t)
  (defun flymake-pylint-init (&optional trigger-type)
    "Return the command to run Python checks wyth pyflymake.py"
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name)))
           (options (when trigger-type (list "-d" "--trigger-type" trigger-type))))
      ;; after an extended check, disable check-on-edit
      (when (member trigger-type '("save" "force"))
        (setq flymake-no-changes-timeout 18600))
      (list "~/.emacs.d/pyflymake.py" (append options (list local-file)))))

  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pylint-init)))

(defun flymake-errors-on-current-line ()
  "Return the errors on the current line or nil if none exist"
  (let* ((line-no (flymake-current-line-no)))
    (nth 0 (flymake-find-err-info flymake-err-info line-no))))
  
(defun flymake-display-err-message-for-current-line ()
  "Display a message with errors/warnings for current line if it has errors and/or warnings."
  (interactive)
  (let* ((line-no             (flymake-current-line-no))
         (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (message-data        (flymake-make-err-menu-data line-no line-err-info-list)))
    (if message-data (progn (princ (car message-data) t)
                            (mapcar (lambda (m) 
                                      (terpri t)
                                      (princ (caar m) t))
                                    (cdr message-data)))
      (flymake-log 1 "no errors for line %d" line-no))))

(defun flymake-mode-on-without-check ()
  "Turn flymake-mode on without the initial check"
  (let ((flymake-start-syntax-check-on-find-file nil))
    (flymake-mode-on)))

(defun flymake-load-and-check-if-not-loaded (trigger-type)
  "If flymake is not loaded, load and start a check and return t. Otherwise return nil."
  (if flymake-mode 
      nil
    (flymake-mode-on-without-check)
    (flymake-start-syntax-check trigger-type)
    t))
  
(defun show-next-flymake-error ()
  "Load flymake.el if necessary. Jump to next error and display it."
  (interactive)
  (when (not (flymake-load-and-check-if-not-loaded "edit"))
    ;; if the cursor is on an error line and the user didn't just
    ;; cycle through error lines, just show the error of the current
    ;; line and don't skip to the next one
    (when (or (member last-command '(show-next-flymake-error show-prev-flymake-error))
              (not (flymake-errors-on-current-line)))
      (flymake-goto-next-error))
    (flymake-display-err-message-for-current-line)))

(defun show-prev-flymake-error ()
  "Jump to the previous flymake error and display it"
  (interactive)
  (when (not (flymake-load-and-check-if-not-loaded "edit"))
    (flymake-goto-prev-error)
    (flymake-display-err-message-for-current-line)))

(defun load-flymake-and-force-syntax-check ()
  "Load flymake.el if it was not loaded and start a check"
  (interactive)
  (flymake-mode-on-without-check)
  (flymake-start-syntax-check "force"))

(defun enable-flymake-check-on-edit ()
  "Re-enable check-on-edit after a save or forced check disabled it"
  (interactive)
  (setq flymake-no-changes-timeout 0.5)
  (flymake-start-syntax-check "edit"))

(global-set-key [f4] 'show-next-flymake-error)
(global-set-key [S-f4] 'show-prev-flymake-error)
(global-set-key [f6] 'load-flymake-and-force-syntax-check)
(global-set-key [S-f6] 'enable-flymake-check-on-edit)





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

;;; Activate Auto Complete to use rope
;;;(ac-ropemacs-initialize)
;;;(add-hook 'python-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-ropemacs)))
(setq ac-dwim t)
(setq ac-use-quick-help t)

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

;;; Allow workon to ask emacs to reload the "Desktop"
(defun workon-postactivate (virtualenv)
  (require 'virtualenv)
  (virtualenv-activate-environment virtualenv)
  (desktop-change-dir virtualenv))
