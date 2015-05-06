;;; Setup auto complete in the most classic way
;;; Each setup-<mode> should plug into auto-complete system

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

(ac-set-trigger-key "TAB")

(provide 'setup-auto-complete)
