;;; Setup org-mode default behavior

;;; Read the comments along to understand what we are trying to acheive.
;;; most of those setting are taken from: https://mstempl.netlify.com/post/beautify-org-mode/

(require 'org)
(setq org-directory "~/notes")

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
(setq-default prettify-symbols-alist '(("#+BEGIN_SRC" . "λ")
                                       ("#+END_SRC" . "λ")
                                       ("#+begin_src" . "†")
                                       ("#+end_src" . "λ")
                                       (">=" . "≥")
                                       ("=>" . "⇨")))
(setq prettify-symbols-unprettify-at-point 'right-edge)
(add-hook 'org-mode-hook 'prettify-symbols-mode)


;;; We now want fixed-pitch for any source code and we use source-code font. Since source code is width-fixed, it will do the trick automatically
(custom-theme-set-faces
 'user
 '(variable-pitch ((t (:family "Source Sans Pro" :height 120 :weight normal))))
 '(fixed-pitch ((t (:family "Source Code Pro" :height 0.9 :width normal :weight normal))))
 '(org-block                 ((t (:inherit fixed-pitch))))
 '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
 '(org-property-value        ((t (:inherit fixed-pitch))) t)
 '(org-special-keyword       ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-tag                   ((t (:inherit (shadow fixed-pitch) :weight bold))))
 '(org-verbatim              ((t (:inherit (shadow fixed-pitch))))))



;;; Configure org-refile to read all of the files that are currently opened
(defun +org/opened-buffer-files ()
  "Return the list of files currently opened in emacs"
  (delq nil
        (mapcar (lambda (x)
                  (if (and (buffer-file-name x)
                           (string-match "\\.org$"
                                         (buffer-file-name x)))
                      (buffer-file-name x)))
                (buffer-list))))

(setq org-refile-targets '((+org/opened-buffer-files :maxlevel . 3)))
(setq org-refile-use-outline-path 'file)

;;; Capture sutff
(setq org-default-notes-file (concat org-directory "/inbox.org"))

;;; Useful templates for caputing efficiently
(setq org-capture-templates
      '(("t" "Simple Todo" entry (file+headline "~/notes/inbox.org" "Tasks")
         "* TODO %^{Todo} %^g \n:PROPERTIES:\n:Created: %U\n:END:\n\n%?\n" :prepend t :empty-lines 1 :created 1)
        ("r" "Reference" entry (file+headline "~/notes/inbox.org" "References")
         "* Ref %^{Url} %^g \n:PROPERTIES:\n:Created: %U\n:END:\n\n%?\n" :prepend t :empty-lines 1 :created 1)))


(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))
(setq org-agenda-files '("~/notes/inbox.org"
                         "~/notes/gtd.org"
                         "~/notes/tickler.org"
                         "~/notes/ufst.org"))


;;; GTD specific
;;; Allow the agenda to show the next action only for each project
(setq org-agenda-custom-commands 
      '(("o" "At the office" tags-todo "@office"
         ((org-agenda-overriding-header "Office")
          (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))))

(defun my-org-agenda-skip-all-siblings-but-first ()
  "Skip all but the first non-done entry."
  (let (should-skip-entry)
    (unless (org-current-is-todo)
      (setq should-skip-entry t))
    (save-excursion
      (while (and (not should-skip-entry) (org-goto-sibling t))
        (when (org-current-is-todo)
          (setq should-skip-entry t))))
    (when should-skip-entry
      (or (outline-next-heading)
          (goto-char (point-max))))))
		  
(defun org-current-is-todo ()
  (string= "TODO" (org-get-todo-state)))

;;; Shortcuts
;;; C-c k (capture)

;;; C-c o d (deadline)

;;; C-c C-q (tag entry)

;;; C-c t (sparse-tree on tools)

(provide 'setup-org)
