;; ----------------------------------------------------------------------------
;; Initial Changes
;; ----------------------------------------------------------------------------

;; Check if we're on a known-working version of Emacs
(when (version< emacs-version "25.2")
  (message "This Emacs version is not known to be compatible with this config."))

;; Add ~/.emacs.d/lisp to load path
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'init-benchmarking)
(require 'init-basic)

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

;; require utilities package
(require 'init-utils)

;; set up ELPA + package.el
;; Calls (package-initialize)
(require 'init-elpa)

;;; Backups / Autosaves -------------------------------------------------------

(let ((backup-dir (expand-file-name "backups/" user-emacs-directory))
      (auto-saves-dir (expand-file-name "auto-saves/" user-emacs-directory)))
  (setq backup-directory-alist `(("." . ,backup-dir))
        auto-save-file-name-transforms `((".*" ,auto-saves-dir t))
        auto-save-list-file-prefix (concat auto-saves-dir ".saves-")))

(setq backup-by-copying t
      delete-old-versions t
      version-control t
      kept-new-versions 6
      kept-old-versions 2)
