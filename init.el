;; Misc.
(setq inhibit-startup-message t) ; it is a lovely picture of a gnu, though
(setq visible-bell t) ; Get rid of annoying beep.
;;(tool-bar-mode 0) ; off
(setq column-number-mode t)



;; Experiment with packaging.
;; http://stackoverflow.com/questions/14836958/updating-packages-in-emacs
(require 'package)
(setq rw-packages
      '(
	elpy
	helm
	jedi
	magit
	yasnippet
	))

(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives
	     '("org" . "http://orgmode.org/elpa/"))
;; (add-to-list 'package-archives
;;              '("marmalade" . "http://marmalade-repo.org/packages/"))

(when (not package-archive-contents)
  (package-refresh-contents))

(dolist (pkg rw-packages)
  (when (and (not (package-installed-p pkg))
	     (assoc pkg package-archive-contents))
    (package-install pkg)))

(defun package-list-unaccounted-packages ()
  "Like `package-list-packages', but shows only the packages that
  are installed and are not in `rw-packages'.  Useful for
  cleaning out unwanted packages."
  (interactive)
  (package-show-package-list
   (remove-if-not (lambda (x) (and (not (memq x rw-packages))
				   (not (package-built-in-p x))
				   (package-installed-p x)))
		  (mapcar 'car package-archive-contents))))


;; Python:  elpy
(elpy-enable)
(elpy-use-ipython)
(elpy-clean-modeline)
;;
;; To get rid of left highlights:
;; M-x highlight-indentation-mode
;;
;; Also, remove from elpy minor mode.
;; deactivate highlight-indentation-mode
;; https://github.com/chaoflow/.emacs.d/blob/master/setup-python.el
(cl-callf2 delq 'highlight-indentation-mode elpy-default-minor-modes)



;; helm
(global-set-key (kbd "C-c h") 'helm-mini)
(helm-mode 1)


;; Python:  jedi
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)


;; magit
;;(require 'magit)


;; yas
;;(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/elpa/yasnippet-20140106.1009/snippets"
;; 	"~/.emacs.d/elisp/yasnippet-git/yasmate/snippets" ;; yasmate
;; 	"~/.emacs.d/elisp/yasnippet-git/snippets" ;; the default collection
 	))
(yas-global-mode 1) ;; or M-x yas-reload-all if started YASnippet already.


;; python-mode
;; (add-to-list 'load-path "~/.emacs.d/elisp/python-mode-bzr")
;; (setq py-install-directory "~/.emacs.d/elisp/python-mode-bzr")
;; (require 'python-mode)
;; (setq py-shell-name "ipython")


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
