;; Method from:
;;
;; http://orgmode.org/worg/org-contrib/babel/intro.html
;;
;;; init.el --- Where all the magic begins
;;
;; This file loads Org-mode and then loads the rest of our Emacs
;; initialization from Emacs lisp embedded in literate Org-mode files.

;; Load up Org Mode and (now included) Org Babel for elisp embedded in
;; Org Mode files



;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;(package-initialize)

(setq visible-bell t)
(tool-bar-mode -1)


(setq this-dir (file-name-directory (or (buffer-file-name) load-file-name)))


;;;;;
;;
;; org mode
;;
;; The only real code in here.
;;
;; It's all about org-mode.  Use the latest and greatest.
(let*

    ;; local vars
    ((org-src-dir (concat this-dir "elisp/org-mode/"))
     (org-doc-dir (concat org-src-dir "doc")))

  ;; code that uses the local vars
  (mapc (lambda (path)
	  (add-to-list 'load-path path))
	(list
	 (concat org-src-dir "lisp")
	 (concat org-src-dir "contrib/lisp")))

  ;; Info directory
  ;; These directories are searched after those in ‘Info-directory-list’.
  ;; (setq Info-additional-directory-list
  ;;       (cons (concat org-mode-src-dir "doc")
  ;; 	    Info-default-directory-list))
  (setq Info-additional-directory-list Info-default-directory-list)

  (if (boundp 'Info-directory-list)
      (setq Info-directory-list (cons org-doc-dir Info-directory-list))
    (setq Info-directory-list (list org-doc-dir))))

(require 'org-install)
(require 'ob-tangle)
;;
;;
;;;;;



;; https://www.emacswiki.org/emacs/FullScreen#toc26
(set-frame-parameter nil 'fullscreen 'fullboth)


;; Load the rest of it.
;;(org-babel-load-file (concat this-dir "emacs_test.org"))
(org-babel-load-file (concat this-dir "emacs.org"))
;;(org-babel-load-file "/Users/rwoodard/.emacs.d/emacs.org")

;; Works to org-babel-load-file all *.org files in this-dir.
;;(mapc #'org-babel-load-file (directory-files this-dir t "\\.org$"))


;; Initial files to load
(mapcar (lambda (path) (find-file path))
	(list 
	 "~/.emacs.d/zunused/ryan.org"
	 "~/.emacs.d/rw/rw_keys.el"
	 "~/.emacs.d/emacs.org"
	 "~/.emacs.d/init.el"
	 ))

;;; init.el ends here
