;;; Setup org-mode default behavior

;;; Read the comments along to understand what we are trying to acheive.
;;; most of those setting are taken from: https://mstempl.netlify.com/post/beautify-org-mode/

(require 'org)

;;; We now use symbola globally to ensure that all the symbols are rendered correctly
(when (member "Symbola" (font-family-list))
  (set-fontset-font "fontset-default" nil
                    (font-spec :size 28 :name "Symbola")))


;;; Specify symbola for all the unicode characters
(when (member "Symbola" (font-family-list))
  (set-fontset-font t 'unicode "Symbola" nil 'prepend))

;;; use utf8-encoding everywhere
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

;;; Org mode configuration goes here
;;; we want indentation to work in orgmode

(setq org-startup-indented t
      org-src-tab-acts-natively t)

;;; enable visual-pitch-mode and visual-line-mode
(add-hook 'org-mode-hook
          (lambda ()
            (variable-pitch-mode 1)
            visual-line-mode))


;;; dont display emphasis markers
;;; change the face of the headline when "DONE"
;;; hide the stars
;;; entities shall be utf-8
;;; odd levels only
(setq org-hide-emphasis-markers t
      org-fontify-done-headline t
      org-hide-leading-stars t
      org-pretty-entities t
      org-odd-levels-only t)


;;; We set a better list of bullets than the original ones

(setq org-list-demote-modify-bullet
      (quote (("+" . "-")
              ("-" . "+")
              ("*" . "-")
              ("1." . "-")
              ("0)" . "-")
              ("A)" . "-")
              ("B)" . "-")
              ("a)" . "-")
              ("b)" . "-")
              ("A." . "-")
              ("B." . "-")
              ("a." . "-")
              ("b." . "-"))))


;;; uses org-bullets in order to define the bullets symbols properly.
;;; since we display only the odd-ones, the even-ones dont really matter.
(use-package org-bullets
  :custom
  (org-bullets-bullet-list '("◉" "☯" "○" "☯" "✸" "☯" "✿" "☯" "✜" "☯" "◆" "☯" "▶"))
  (org-ellipsis "⤵")
  :hook (org-mode . org-bullets-mode))


;;; from https://zzamboni.org/post/beautifying-org-mode-in-emacs/ , we replace all dashes with a nice bullet

(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
(font-lock-add-keywords 'org-mode
                        '(("^ *\\([+]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "◦"))))))


;;; from: https://www.reddit.com/r/emacs/comments/9lpupc/i%5Fuse%5Fmarkdown%5Frather%5Fthan%5Forgmode%5Ffor%5Fmy%5Fnotes/
;;; we pretify the Souce blocks by removing the +BEGIN_SRC and all shit with a simple symbol



(setq-default prettify-symbols-alist '(("#+BEGIN_SRC" . "†")
                                       ("#+END_SRC" . "†")
                                       ("#+begin_src" . "†")
                                       ("#+end_src" . "†")
                                       (">=" . "≥")
                                       ("=>" . "⇨")))
(setq prettify-symbols-unprettify-at-point 'right-edge)
(add-hook 'org-mode-hook 'prettify-symbols-mode)


;;; We now want fixed-pitch for any source code and we use source-code font.
(custom-theme-set-faces
 'user
 '(variable-pitch ((t (:family "Source Sans Pro" :height 120 :weight normal))))
 '(fixed-pitch ((t (:family "Source Code Pro" :height -2.9 :width normal :weight normal))))
 '(org-block                 ((t (:inherit fixed-pitch))))
 '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
 '(org-property-value        ((t (:inherit fixed-pitch))) t)
 '(org-special-keyword       ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-tag                   ((t (:inherit (shadow fixed-pitch) :weight bold))))
 '(org-verbatim              ((t (:inherit (shadow fixed-pitch))))))


(provide 'setup-org)
