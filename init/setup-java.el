(add-to-list 'load-path "~/.emacs.d/modules/jdee-2.4.1/lisp")

(defun setup-java-mode ()
  (require 'jde)
  (message "JDE enabled")
  (setq jde-enable-abbrev-mode t)
  (setq jde-complete-function (quote jde-complete-menu))
  (setq jde-global-classpath (quote ("/Users/sebastien/android-sdk/platforms/android-22/android.jar")))
  (setq jde-jdk-registry (quote (("1.8.0" . "/Library/Java/JavaVirtualMachines/jdk1.8.0_45.jdk/Contents/Home"))))
   (setq jde-sourcepath (quote ("/Users/kiddoun/code/android/voyr")))
   (setq jde-jdk (quote ("1.8.0")))
   )

(add-hook 'java-mode-hook 'setup-java-mode)
(provide 'setup-java)

(setup-java-mode)
