(add-to-list 'load-path "~/.emacs.d/")
(progn (cd "~/.emacs.d/")
       (normal-top-level-add-subdirs-to-load-path))



(require `tramp)
(require 'python-mode)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(setq ipython-command "/usr/local/bin/ipython")
(require 'ipython)
(require 'lambda-mode)
(add-hook 'python-mode-hook #'lambda-mode 1)
(setq lambda-symbol (string (make-char 'greek-iso8859-7 107)))

(when (require 'anything-show-completion nil t)
   (use-anything-show-completion 'anything-ipython-complete
                                 '(length initial-pattern)))
(require 'comint)
(define-key comint-mode-map (kbd "M-") 'comint-next-input)
(define-key comint-mode-map (kbd "M-") 'comint-previous-input)
(define-key comint-mode-map [down] 'comint-next-matching-input-from-input)
(define-key comint-mode-map [up] 'comint-previous-matching-input-from-input)

(autoload 'pylookup-lookup "pylookup")
(autoload 'pylookup-update "pylookup")
(setq pylookup-program "~/.emacs.d/pylookup/pylookup.py")
(setq pylookup-db-file "~/.emacs.d/pylookup/pylookup.db")
(global-set-key "\C-ch" 'pylookup-lookup)
(require 'w3m-load)
(setq browse-url-browser-function 'w3m-browse-url)

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)


;; 
(autoload 'autopair-global-mode "autopair" nil t)
(autopair-global-mode)
;;(add-hook 'lisp-mode-hook
;;          #'(lambda () (setq autopair-dont-activate t)))

;;(add-hook 'python-mode-hook
;;          #'(lambda ()
;;              (push '(?' . ?')
;;                    (getf autopair-extra-pairs :code))
;;              (setq autopair-handle-action-fns
;;                    (list #'autopair-default-handle-action
;;                          #'autopair-python-triple-quote-action))))


(require 'python-pep8)
(require 'python-pylint)


(add-hook 'before-save-hook 'delete-trailing-whitespace)


(require 'yasnippet)
(require 'smart-operator)
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")




(setq virtual-env (getenv "VIRTUAL_ENV"))

(if (not (equal virtual-env 'nil))
      (setq load-path (append
                 (list (concat virtual-env "/src/pymacs" ))
                 load-path))
      (let ((foo 'bar))
      (require 'pymacs)
      (pymacs-load "ropemacs" "rope-")
      (setq ropemacs-enable-autoimport 't)
      ))


;; Initialize Pymacs                                                                                           
;;(autoload 'pymacs-apply "pymacs")
;;(autoload 'pymacs-call "pymacs")
;;(autoload 'pymacs-eval "pymacs" nil t)
;;(autoload 'pymacs-exec "pymacs" nil t)
;;(autoload 'pymacs-load "pymacs" nil t)
;; Initialize Rope                                                                                             
;;(pymacs-load "ropemacs" "rope-")
;;(setq ropemacs-enable-autoimport t)

;; Initialize Yasnippet                                                                                        
;Don't map TAB to yasnippet                                                                                    
;In fact, set it to something we'll never use because                                                          
;we'll only ever trigger it indirectly.                                                                        
(setq yas/trigger-key (kbd "C-c y"))
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")


(require 'auto-complete)
(global-auto-complete-mode t)



