;; Setup python mode here


(add-hook 'python-mode-hook 'projectile-on)

;; Enable highlight-indentation
(defun setup-python-mode ()
  (require 'highlight-indentation)
  (highlight-indentation-mode)
 

  (require 'pymacs)
  (autoload 'pymacs-apply "pymacs")
  (autoload 'pymacs-call "pymacs")
  (autoload 'pymacs-eval "pymacs" nil t)
  (autoload 'pymacs-exec "pymacs" nil t)
  (autoload 'pymacs-load "pymacs" nil t)
  (autoload 'pymacs-autoload "pymacs")
  ;;(eval-after-load "pymacs"
  ;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))
  (pymacs-load "ropemacs" "rope-")
  (setq ropemacs-enable-autoimport t)

)

(add-hook 'python-mode-hook 'setup-python-mode)
(provide 'setup-python)
