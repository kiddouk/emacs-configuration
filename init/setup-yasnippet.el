;;; Setup Yasnippet default behavior

;; Enable yassnippet for snippet completion
;;; By default, the TAB key is used and fall back to whatever
;;; action is what suppose to do (code completion, then indentation fix)
(require 'yasnippet)
(setq yas-snippet-dirs '("~/.emacs.d/snippets" "~/.emacs.d/.cask/24.5.1/elpa/java-snippets-20140727.2236/snippets" "~/.emacs.d/.cask/24.5.1/elpa/yasnippet-20150912.1330/snippets"))
(yas-global-mode 1)

(provide 'setup-yasnippet)
