(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

;; move custom-set-* to a different file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package evil
  :ensure t
  :init (evil-mode 1))

(use-package helm
  :ensure t
  :bind ("M-x" . helm-M-x))

(use-package company
  :ensure t
  :defer t
  :init (global-company-mode)
  :diminish company-mode)
