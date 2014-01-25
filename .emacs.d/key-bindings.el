;; Kill Emacs in a very explicit mode
(global-set-key (kbd "C-x r q") 'save-buffers-kill-terminal)
(global-set-key (kbd "C-x C-c") 'delete-frame)

;; Completion that uses many different methods to find options.
(global-set-key (kbd "C-.") 'hippie-expand-no-case-fold)
(global-set-key (kbd "C-:") 'hippie-expand-lines)
(global-set-key (kbd "C-,") 'completion-at-point)

;; Replace The current M-x with Smex
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; This is your old M-x.
(global-set-key (kbd "C-c C-m") 'execute-extended-command)

;; Expand region (increases selected region by semantic units)
(global-set-key (kbd "C-'") 'er/expand-region)

(global-set-key (kbd "C-ø") 'ace-jump-mode)

;; Mark additional regions matching current region
(global-set-key (kbd "M-æ") 'mc/mark-all-like-this-dwim)


;; Cleanup buffer to re-indent the whole file
(global-set-key (kbd "C-c n") 'cleanup-buffer)

(provide 'key-bindings)