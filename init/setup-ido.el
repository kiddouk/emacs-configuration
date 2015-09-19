;; I Do interative shell and the new Sublime 2 inspired fuzzy matching
;; See it in action here : http://www.youtube.com/watch?v=_swuJ1RuMgk
(require 'ido)
(require 'flx-ido)
(require 'ido-vertical-mode)
(ido-mode t)
(ido-everywhere t)
(flx-ido-mode t)
(ido-vertical-mode t)

(provide 'setup-ido)
