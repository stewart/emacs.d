;;; init-js.el --- Provides support for editing JavaScript.

;;; Commentary:

;;; Code:

(require-package 'js2-mode)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js2-jsx-mode))

;; ----------------------------------------------------------------------------
;; Autocomplete
;; ----------------------------------------------------------------------------

(require-package 'company-tern)

(after-load 'js2-mode
  (stwrt/local-push-company-backend 'company-tern))

(provide 'init-js)
;;; init-js.el ends here
