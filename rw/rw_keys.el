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

;; Issues with Mac and iterm2
;; http://stackoverflow.com/questions/19062315/how-do-i-find-out-what-escape-sequence-my-terminal-needs-to-send
;; http://unix.stackexchange.com/questions/53581/sending-function-keys-f1-f12-over-ssh
;; for x in {1..12}; do echo -n "F$x "; tput kf$x | cat -A; echo; done
;; on Mac:  cat -vet
;; F1 ^[OP
;; F2 ^[OQ
;; F3 ^[OR
;; F4 ^[OS
;; F5 ^[[15~
;; F6 ^[[17~
;; F7 ^[[18~
;; F8 ^[[19~
;; F9 ^[[20~
;; F10 ^[[21~
;; F11 ^[[23~
;; F12 ^[[24~

;; 2 Shift
;; 3 Alt
;; 4 Shift + Alt
;; 5 Control
;; 6 Control + Shift

;; http://aperiodic.net/phil/archives/Geekery/term-function-keys.html

;; https://www.google.com/search?q=advantage+pro+kinesis+mac+linux+keys&oq=advantage+pro+kinesis+mac+linux+keys&aqs=chrome..69i57.15589j0j7&sourceid=chrome&es_sm=91&ie=UTF-8#q=advantage+pro+kinesis+mac+linux


;; OVERWRITE DEFAULT.
(global-set-key [f1] 'delete-other-windows)
(global-set-key [S-f1] 'info)

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
;;(global-set-key [f4] 'delete-window)
;; I find that I use kill-buffer more than delete-window.
(global-set-key [f4] 'kill-buffer)

(fset 'f5new
   "\C-xb\C-m")
(global-set-key [f5] 'f5new) ;; Switch to previous buffer
;;(global-set-key [f5] [?\C-x ?b return]) ;; Switch to previous buffer

(global-set-key [f6] 'other-window)

(global-set-key [f7] 'eshell)
;; (global-set-key [f7] 'split-esh1)
;; (global-set-key [C-f7] 'split-ipy1)
;; (global-set-key [M-f7] 'split-term1)
;; (global-set-key [S-f7] 'eshell)
;; (global-set-key [S-C-f7] 'new-ansi-term)


;;(global-set-key [f8] 'ido-switch-buffer) ;; See all buffers summary
;;(global-set-key [f8] 'list-buffers) ;; See all buffers summary
(global-set-key [f8] 'helm-mini)
;;(global-set-key [C-f8] 'bs-show-one-window)



;; default f10 is menu. New way of the world: do not overwrite.
;;(global-set-key [f10] 'find-file-at-point)
;; (global-set-key [f10] 'ido-find-file)
(global-set-key [f10] 'helm-find-files)
;; (global-set-key [C-f10] 'info)
(global-set-key [C-f10] 'tmm-menubar)
(global-set-key [S-f9] 'beginning-of-buffer)
(global-set-key [S-f10] 'end-of-buffer)
;; (global-set-key [S-C-f10] 'insert-kbd-macro)

;; OVERWRITE DEFAULT.
(global-set-key [f11] 'save-buffer)

;; (global-set-key [f12] 'eval-region) ;; lisp
(global-set-key [C-f12] 'eval-last-sexp) ;; lisp
;; (global-set-key [S-f12] 'speedbar-get-focus)
(global-set-key [M-f1] 'sr-speedbar-toggle)

;; awesomeness from http://www.emacswiki.org/emacs/ToolBar and tool-bar+.el
;;(global-set-key [S-C-f12] 'show-tool-bar-for-one-command)

;; (global-set-key [C-next] 'tabbar-forward-tab)
;; (global-set-key [C-prior] 'tabbar-backward-tab)

;; (global-set-key (kbd "<home>") 'move-beginning-of-line)
;; (global-set-key (kbd "<end>") 'move-end-of-line)

;;
;; I want to highlight some shell commands from some doc I am writing
;; and send it directly to a shell to test.  Simple, I would think.
;;
;; The following func and the binding in my-org-keymap allow me to hit
;; f12 at the end of any line within '#+BEGIN_SRC bash' section and
;; send that line to the attached shell.
;;
;; http://stackoverflow.com/questions/6286579/emacs-shell-mode-how-to-send-region-to-shell
;; Return appropriate process based on ansi-term or shell
(defun my/get-proc (pname)

  ;; return process pname if it exists, else nil
  (setq proc (get-process pname))
  (if proc (message "%s %s" "Found existing" pname))

  ;; if proc is nil, do the following
  (unless proc

    ;; save current
    (let (curbuff (current-buffer))

      (message "Saved current buffer: %s." curbuff)

      ;; create desired 
      (when (eq pname "shell")
	(message "making shell")
	(shell))
      (when (eq pname "linked-shell")
	(my/make-linked-shell))
      (when (eq pname "ansi-term")
	(message "ansi-term")
	(ansi-term))
      (message "Made new proc from %s." pname)

      ;; return to current
      (switch-to-buffer curbuff)
      (message "Switched back to curbuff.")

      ;; save new proc
      (setq proc (get-process pname))))

  ;; return the appropriate process
  proc)
(my/get-proc "linked-shell")
(my/get-proc "shell")
(my/get-proc "ansi-term")

(defun sh-send-line-or-region (pname &optional step)

  (interactive ())

  (let

      ((proc (my/get-proc pname))
       pbuf min max command)

    (setq pbuff (process-buffer proc))

    (if (use-region-p)
        (setq min (region-beginning)
              max (region-end))
      (setq min (point-at-bol)
            max (point-at-eol)))

    (setq command (concat (buffer-substring min max) "\n"))

    (with-current-buffer pbuff
      (goto-char (process-mark proc))
      (insert command)
      (move-marker (process-mark proc) (point))
      )  ;;pop-to-buffer does not work with save-current-buffer -- bug?

    (process-send-string proc command)

    (display-buffer (process-buffer proc) t)

    (when step
      (goto-char max)
      (next-line))
    )
  )

;; Change name of shell or term or ansi-term to "linked-shell" to use this.
(defun sh-send-line-or-region-and-not-step ()
  (interactive)
  (sh-send-line-or-region "linked-shell" nil))

(defun sh-send-line-or-region-and-step ()
  (interactive)
  (sh-send-line-or-region "linked-shell" t))

(defun sh-ansi-term-send-line-or-region-and-step ()
  (interactive)
  (sh-send-line-or-region "*ansi-term*" t))


(defun sh-switch-to-process-buffer ()
  (interactive)
  (pop-to-buffer (process-buffer (get-process "shell")) t))


;; (defun my-org-keymap ()
;;   (interactive)
;;   (define-key org-mode-map (kbd "<f12>")
;;     'sh-ansi-term-send-line-or-region-and-step)
;;   (define-key org-src-mode-map (kbd "<f12>")
;;     'sh-ansi-term-send-line-or-region-and-step)
;; )


;; The way to get this to work into a tmux session on a remote machine
;; over ssh:  M-x term, then rename buffer from *term* to *shell*.
;; Running M-x shell, cannot get remote tmux to take, error of:
;;  "open terminal failed: terminal does not support clear"

(defun my/make-linked-shell ()
  (interactive)
  (let ((curbuff (current-buffer))
    (my/term-name "linked-shell"))
    (term-ansi-make-term my/term-name "/bin/bash")
    (switch-to-buffer-other-window my/term-name)
  ))
;; (my/make-linked-shell)
(setq term-scroll-show-maximum-output t)
(setq term-scroll-to-bottom-on-output t)


;; (add-to-list 'load-path "~/.emacs.d/rw")
;; (load-library "rw_keys")
(load-library "rw_org_src_block_functions")


(defun my-org-keymap ()
  (interactive)
  ;; org src block mode mapping
  ;;
  ;; F1, F12
  ;; eval single line, stay
  ;;
  ;; M-F1, M-F12
  ;; eval single line, step
  ;; elpy-shell-send-current-statement (<C-return>)
  ;; (define-key org-src-mode-map (kbd "M-<f12>")
  ;;   'sh-send-line-or-region-and-step)
  ;;
  ;; F2, F11
  ;; eval block, stay
  (define-key org-mode-map (kbd "<M-f2>") 'org-ctrl-c-ctrl-c)
  (define-key org-mode-map (kbd "<M-f11>") 'org-ctrl-c-ctrl-c)

  ;; S-F2, S-F11
  ;; eval block, step to next block
  ;;
  ;; M-F2, M-F11
  ;; eval block, create same new one below
  ;;
  ;;
  ;;
  ;; Block motion
  ;;
  ;; Use F3, F10 to get to heading of this or next block, then normal
  ;; keys to navigate from there (F, B, n, p)
  ;;
  ;; F3
  ;; go to top of this src block, or previous if at top
  ;; (C-c C-v C-u)
  (define-key org-mode-map (kbd "<M-f3>") 'org-previous-block)
  ;;(define-key org-mode-map (kbd "<f3>") 'org-babel-goto-src-block-head)
  ;;  
  ;;
  ;; F10
  ;; go to top of next block
  (define-key org-mode-map (kbd "<M-f10>") 'org-next-block)
  ;;
  ;;
  ;; Block creation
  ;;
  ;; F4
  ;; new block, same as, above
  (define-key org-mode-map (kbd "<M-f4>") 'insert-new-block-same-as-current)
  ;;
  ;; F9
  ;; new block, same as, below
  (define-key org-mode-map (kbd "<M-f9>") 'insert-new-block-same-as-current-below)


  ;;(my-org-keymap)
  (define-key org-mode-map (kbd "<f12>") 'python-shell-send-line)
  ;; f1 and f12 do same things...
  ;; eval and do not step
  ;; (define-key org-mode-map (kbd "<f1>")
  ;;   'sh-send-line-or-region-and-not-step)
  ;; (define-key org-src-mode-map (kbd "<f1>")
  ;;   'sh-send-line-or-region-and-not-step)
  (define-key org-mode-map (kbd "<f12>")
    'sh-send-line-or-region-and-not-step)
  ;; (define-key org-src-mode-map (kbd "<f12>")
  ;;   'sh-send-line-or-region-and-not-step)


;; eval and step
  ;; (define-key org-mode-map (kbd "M-<f1>")
  ;;   'sh-send-line-or-region-and-step)
  ;; (define-key org-src-mode-map (kbd "M-<f1>")
  ;;   'sh-send-line-or-region-and-step)
  (define-key org-mode-map (kbd "M-<f12>")
    'sh-send-line-or-region-and-step)
  (define-key org-src-mode-map (kbd "M-<f12>")
    'sh-send-line-or-region-and-step)

  (eval-after-load 'org
  '(define-key org-src-mode-map (kbd "S-<f12>") 'org-edit-src-exit))
  (eval-after-load 'org
  '(define-key org-mode-map (kbd "S-<f12>") 'org-edit-special))

  

  )
(my-org-keymap)
