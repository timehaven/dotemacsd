;; Put your customizations here.

;; (org-babel-load-file (concat user-emacs-directory "emacs.org"))
;; (org-babel-load-file (expand-file-name "emacs.org" user-emacs-directory))

;; (org-babel-load-file
;;  (expand-file-name "ryan_after_scimax.org" user-emacs-directory))

(setq my/startupstuff "~/github/timehaven/dotemacsd/for_scimax_standalone/ryan_after_scimax.org")
(message (concat "org-babel-loading file " my/startupstuff))
(org-babel-load-file my/startupstuff)
(message "Completed babeling.")
