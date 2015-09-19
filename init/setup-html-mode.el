(require 'emmet-mode)
(require 'handlebars-sgml-mode)

(add-hook 'sgml-mode-hook 'emmet-mode)

(defadvice sgml-delete-tag (after reindent-buffer activate)
  (cleanup-buffer))


(provide 'setup-html-mode)
