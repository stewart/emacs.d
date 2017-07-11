;;; setup-evil.eil --- Make Emacs a little bit more Evil.

(use-package evil
  :ensure t
  :init (evil-mode 1))

(use-package evil-exchange
  :ensure t
  :defer t
  :init (evil-exchange-install))

(use-package evil-surround
  :ensure t
  :defer t
  :init (global-evil-surround-mode 1))

(provide 'setup-evil)
;;; setup-evil.el ends here
