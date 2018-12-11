(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))


(defun cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer.
Including indent-buffer, which should not be called automatically on save."
  (interactive)
  (untabify-buffer)
  (delete-trailing-whitespace)
  (indent-buffer))

(defun electric-pair ()
  "Insert character pair without surrounding spaces"
  (interactive)
  (let (parens-require-spaces)
    (insert-pair)))

(defun gradle-mode-maybe ()
  "Activate gradle mode if a gradle file is found.
   Assumes: Projectile mode activated."
  (when (bound-and-true-p projectile-mode)
    (when (projectile-verify-file "build.gradle")
      (gradle-mode))

    (when (and (bound-and-true-p gradle-mode) (projectile-verify-file "gradlew"))
      (set 'gradle-use-gradlew t)
      (set 'gradle-gradlew-executable "./gradlew")
     )))

