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
(require 'init-backups)

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

;;----------------------------------------------------------------------------
;; Load mode/feature configs
;;----------------------------------------------------------------------------

;; ~which-key~ is a minor mode for Emacs that displays the key bindings
;; following your currently entered incomplete command (a prefix) in a popup.
(require-package 'which-key)
(which-key-mode)
(diminish 'which-key-mode)

;; diminish is used to hide modeline clutter
(require-package 'diminish)

;; load colorscheme
(require 'init-theme)

(require 'init-helm)
(require 'init-evil)
(require 'init-org)
(require 'init-auto-complete)
(require 'init-flycheck)
