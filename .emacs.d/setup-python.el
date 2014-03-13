;; Setup python mode here


(add-hook 'python-mode-hook 'projectile-on)

;; Enable highlight-indentation
(defun setup-python-mode ()
  (require 'highlight-indentation)
  (highlight-indentation-mode)

   (message "test")


)

(add-hook 'python-mode-hook 'setup-python-mode)
(provide 'setup-python)
