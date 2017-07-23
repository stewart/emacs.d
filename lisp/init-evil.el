;;; init-evil.el --- Installs and configures evil-mode

(require-package 'evil)
(evil-mode 1)

(require-package 'evil-surround)
(global-evil-surround-mode 1)

(require-package 'evil-exchange)
(evil-exchange-install)

(provide 'init-evil)
;;; init-evil.el ends here
