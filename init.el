;; Misc.
(setq inhibit-startup-message t) ; it is a lovely picture of a gnu, though
(setq visible-bell t) ; Get rid of annoying beep.
;;(tool-bar-mode 0) ; off
(setq column-number-mode t)


;; Do not show backslash at end of wrapped line.
;; (Convenient for copy/paste to shell.)
;; http://www.emacswiki.org/emacs/LineWrap
(set-display-table-slot standard-display-table 'wrap ?\ )


;; org
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)


;; ido
(require 'ido)
(ido-mode t)
(ido-everywhere t)
(setq ido-enable-flex-matching t)  ;; 'aa' matches 'alpha'
(setq ido-use-filename-at-point t)


;; dired
;; So do not created many dired buffers.
;;(dired-toggle-find-file-reuse-dir 1)


;; zsh mode when loading in .zsh* files.
;; http://stackoverflow.com/questions/20558402/open-zsh-scripts-in-sh-mode-in-emacs
(add-to-list 'auto-mode-alist '("\\.zsh*" . sh-mode))
(add-hook 'sh-mode-hook
	  (lambda ()
	    (if (string-match "\\.zsh*" buffer-file-name)
		(sh-set-shell "zsh"))))



;; My stuff.
;; Function keys
(add-to-list 'load-path "~/.emacs.d/rw")
(load-library "rw_funcs")
(load-library "rw_keys")



;; At end?
(desktop-save-mode 1)
(add-to-list 'desktop-path "~/.emacs.d")
(setq desktop-save t) 
;; The default desktop is loaded anyway if it is locked
(setq desktop-load-locked-desktop t)
(desktop-read)
(put 'dired-find-alternate-file 'disabled nil)
