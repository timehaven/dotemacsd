;; Readability counts.
(when (eq system-type 'gnu/linux)
  ;; Readable font
  (set-face-attribute 'default nil :height 200)
  ;; Frame sizes.
  (add-to-list 'initial-frame-alist '(height . 55))
  (add-to-list 'initial-frame-alist '(width . 80))
  (add-to-list 'default-frame-alist '(height . 55))
  (add-to-list 'default-frame-alist '(width . 80))
  )

;; Info directory

(setq Info-additional-directory-list
      (cons (expand-file-name "~/.emacs.d/elisp/org-mode/doc")
	    Info-default-directory-list))

;; This sets up the load path so that we can override it
(package-initialize)

;; Override the packages with the git version of Org and other packages
(add-to-list 'load-path "~/.emacs.d/elisp/org-mode/lisp")
(add-to-list 'load-path "~/.emacs.d/elisp/org-mode/contrib/lisp")
(setq package-enable-at-startup nil)
(setq custom-file "~/.emacs.d/custom-settings.el")
(load custom-file t)

;; Who am I?
(setq user-full-name "Ryan Woodard"
      user-mail-address "ryan@timehaven.org")

;; Modern emacs packaging.
(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  ;;(package-refresh-contents)
)

;; (setq package-archives
;;       '(("GNU ELPA"     . "http://elpa.gnu.org/packages/")
;;         ("MELPA Stable" . "https://stable.melpa.org/packages/")
;;         ("MELPA"        . "https://melpa.org/packages/"))
;;       package-archive-priorities
;;       '(("MELPA Stable" . 0)
;;         ("GNU ELPA"     . 5)
;;         ("MELPA"        . 10)))
;; (when (not package-archive-contents)
;;   (package-refresh-contents))

(add-to-list 'load-path "~/.emacs.d/elisp")

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(setq use-package-verbose t)
(setq use-package-always-ensure t)

(require 'use-package)

(use-package auto-compile
  :config (auto-compile-on-load-mode))

(setq load-prefer-newer t)

(load "~/.emacs.secrets" t)

(use-package magit)
(global-set-key (kbd "C-x g") 'magit-status)
