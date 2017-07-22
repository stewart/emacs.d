;;; init-backups.el --- Configures Emacs' backups and autosaves

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

(provide 'init-backups)
;;; init-backups.el ends here
