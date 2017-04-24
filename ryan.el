;; Readability counts.
(when (eq system-type 'gnu/linux)
  ;; Readable font
  (set-face-attribute 'default nil :height 260)
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
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)
(setq global-magit-file-mode t)

;; (defadvice color-theme-alist (around sacha activate)
;;   (if (ad-get-arg 0)
;;       ad-do-it
;;     nil))
(use-package color-theme)
(use-package color-theme-solarized)
(defun my/setup-color-theme ()
  (interactive)
  (color-theme-solarized-dark)
  (set-face-foreground 'secondary-selection "darkblue")
  (set-face-background 'secondary-selection "lightblue")
  (set-face-background 'font-lock-doc-face "black")
  (set-face-foreground 'font-lock-doc-face "wheat")
  (set-face-background 'font-lock-string-face "black")
  (set-face-foreground 'org-todo "green")
  (set-face-background 'org-todo "black"))

(eval-after-load 'color-theme (my/setup-color-theme))

(when window-system
  (custom-set-faces
   '(erc-input-face ((t (:foreground "antique white"))))
   '(helm-selection ((t (:background "ForestGreen" :foreground "black"))))
   '(org-agenda-clocking ((t (:inherit secondary-selection :foreground "black"))) t)
   '(org-agenda-done ((t (:foreground "dim gray" :strike-through nil))))
   '(org-done ((t (:foreground "PaleGreen" :weight normal :strike-through t))))
   '(org-clock-overlay ((t (:background "SkyBlue4" :foreground "black"))))
   '(org-headline-done ((((class color) (min-colors 16) (background dark)) (:foreground "LightSalmon" :strike-through t))))
   '(outline-1 ((t (:inherit font-lock-function-name-face :foreground "cornflower blue"))))))

;; My stuff.
;; Function keys
(add-to-list 'load-path "~/.emacs.d/rw")
;; (load-library "rw_funcs")
(load-library "rw_keys")
