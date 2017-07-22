;;; init-basic.el --- Basic configuration

;; set file used by customize interface
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;; load variables configured via the customize interface
(when (file-exists-p custom-file)
    (load custom-file))

;; disable toolbar
(tool-bar-mode -1)

;; disable startup screen
(setq inhibit-startup-screen t)

;; disable startup screen
(setq inhibit-startup-message t)

;; disable macOS native fullscreen
(setq ns-use-native-fullscreen nil)

;; Always load newest byte code
(setq load-prefer-newer t)

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

;; Enable spell checking by changing this to `t`
(defconst *spell-check-support-enabled* nil)

;; Whether or not we're on a macOS device.
(defconst *is-a-mac* (eq system-type 'darwin))

(provide 'init-basic)
;;; init-basic.el ends here
