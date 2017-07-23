;;; init-auto-complete.el --- Configures auto-complete.

(require-package 'company)
(add-hook 'after-init-hook 'global-company-mode)

(after-load 'company
  (diminish 'company-mode))

(provide 'init-auto-complete)
;;; init-auto-complete.el ends here