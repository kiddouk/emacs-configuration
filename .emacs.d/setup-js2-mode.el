;;; Setup JS2 mode with a lot of tweaks.

(require 'js2-mode)
(setq-default js2-enter-indents-newline nil)
(setq-default js2-global-externs '("module" "require" "buster" "sinon" "assert" "refute" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "__dirname" "console" "JSON"))
(setq-default js2-idle-timer-delay 0.1)
(setq-default js2-auto-indent-p t)


;;; Let flycheck handle parse errors
(setq-default js2-show-parse-errors nil)
(setq-default js2-strict-missing-semi-warning nil)
(setq-default js2-strict-trailing-comma-warning t) ;; jshint does not warn about this now for some reason
(add-hook 'js2-mode-hook (lambda () (flycheck-mode 1)))


(define-key js2-mode-map (kbd ";")
  (lambda (if (looking-at ";")
         (forward-char)
       (funcall 'self-insert-command 1))))


(provide 'setup-js2-mode)
