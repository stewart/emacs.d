(defun stwrt/time-subtract-millis (b a)
  (* 1000.0 (float-time (time-subtract b a))))

(defvar stwrt/require-times nil
  "A list of (FEATURE . LOAD-DURATION).
LOAD-DURATION is the time taken in milliseconds to load FEATURE.")

(defadvice require (around stwrt/build-require-times (feature &optional filename noerror) activate)
  "Note in `stwrt/require-times' the time taken to require each feature."
  (let* ((already-loaded (memq feature features))
         (require-start-time (and (not already-loaded) (current-time))))
    (prog1
        ad-do-it
      (when (and (not already-loaded) (memq feature features))
        (let ((time (stwrt/time-subtract-millis (current-time) require-start-time)))
          (add-to-list 'stwrt/require-times
                       (cons feature time)
                       t))))))

(defun stwrt/show-init-time ()
  (message "init completed in %.2fms"
           (stwrt/time-subtract-millis after-init-time before-init-time)))

(add-hook 'after-init-hook 'stwrt/show-init-time)


(provide 'init-benchmarking)
