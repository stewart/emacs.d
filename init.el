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

;; disable toolbar
(tool-bar-mode -1)

;; configure backups and autosaves
(let ((backup-dir (expand-file-name "backups" user-emacs-directory))
      (auto-saves-dir (expand-file-name "auto-saves" user-emacs-directory)))
  (setq backup-directory-alist `(("." . ,backup-dir))
        auto-save-file-name-transforms `((".*" ,auto-saves-dir t))
        auto-save-list-file-prefix (concat auto-saves-dir ".saves-")))

(setq
  backup-by-copying t
  delete-old-versions t
  version-control t
  kept-new-versions 6
  kept-old-versions 2)

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

(use-package flycheck
  :ensure t
  :defer t
  :init (global-flycheck-mode))

(use-package which-key
  :ensure t
  :defer t
  :init (which-key-mode)
  :diminish which-key-mode)
