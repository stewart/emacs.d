;;; init-org.el --- Initialize org-mode

(require-package 'org-plus-contrib)

;; ----------------------------------------------------------------------------
;; Key Bindings
;; ----------------------------------------------------------------------------

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

;; ----------------------------------------------------------------------------
;; Settings
;; ----------------------------------------------------------------------------

;; Set directory with org files to ~/org/
(setq org-directory (expand-file-name "~/org/"))

;; Hide leading stars
(setq org-hide-leading-stars t)

;; Set notes file used for capture mode
(setq org-default-notes-file (concat org-directory "notes.org"))

;; Using RET on a hyperlink should follow the link 
(setq org-return-follows-link t)

(provide 'init-org)
;;; init-org.el ends here
