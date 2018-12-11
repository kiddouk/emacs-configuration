;;; Setup auto complete in the most classic way
;;; Each setup-<mode> should plug into auto-complete system

(require 'kotlin-mode)
(add-to-list 'compilation-error-regexp-alist '("^:?[a-zA-Z0-9]+: \\(.*?\\): (\\([0-9]+\\), \\([0-9]+\\)): .*?$" 1 2 3))
(provide 'setup-kotlin)
