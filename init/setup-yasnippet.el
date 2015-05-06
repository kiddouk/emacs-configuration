;;; Setup Yasnippet default behavior

;; Enable yassnippet for snippet completion
;;; By default, the TAB key is used and fall back to whatever
;;; action is what suppose to do (code completion, then indentation fix)
(require 'yasnippet)
(setq yas-snippet-dirs '("~/.emacs.d/snippets" "~/.emacs.d/elpa/yasnippet/snippets"))
(yas-global-mode 1)

(provide 'setup-yasnippet)