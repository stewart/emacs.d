;;; init-elpa.el --- Initializes ELPA and package.el

(require 'package)

;; warn if local package.el is installed
(let ((local-package-el (locate-library "package")))
  (when (string-match-p (concat "^" (regexp-quote user-emacs-directory))
                        local-package-el)
    (warn "Please remove the local package.el, which is no longer supported (%s)"
          local-package-el)))

;;; use separate package dirs for each Emacs version, for compatability
(let ((versioned-package-dir
       (expand-file-name (format "elpa-%s.%s" emacs-major-version emacs-minor-version)
                         user-emacs-directory)))
  (when (file-directory-p package-user-dir)
    (message "Default package locations have changed in this config: renaming old package dir %s to %s."
             package-user-dir
             versioned-package-dir)
    (rename-file package-user-dir versioned-package-dir))
  (setq package-user-dir versioned-package-dir))


;; add repositories to package.el
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))


;; ----------------------------------------------------------------------------
;; On-demand installation of packages
;; ----------------------------------------------------------------------------

(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (if (boundp 'package-selected-packages)
            ;; Record this as a package the user installed explicitly
            (package-install package nil)
          (package-install package))
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

(defun maybe-require-package (package &optional min-version no-refresh)
  "Try to install PACKAGE, and return non-nil if successful.
In the event of failure, return nil and print a warning message.
Optionally require MIN-VERSION.  If NO-REFRESH is non-nil, the
available package lists will not be re-downloaded in order to
locate PACKAGE."
  (condition-case err
      (require-package package min-version no-refresh)
    (error
     (message "Couldn't install optional package `%s': %S" package err)
     nil)))

;; ----------------------------------------------------------------------------
;; Initialize package.el
;; ----------------------------------------------------------------------------

(setq package-enable-at-startup nil)
(package-initialize)

(require-package 'fullframe)
(fullframe list-packages quit-window)

(provide 'init-elpa)
;;; init-elpa.el ends here
