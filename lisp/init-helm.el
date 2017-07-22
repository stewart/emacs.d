;;; init-helm.el --- Initialize helm

(require-package 'helm)

;; ----------------------------------------------------------------------------
;; Key bindings
;; ----------------------------------------------------------------------------

;; Bind M-x to use Helm
(global-set-key (kbd "M-x") 'helm-M-x)

(provide 'init-helm)
;;; init-helm.el ends here
