(add-to-list 'load-path "~/.emacs.d/modules/jdee-2.4.1/lisp")

(defun setup-java-mode ()
  (require 'jde)
  (message "JDE enabled")
  (setq jde-enable-abbrev-mode t)
  (setq jde-complete-function (quote jde-complete-menu))
  (setq jde-global-classpath (quote ("/Users/sebastien/android-sdk/platforms/android-22/android.jar")))
  (setq jde-jdk-registry (quote (("1.8.0" . "/Library/Java/JavaVirtualMachines/jdk1.8.0_45.jdk/Contents/Home"))))
  (setq jde-sourcepath (quote ("/Users/kiddouk/code/android/voyr")))
  (setq jde-jdk (quote ("1.8.0")))


  (add-hook 'before-save-hook
            (lambda ()
              (jde-import-kill-extra-imports)
              (jde-import-all)
              (jde-import-organize))
            nil t)
  (add-hook 'after-save-hook 'recompile)

  (add-hook 'java-mode-hook (lambda ()
                              (c-set-offset 'arglist-intro '+)
                              (setq c-basic-offset 4
                                    tab-width 4
                                    indent-tabs-mode t)))


  )

(require 'cl)
;; Helper function to find files. Source: emacswiki
(defun* get-closest-pathname (&optional (file "Makefile"))
  "Determine the pathname of the first instance of FILE starting from the current directory towards root.
This may not do the correct thing in presence of links. If it does not find FILE, then it shall return 
the current directory"
  (let ((root (expand-file-name "/")))
    (loop for d = default-directory 
          then (expand-file-name ".." d)
          if (file-exists-p (expand-file-name file d))  return d
          if (equal d root) return nil)))


(require 'compile)

(defun gradleMake ()
  (unless (file-exists-p "gradlew")
    (set (make-local-variable 'compile-command)
         (let ((mkfile (get-closest-pathname "gradlew")))
           (if mkfile
               (progn (format "cd %s; ./gradlew assembleDebug"
                              mkfile))))))
  (add-to-list 'compilation-error-regexp-alist '(":compile.*?\\(/.*?\\):\\([0-9]+\\): " 1 2)))

(add-hook 'java-mode-hook 'gradleMake)
(add-hook 'java-mode-hook 'setup-java-mode)
(provide 'setup-java)
