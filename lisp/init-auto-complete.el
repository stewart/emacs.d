;;; init-auto-complete.el --- Configures auto-complete.

(require-package 'company)
(add-hook 'after-init-hook 'global-company-mode)

(after-load 'company
  (diminish 'company-mode))

(defun stwrt/local-push-company-backend (backend)
    "Add BACKEND to a buffer-local version of `company-backends'."
    (set (make-local-variable 'company-backends)
         (append (list backend) company-backends)))

(provide 'init-auto-complete)
;;; init-auto-complete.el ends here
