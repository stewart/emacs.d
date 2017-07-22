;; ----------------------------------------------------------------------------
;; Initial Changes
;; ----------------------------------------------------------------------------

;; Add ~/.emacs.d/lisp/ to load path
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; Measure startup time
(require 'init-benchmarking)

;; Enable spell checking by changing this to `t`
(defconst *spell-check-support-enabled* nil)

;; Whether or not we're on a macOS device.
(defconst *is-a-mac* (eq system-type 'darwin))

;; Check if we're on a known-working version of Emacs
(when (version< emacs-version "25.2")
  (message "This Emacs version is not known to be compatible with this config."))

;; ----------------------------------------------------------------------------
;; Reduce GC during startup
;; ----------------------------------------------------------------------------

;; define initial GC threshold
(defconst stwrt/initial-gc-cons-threshold gc-cons-threshold
            "Initial value of `gc-cons-threshold' at start-up time.")

;; set GC threshold to 128MB
(setq gc-cons-threshold (* 128 1024 1024))

;; after initialization, reset GC threshold to initial value
(add-hook 'after-init-hook (lambda ()
  (setq gc-cons-threshold stwrt/initial-gc-cons-threshold)))

;; ----------------------------------------------------------------------------
;; Bootstrap
;; ----------------------------------------------------------------------------

;; set file used by customize interface
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;; require utilities package 
(require 'init-utils)

(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

;; bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;;; Helper Functions ----------------------------------------------------------

(defun config-file-path (path)
  "Expands provided PATH into ~/.emacs.d/PATH."
  (expand-file-name path user-emacs-directory))

;;; Basic Configuration -------------------------------------------------------

;; disable toolbar
(tool-bar-mode -1)

;; disable startup screen
(setq inhibit-startup-screen t)

;; disable macOS native fullscreen
(setq ns-use-native-fullscreen nil)

;; load variables configured via the customize interface
(when (file-exists-p custom-file)
    (load custom-file))

;;; Backups / Autosaves -------------------------------------------------------

(let ((backup-dir (config-file-path "backups/"))
      (auto-saves-dir (config-file-path "auto-saves/")))
  (setq backup-directory-alist `(("." . ,backup-dir))
        auto-save-file-name-transforms `((".*" ,auto-saves-dir t))
        auto-save-list-file-prefix (concat auto-saves-dir ".saves-")))

(setq backup-by-copying t
      delete-old-versions t
      version-control t
      kept-new-versions 6
      kept-old-versions 2)

;;; Load Path Customizations --------------------------------------------------

(add-to-list 'load-path
  (config-file-path "setup"))

;;; Packages ------------------------------------------------------------------

(require 'setup-evil)

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
