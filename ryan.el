(global-set-key [home] 'move-beginning-of-line)
(global-set-key [end] 'move-end-of-line)


;; (setq org-use-speed-commands t)  ;; Way cool!
;; For example, to activate speed commands when the point is on any
;; star at the beginning of the headline, you can do this:
;; (setq org-use-speed-commands
;; 	(lambda () (and (looking-at org-outline-regexp) (looking-back "^\**"))))

;; check OS type
(setq is-linux nil)
(setq is-mac nil)
(cond
 ((string-equal system-type "darwin") ; Mac OS X
  (progn
    (message "Mac OS X")
    (setq is-mac t)))
 ((string-equal system-type "gnu/linux") ; linux
  (progn
    (message "Linux")
    (setq is-linux t))))

;; check emacs version
(if (version< emacs-version "25.1")
    ((message "Old Emacs, YMMV")
     (kill-emacs))
  (message "Why not try 26.1?"))

(message "Spinning up %s@%s using %s"
	 system-name
	 user-login-name
	 ;;user-emacs-directory
	 user-init-file)

;;  t for a termcap frame (a character-only terminal),
;; ‘x’ for an Emacs frame that is really an X window,
;; ‘w32’ for an Emacs frame that is a window on MS-Windows display,
;; ‘ns’ for an Emacs frame on a GNUstep or Macintosh Cocoa display,

;; Readability counts.
;; `C-x C-+’ and ‘C-x C--’
;; C-x C-0 to reset.
(when (eq is-linux t)
  ;; Readable font
  (when (eq window-system 'x)
    (set-face-attribute 'default nil :height 260)
    (add-to-list 'initial-frame-alist '(height . 55))
    (add-to-list 'initial-frame-alist '(width . 80))
    (add-to-list 'default-frame-alist '(height . 55))
    (add-to-list 'default-frame-alist '(width . 80))))

(when (eq is-mac t)

  ;; Macbook built-in display.
  (when (eq window-system 'ns)
    ;; On Mac, use Command-t to bring up font menu.
    (set-face-attribute 'default nil :height 240)
    (add-to-list 'initial-frame-alist '(height . 33))
    (add-to-list 'initial-frame-alist '(width . 80))
    (add-to-list 'default-frame-alist '(height . 33))
    (add-to-list 'default-frame-alist '(width . 80))))

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
;; (load custom-file t)

;; Who am I?
(setq user-full-name "Ryan Woodard")
(when (eq user-login-name "ryan")
  (setq user-mail-address "ryan@timehaven.org"))
(when (eq user-login-name 'rwoodard)
  (setq user-mail-address "rwoodard@appnexus.com"))

;; Modern emacs packaging.
(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  (add-to-list 'package-archives '("elpy" . "https://jorgenschaefer.github.io/packages/"))
  ;;(package-refresh-contents)
)
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

(setq org-startup-with-inline-images t)
  (use-package org
    :load-path "~/.emacs.d/elisp/org-mode/lisp"
    :config
    (progn
      (add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
      (org-babel-do-load-languages
       'org-babel-load-languages
       '(
	 ;; (dot . t)
	 ;;   (ditaa . t)
	 (emacs-lisp . t)
	 (ipython . t)
	 (sh . t)
	 ;; (sqlite . t)
	 ;; (http . t)
	 ;; (ledger . t)
	 (shell . t)
	 ;; (R . t)))
	 ))
    (add-to-list 'org-src-lang-modes '("dot" . graphviz-dot))))
    ;;:config

(message (concat "org-version " org-version))
(if (version< org-version "9.0")
      (progn
       (message "Old org.")
       (kill-emacs))
    (message "Why not try 9.1?"))

(defvar my/refile-map (make-sparse-keymap))

(defmacro my/defshortcut (key file)
  `(progn
     (set-register ,key (cons 'file ,file))
     (define-key my/refile-map
       (char-to-string ,key)
       (lambda (prefix)
         (interactive "p")
         (let ((org-refile-targets '(((,file) :maxlevel . 6)))
	       (current-prefix-arg (or current-prefix-arg '(4))))
           (call-interactively 'org-refile))))))

(my/defshortcut ?a "~/org/2017_appnexus_projects.org")
(my/defshortcut ?i "~/.emacs.d/ryan.org")
(my/defshortcut ?p "~/stash/users/rwoodard/slopbucket/packratatat/packratatat.org")
(my/defshortcut ?m "~/org/moe.org")
;; (my/defshortcut ?s "~/personal/sewing.org")
;; (my/defshortcut ?b "~/personal/business.org")
;; (my/defshortcut ?p "~/personal/google-inbox.org")
;; (my/defshortcut ?P "~/personal/google-ideas.org")
;; (my/defshortcut ?B "~/Dropbox/books")
;; (my/defshortcut ?e "~/code/emacs-notes/tasks.org")
;; (my/defshortcut ?w "~/Dropbox/public/sharing/index.org")
;; (my/defshortcut ?W "~/Dropbox/public/sharing/blog.org")
;; (my/defshortcut ?j "~/personal/journal.org")
;; (my/defshortcut ?I "~/Dropbox/Inbox")
;; (my/defshortcut ?g "~/sachac.github.io/evil-plans/index.org")
;; (my/defshortcut ?c "~/code/dev/elisp-course.org")
;; (my/defshortcut ?C "~/personal/calendar.org")
;; (my/defshortcut ?l "~/dropbox/public/sharing/learning.org")
;; (my/defshortcut ?q "~/personal/questions.org")

(setq org-startup-with-inline-images t)

;; capture & refile
;;
;; (require 'org)  ;; In init.el.
(setq org-directory "~/org")
(setq rw/stash-rw-dir "~/stash/users/rwoodard")

(setq rw/slopbucket-dir (concat rw/stash-rw-dir "/" "slopbucket"))

(setq rw/packratatat (concat rw/slopbucket-dir "/packratatat/packratatat.org"))

(setq org-default-notes-file (concat org-directory "/" "an_capture.org"))
(setq org-refile-use-outline-path 'file)

(defun rw/paths-that-exist (paths)
  (delq nil
	(mapcar (lambda (path) (and (file-exists-p path) path)) paths)))

(defun rw/prepend-org-dir (paths)
  (mapcar (lambda (path) (concat org-directory "/" path)) paths)
  )

(setq rw/org-refile-targets
      (rw/paths-that-exist
       (rw/prepend-org-dir
	'(
	  "projects.org"
	  "gtd.org"
	  "blah.org"	  
	  ))))
(add-to-list 'rw/org-refile-targets (concat rw/slopbucket-dir "/packratatat/packratatat.org"))
(add-to-list 'rw/org-refile-targets (concat org-directory "/moe.org"))

(setq org-refile-targets '((rw/org-refile-targets . (:maxlevel . 6))))
;; Using #+STARTUP: lognoterefile  org-log-refile

(setq org-src-window-setup 'current-window)

(use-package magit)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)
(setq global-magit-file-mode t)

(use-package smart-mode-line)

(fset 'yes-or-no-p 'y-or-n-p)

(use-package miniedit
  :commands minibuffer-edit
  :init (miniedit-install))

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
  ;;(set-face-background 'font-lock-string-face "")
  ;;(set-face-background 'font-lock-string-face "black")
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

(eval-after-load 'org
'(define-key org-src-mode-map (kbd "S-<f12>") 'org-edit-src-exit))
(eval-after-load 'org
'(define-key org-mode-map (kbd "S-<f12>") 'org-edit-special))
(eval-after-load 'org
'(define-key org-mode-map (kbd "<f12>") 'org-ctrl-c-ctrl-c))

(global-set-key (kbd "<f12>") 'eval-last-sexp)

;; My stuff.
;; Function keys
(add-to-list 'load-path "~/.emacs.d/rw")
;; (load-library "rw_funcs")
(load-library "rw_keys")

(tool-bar-mode -1)
(setq visible-bell t)
(column-number-mode 1)

;;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph    
    (defun unfill-paragraph (&optional region)
      "Takes a multi-line paragraph and makes it into a single line of text."
      (interactive (progn (barf-if-buffer-read-only) '(t)))
      (let ((fill-column (point-max))
            ;; This would override `fill-column' if it's an integer.
            (emacs-lisp-docstring-fill-column t))
        (fill-paragraph nil region)))

(setq org-structure-template-alist
      '(("s" "#+BEGIN_SRC ?\n\n#+END_SRC" "<src lang=\"?\">\n\n</src>")
        ("e" "#+BEGIN_EXAMPLE\n?\n#+END_EXAMPLE" "<example>\n?\n</example>")
        ("q" "#+BEGIN_QUOTE\n?\n#+END_QUOTE" "<quote>\n?\n</quote>")
        ("v" "#+BEGIN_VERSE\n?\n#+END_VERSE" "<verse>\n?\n</verse>")
        ("c" "#+BEGIN_COMMENT\n?\n#+END_COMMENT")
	("p" "#+BEGIN_SRC ipython\n?\n#+END_SRC" "<src lang=\"ipython\">\n?\n</src>")
        ;;("p" "#+BEGIN_PRACTICE\n?\n#+END_PRACTICE")
        ("l" "#+BEGIN_SRC emacs-lisp :tangle yes\n?\n#+END_SRC" "<src lang=\"emacs-lisp\">\n?\n</src>")
        ("L" "#+latex: " "<literal style=\"latex\">?</literal>")
        ("h" "#+BEGIN_HTML\n?\n#+END_HTML" "<literal style=\"html\">\n?\n</literal>")
        ("H" "#+html: " "<literal style=\"html\">?</literal>")
        ("a" "#+BEGIN_ASCII\n?\n#+END_ASCII")
        ("A" "#+ascii: ")
        ("i" "#+index: ?" "#+index: ?")
        ("I" "#+include %file ?" "<include file=%file markup=\"?\">")))

;; Sacha says: "Since Helm can be a little complex, you may want to
;; start with ido-mode instead."
(ido-mode 1)

(setq Info-directory-list
      (cons (expand-file-name "~/.emacs.d/elisp/org-mode/doc")
	    Info-directory-list))

;; (use-package helm
;;   :diminish helm-mode
;;   :init
;;   (progn
;;     (require 'helm-config)
;;     (setq helm-candidate-number-limit 100)
;;     ;; From https://gist.github.com/antifuchs/9238468
;;     (setq helm-idle-delay 0.0 ; update fast sources immediately (doesn't).
;;           helm-input-idle-delay 0.01  ; this actually updates things
;;                                         ; reeeelatively quickly.
;;           helm-yas-display-key-on-candidate t
;;           helm-quick-update t
;;           helm-M-x-requires-pattern nil
;;           helm-ff-skip-boring-files t)
;;     (helm-mode))
;;   :bind (("C-c h" . helm-mini)
;;          ("C-h a" . helm-apropos)
;;          ("C-x C-b" . helm-buffers-list)
;;          ("C-x b" . helm-buffers-list)
;;          ("M-y" . helm-show-kill-ring)
;;          ("M-x" . helm-M-x)
;;          ("C-x c o" . helm-occur)
;;          ("C-x c s" . helm-swoop)
;;          ("C-x c y" . helm-yas-complete)
;;          ("C-x c Y" . helm-yas-create-snippet-on-region)
;;          ("C-x c b" . my/helm-do-grep-book-notes)
;;          ("C-x c SPC" . helm-all-mark-rings)))
;; (ido-mode -1) ;; Turn off ido mode in case I enabled it accidentally

;; (use-package helm-org-rifle)

;; (use-package helm-descbinds
;;   :defer t
;;   :bind (("C-h b" . helm-descbinds)
;;          ("C-h w" . helm-descbinds)))

;; Standard Jedi.el setting
;; (use-package jedi)
;; (add-hook 'python-mode-hook 'jedi:setup)
;; (setq jedi:complete-on-dot t)

;; Type:
;;     M-x package-install RET jedi RET
;;     M-x jedi:install-server RET
;; Then open Python file.

;; (use-package elpy)
;; (elpy-enable)

;; (setq elpy-rpc-backend "jedi")  

;; (require 'ob-ipython)

;; Use conda env in shell from which Emacs was started!
;;(setq ob-ipython-command "~/local/miniconda3/envs/py27/bin/jupyter")

;; see org-babel stuff for ipython in Org section above

;; http://kitchingroup.cheme.cmu.edu/blog/2017/01/29/ob-ipython-and-inline-figures-in-org-mode/#disqus_thread
;; Intermittent silliness!
;;(require 'cl-lib)  ;; Might be needed with 'loop' error.
(add-to-list 'load-path "~/.emacs.d/elisp/scimax")
(require 'scimax-org-babel-ipython)
