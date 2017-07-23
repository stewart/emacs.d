;;; init-web.el --- Configures web-mode

(require-package 'web-mode)

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(provide 'init-web)
;;; init-web.el ends here
