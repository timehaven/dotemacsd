;; See examples at bottom of this file of ways to set keys.

;; Global.

(global-set-key [end]
		'move-end-of-line)
(global-set-key [home]
		'move-beginning-of-line)

;; Make only one window.
(global-set-key [f1]
		'delete-other-windows)

;; Make this window go away.
(global-set-key [S-f1]
		'delete-window)

;; Go to table of key bindings.
(global-set-key [M-f1] 
		(lambda ()
		  (interactive)
		  (bookmark-jump "keys")))

;; Split window in half (top and bottom).
(global-set-key [f2]
		(lambda ()
		  (interactive)
		  (split-window-vertically)
		  (other-window 1)))

;; Split window in half (left and right).
(global-set-key [S-f2]
		(lambda ()
		  (interactive)
		  (split-window-horizontally)
		  (other-window 1)))

;; Bury buffer.
(global-set-key [f3]
		'bury-buffer)

;; Kill buffer (require two key presses since it's a kill).
(global-set-key [S-f3]
		'kill-buffer)

;; Switch to most recent buffer.
(global-set-key [f5]
		(lambda ()
		  (interactive)
		  (switch-to-buffer nil)))

;; JFGI
(global-set-key [S-f5]
		'browse-url)

;; Go to next window.
(global-set-key [f6] 
		(lambda ()
		  (interactive)
		  (other-window 1)))

;; Go to previous window.
(global-set-key [S-f6] 
		(lambda ()
		  (interactive)
		  (other-window -1)))

;; helm version of buffers.
(global-set-key [f8]
		'helm-mini)

;; speedbar
(global-set-key [S-f8]
		'sr-speedbar-toggle)

;; menu that a mouse would find.
(global-set-key [M-f8]
		'tmm-menubar)

;; Info!
(global-set-key [C-f8]
		'info)

;; Top and bottom of buffer.
(global-set-key [S-f9]
		'beginning-of-buffer)

(global-set-key [S-f10]
		'end-of-buffer)

(global-set-key [f10]
		'helm-find-files)

(global-set-key [f11]
		'save-buffer)

(global-set-key [C-f12]
		'eval-last-sexp)



(add-hook 'org-mode-hook
	  (lambda ()

	    (define-key org-mode-map [f4]
	      'org-ctrl-c-ctrl-c)

	    (define-key org-mode-map [f9]
	      'org-previous-block)

	    (define-key org-mode-map [f10]
	      'org-next-block)

	    (define-key org-mode-map [M-f9]
	      'insert-new-block-same-as-current)

	    (define-key org-mode-map [M-f10]
	      'insert-new-block-same-as-current-below)
	    
	    (define-key org-mode-map [S-f4]
		(lambda ()
		  (interactive)
		  (org-ctrl-c-ctrl-c)
		  (org-next-block)))
	    
	    (define-key org-mode-map [M-f4]
		(lambda ()
		  (interactive)
		  (org-ctrl-c-ctrl-c)
		  (insert-new-block-same-as-current-below)))

	    (define-key org-mode-map [M-f12]
	      'org-edit-special)
	    
	    ))


(add-hook 'org-src-mode-hook
	  (lambda ()

	    (define-key org-src-mode-map [M-f12]
	      'org-edit-src-exit)
	    
	    ))


(defun my/eval-line (mode-specific-eval)
  "Send entire current line to sh, elisp, python or whatever."
  (let ((start (line-beginning-position))
	(end (line-end-position)))
    (funcall mode-specific-eval start end)))


(add-hook 'sh-mode-hook
	  (lambda()

	    (define-key sh-mode-map [f12]
	      (lambda ()
		(interactive)
		(my/eval-line 'sh-execute-region)))
	    
	    (define-key sh-mode-map [S-f12]
	      (lambda ()
		(interactive)
		(my/eval-line 'sh-execute-region)
		(end-of-line)
		(newline-and-indent)))

	    ))


(add-hook 'python-mode-hook
	  (lambda()

	    (define-key python-mode-map [f12]
	      (lambda ()
		(interactive)
		(my/eval-line 'python-shell-send-region)))
	    
	    (define-key python-mode-map [S-f12]
	      (lambda ()
		(interactive)
		(my/eval-line 'python-shell-send-region)
		(end-of-line)
		(newline-and-indent)))

	    ))


(add-hook 'emacs-lisp-mode-hook
	  (lambda()
	    
	    (define-key emacs-lisp-mode-map [f12]
	      (lambda ()
		(interactive)
		(my/eval-line 'eval-region)))
	    
	    ))



;; Cool things in term mode.
;;
;; ‘C-c C-l’
;; ‘C-c C-o’


;;;;
;;
;; Examples.
;;
;; From Info, examples of ways to set global keys:
;;
;; (global-set-key (kbd "C-c y") 'clipboard-yank)
;; (global-set-key (kbd "C-M-q") 'query-replace)
;; (global-set-key (kbd "<f5>") 'flyspell-mode)
;; (global-set-key (kbd "C-<f5>") 'linum-mode)
;; (global-set-key (kbd "C-<right>") 'forward-sentence)
;; (global-set-key (kbd "<mouse-2>") 'mouse-save-then-kill)

;; (global-set-key "\C-x\M-l" 'make-symbolic-link)

;; <TAB>
;; (global-set-key "\C-x\t" 'indent-rigidly)

;; (global-set-key [?\C-=] 'make-symbolic-link)
;; (global-set-key [?\M-\C-=] 'make-symbolic-link)
;; (global-set-key [?\H-a] 'make-symbolic-link)
;; (global-set-key [f7] 'make-symbolic-link)
;; (global-set-key [C-mouse-1] 'make-symbolic-link)

;; (global-set-key [?\C-z ?\M-l] 'make-symbolic-link)
