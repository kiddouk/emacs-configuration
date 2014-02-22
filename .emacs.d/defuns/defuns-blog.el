(defun jekyll-watch ()
   "Compile the Jekyll project by running rake start
This function doesn't recompile as long as the process is running
in the buffer"
   (interactive)
   (when (buffer-modified-p)
     (when (y-or-n-p "Buffer modified. Do you want to save it first?")
       (save-buffer)
       )
     )
   (message "Compiling...")
   (shell-command cmdStr "*Jekyll watch*")
)

