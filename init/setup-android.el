(require 'cedet-android)
(custom-set-variables
 '(semantic-default-submodes (quote (global-semantic-idle-completions-mode global-semantic-idle-scheduler-mode global-semanticdb-minor-mode global-semantic-idle-summary-mode global-semantic-mru-bookmark-mode)))
 '(semantic-idle-scheduler-idle-time 10)
  ;; '(semanticdb-javap-classpath (quote ("/usr/lib/jvm/jdk1.6.0_37/jre/lib/rt.jar")))      
 '(semanticdb-javap-classpath (quote ("/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Classes/classes.jar"))) 
 )
 
;; enable semantic mode with its DB
(semantic-mode 1) 
(global-semanticdb-minor-mode 1)
 
;; 2. use ede to manage project
(global-ede-mode t)
 
;; (ede-java-root-project "just-sample"
;;             :file "~/Documents/code/android/CustomKeyboards/build.gradle"
;;             :srcroot '("/app/src/main")
;;             :localclasspath '("/app/libs/ssa-sdk-5.5.jar")
;;             :classpath '(concat "~/Downloads/android-sdk-macosx/platforms/android-21/android.jar"))
 
;; 3. enable db-javap
(require 'semantic/db-javap)
 
;; 4. enable auto-complete
(require 'semantic/ia)
(defun my-cedet-hook ()
  ;; functions which are disabled
  ;; (local-set-key "\C-cp" 'semantic-ia-show-summary)
  ;; (local-set-key "\C-cl" 'semantic-ia-show-doc)
  ;; (local-set-key "." 'semantic-complete-self-insert)
  ;; (local-set-key ">" 'semantic-complete-self-insert)
  (local-set-key "\M-n" 'semantic-ia-complete-symbol-menu)  ;; auto ompletet by menu
  (local-set-key "\C-c/" 'semantic-ia-complete-symbol)
  (local-set-key "\C-cb" 'semantic-mrub-switch-tags)
  (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  (local-set-key "\C-cR" 'semantic-symref) 
  (local-set-key "\C-cr" 'semantic-symref-symbol)  
  )
(add-hook 'c-mode-common-hook 'my-cedet-hook)
 
;; 5. use four spaces to indent java source
(defun my-java-mode-hook ()
  (setq indent-tabs-mode nil)
  (setq tab-width 4)
  )
(add-hook 'java-mode-hook 'my-java-mode-hook)


;; Load gradle mode for compilation from emacs
(require 'gradle-mode)
(gradle-mode 1)


(provide 'setup-android)
