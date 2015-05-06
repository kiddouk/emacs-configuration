;;; Setup Slime and SwankJS

(setq inferior-lisp-program "/usr/local/bin/sbcl") ; your Lisp system
(require 'slime)
(slime-setup '(slime-repl slime-js))
(setq slime-js-swank-command "/usr/local/bin/swank-js")
(setq slime-js-swank-args '())

(global-set-key [f5] 'slime-js-reload)
(add-hook 'js2-mode-hook
          (lambda ()
            (slime-js-minor-mode 1)))

(provide 'setup-swank)
