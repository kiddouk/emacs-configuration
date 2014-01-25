;;; Setup flycheck aka "flymake done right"


(require 'flycheck)

(defun kiddouk/adjust-flycheck-automatic-syntax-eagerness ()
  "Adjust how eager we are syntax checking. We relax if there are not syntax error"
  (setq flycheck-idle-change-delay
    (if flycheck-current-errors 0.5 30.0)))

;; Each buffer get its local flycheck-idle-change-delay since it needs to change

(make-variable-buffer-local 'flycheck-idle-change-delay)

(add-hook 'flycheck-after-syntax-check-hook
          'kiddouk/adjust-flycheck-automatic-syntax-eagerness)

;; We forget here about newlines since we dont want to trigger any
;; syntax check on newlines but rather only when editing / saving / enabling.
(setq flycheck-check-syntax-automatically '(save
                                            idle-change
                                            mode-enabled))


(defun flycheck-handle-idle-change ()
  "Handle an expired idle time since the last change.

;; This is an overwritten version of the original
;; flycheck-handle-idle-change, which removes the forced deferred.
;; Timers should only trigger inbetween commands in a single
;;threaded system and the forced deferred makes errors never show
;; up before you execute another command."
(flycheck-clear-idle-change-timer)
(flycheck-buffer-automatically 'idle-change))



(provide 'setup-flycheck)
