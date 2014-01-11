;; Default keybindingsin emacs 24, as far as I can tell by searching
;; for '<f' in output of M-x describe-bindings.
;;
;; <f1>		help-command
;; <f1> 4 i	info-other-window
;;
;; <f2>		2C-command
;; <f2> 2		2C-two-columns
;; <f2> b		2C-associate-buffer
;; <f2> s		2C-split
;; <f2> <f2>	2C-two-columns
;;
;; <f3>		kmacro-start-macro-or-insert-counter
;; <f4>		kmacro-end-or-call-macro
;;
;; <f10>		menu-bar-open
;; ESC <f10>	toggle-frame-maximized
;;
;; <f11>		toggle-frame-fullscreen
;;
;;
;; So available for users:  f5-f9, f12, all shift/ctrl/meta.

;; To see all keybindings starting with, say, f2, do:  f2 f1
;; http://stackoverflow.com/questions/10330510/show-emacs-keybindings-which-start-with-a-particular-key?lq=1


;; To bind a key in a mode, you need to wait for the mode to be loaded
;; before defining the key. One could require the mode, or use
;; eval-after-load
;;
;; (eval-after-load 'latex
;;   '(define-key LaTeX-mode-map [(tab)] 'outline-cycle)))
;;
;; Don't forget either ' eval-after-load is not a macro, so it needs them.

;; OVERWRITE DEFAULT.
(global-set-key [f1] 'delete-other-windows)

;; OVERWRITE DEFAULT.
(fset 'smart-split-vertical
   [?\C-x ?2 ?\C-x ?o ?\C-x ?b return])
(fset 'smart-split-horizontal
   [?\C-x ?3 ?\C-x ?o ?\C-x ?b return])
(global-set-key [f2] 'smart-split-vertical)
(global-set-key [S-f2] 'smart-split-horizontal)

;; OVERWRITE DEFAULT.
(global-set-key [f3] 'bury-buffer)

;; OVERWRITE DEFAULT.
(global-set-key [f4] 'delete-window)

(global-set-key [f5] [?\C-x ?b return]) ;; Switch to previous buffer

(global-set-key [f6] 'other-window)

(global-set-key [f7] 'split-esh1)
(global-set-key [C-f7] 'split-ipy1)
(global-set-key [M-f7] 'split-term1)
(global-set-key [S-f7] 'eshell)
(global-set-key [S-C-f7] 'new-ansi-term)

;;(global-set-key [f8] 'bs-show) ;; See all buffers summary
(global-set-key [f8] 'helm-mini)
(global-set-key [C-f8] 'bs-show-one-window)

;;(global-set-key [f10] 'find-file-at-point)
;; (global-set-key [f10] 'ido-find-file)
;; (global-set-key [C-f10] 'info)
;; (global-set-key [M-f10] 'tmm-menubar)
;; (global-set-key [S-f10] 'end-of-buffer)
;; (global-set-key [S-C-f10] 'insert-kbd-macro)

;; OVERWRITE DEFAULT.
(global-set-key [f11] 'save-buffer)

(global-set-key [f12] 'eval-region) ;; lisp
(global-set-key [S-f12] 'speedbar-get-focus)
;; awesomeness from http://www.emacswiki.org/emacs/ToolBar and tool-bar+.el
;;(global-set-key [S-C-f12] 'show-tool-bar-for-one-command)

;; (global-set-key [C-next] 'tabbar-forward-tab)
;; (global-set-key [C-prior] 'tabbar-backward-tab)

;; (global-set-key (kbd "<home>") 'move-beginning-of-line)
;; (global-set-key (kbd "<end>") 'move-end-of-line)
