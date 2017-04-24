
;; Info directory
(add-to-list 'Info-additional-directory-list
             (expand-file-name "~/.emacs.d/elisp/org-mode/info"))

;; This sets up the load path so that we can override it
(package-initialize)
;; Override the packages with the git version of Org and other packages
(add-to-list 'load-path "~/.emacs.d/elisp/org-mode/lisp")
(add-to-list 'load-path "~/.emacs.d/elisp/org-mode/contrib/lisp")
(setq package-enable-at-startup nil)
(setq custom-file "~/.emacs.d/custom-settings.el")
(load custom-file t)

(setq user-full-name "Ryan Woodard"
      user-mail-address "ryan@timehaven.org")

(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
;  (package-refresh-contents)
)

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
