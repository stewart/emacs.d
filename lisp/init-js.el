;;; init-js.el --- Provides support for editing JavaScript.

;;; Commentary:

;;; Code:

(require-package 'js2-mode)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js2-jsx-mode))

(provide 'init-js)
;;; init-js.el ends here
