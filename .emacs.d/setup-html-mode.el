(require 'emmet-mode)

(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'sgml-mode-hook 'projectile-on)

(defadvice sgml-delete-tag (after reindent-buffer activate)
  (cleanup-buffer))

(provide 'setup-html-mode)
