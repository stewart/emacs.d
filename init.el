(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(defun config-file-path (path)
  "Expands provided PATH into ~/.emacs.d/PATH."
  (expand-file-name path user-emacs-directory))

;; move custom-set-* to a different file
(setq custom-file (config-file-path "custom.el"))
(load custom-file)

;; bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; disable toolbar
(tool-bar-mode -1)

;; disable startup screen
(setq inhibit-startup-screen t)

;; configure backups and autosaves
(let ((backup-dir (config-file-path "backups"))
      (auto-saves-dir (config-file-path "auto-saves")))
  (setq backup-directory-alist `(("." . ,backup-dir))
        auto-save-file-name-transforms `((".*" ,auto-saves-dir t))
        auto-save-list-file-prefix (concat auto-saves-dir ".saves-")))

(setq
  backup-by-copying t
  delete-old-versions t
  version-control t
  kept-new-versions 6
  kept-old-versions 2)

;; disable macOS native fullscreen
(setq ns-use-native-fullscreen nil)

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

(use-package rust-mode
  :ensure t
  :defer t
  :mode "\\.rs\\'"
  :init (progn
    (use-package flycheck-rust
      :ensure t
      :defer t
      :init (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))))
