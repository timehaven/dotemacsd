;; https://snarfed.org/why_i_run_shells_inside_emacs

(defvar my-local-shells
  '("*shell0*" "*shell1*"))
;;  '("*shell0*" "*shell1*" "*shell2*" "*shell3*" "*music*"))
(defvar my-remote-shells
  '("*snarfed*" "*heaven0*" "*heaven1*" "*heaven2*" "*heaven3*"))
(defvar my-shells (append my-local-shells my-remote-shells))

(require 'tramp)

(custom-set-variables
 '(tramp-default-method "ssh")          ; uses ControlMaster
 '(comint-scroll-to-bottom-on-input t)  ; always insert at the bottom
 '(comint-scroll-to-bottom-on-output nil) ; always add output at the bottom
 '(comint-scroll-show-maximum-output t) ; scroll to show max possible output
 ;; '(comint-completion-autolist t)     ; show completion list when ambiguous
 '(comint-input-ignoredups t)           ; no duplicates in command history
 '(comint-completion-addsuffix t)       ; insert space/slash after file completion
 '(comint-buffer-maximum-size 20000)    ; max length of the buffer in lines
 '(comint-prompt-read-only nil)         ; if this is t, it breaks shell-command
 '(comint-get-old-input (lambda () "")) ; what to run when i press enter on a
                                        ; line above the current prompt
 '(comint-input-ring-size 5000)         ; max shell history size
 '(protect-buffer-bury-p nil)
)

(setenv "PAGER" "cat")

;; truncate buffers continuously
(add-hook 'comint-output-filter-functions 'comint-truncate-buffer)

(defun make-my-shell-output-read-only (text)
  "Add to comint-output-filter-functions to make stdout read only in my shells."
  (if (member (buffer-name) my-shells)
      (let ((inhibit-read-only t)
            (output-end (process-mark (get-buffer-process (current-buffer)))))
        (put-text-property comint-last-output-start output-end 'read-only t))))
(add-hook 'comint-output-filter-functions 'make-my-shell-output-read-only)

(defun my-dirtrack-mode ()
  "Add to shell-mode-hook to use dirtrack mode in my shell buffers."
  (when (member (buffer-name) my-shells)
    (shell-dirtrack-mode 0)
    (set-variable 'dirtrack-list '("^.*[^ ]+:\\(.*\\)>" 1 nil))
    (dirtrack-mode 1)))
(add-hook 'shell-mode-hook 'my-dirtrack-mode)

; interpret and use ansi color codes in shell output windows
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(defun set-scroll-conservatively ()
  "Add to shell-mode-hook to prevent jump-scrolling on newlines in shell buffers."
  (set (make-local-variable 'scroll-conservatively) 10))
(add-hook 'shell-mode-hook 'set-scroll-conservatively)

;; i think this is wrong, and it buries the shell when you run emacsclient from
;; it. temporarily removing.
;; (defun unset-display-buffer-reuse-frames ()
;;   "Add to shell-mode-hook to prevent switching away from the shell buffer
;; when emacsclient opens a new buffer."
;;   (set (make-local-variable 'display-buffer-reuse-frames) t))
;; (add-hook 'shell-mode-hook 'unset-display-buffer-reuse-frames)

;;
;; RYAN:  must download
;;
;; make it harder to kill my shell buffers
;; http://www.splode.com/~friedman/software/emacs-lisp/
;; (require 'protbuf)
;; (add-hook 'shell-mode-hook 'protect-process-buffer-from-kill-mode)

(defun make-comint-directory-tracking-work-remotely ()
  "Add this to comint-mode-hook to make directory tracking work
while sshed into a remote host, e.g. for remote shell buffers
started in tramp. (This is a bug fix backported from Emacs 24:
http://comments.gmane.org/gmane.emacs.bugs/39082"
  (set (make-local-variable 'comint-file-name-prefix)
       (or (file-remote-p default-directory) "")))
(add-hook 'comint-mode-hook 'make-comint-directory-tracking-work-remotely)

(defun enter-again-if-enter ()
  "Make the return key select the current item in minibuf and shell history isearch.
An alternate approach would be after-advice on isearch-other-meta-char."
  (when (and (not isearch-mode-end-hook-quit)
             (equal (this-command-keys-vector) [13])) ; == return
    (cond ((active-minibuffer-window) (minibuffer-complete-and-exit))
          ((member (buffer-name) my-shells) (comint-send-input)))))
(add-hook 'isearch-mode-end-hook 'enter-again-if-enter)

(defadvice comint-previous-matching-input
    (around suppress-history-item-messages activate)
  "Suppress the annoying 'History item : NNN' messages from shell history isearch.
If this isn't enough, try the same thing with
comint-replace-by-expanded-history-before-point."
  (let ((old-message (symbol-function 'message)))
    (unwind-protect
      (progn (fset 'message 'ignore) ad-do-it)
    (fset 'message old-message))))

(defadvice comint-send-input (around go-to-end-of-multiline activate)
  "When I press enter, jump to the end of the *buffer*, instead of the end of
the line, to capture multiline input. (This only has effect if
`comint-eol-on-send' is non-nil."
  ;;(flet ((end-of-line () (end-of-buffer)))
  (cl-flet ((end-of-line () (end-of-buffer)))
    ad-do-it))

;; not sure why, but comint needs to be reloaded from the source (*not*
;; compiled) elisp to make the above advise stick.
(load "comint.el.gz")

;; for other code, e.g. emacsclient in TRAMP ssh shells and automatically
;; closing completions buffers, see the links above.


;; run a few shells.
(defun start-my-shells ()
  (interactive)
  (let ((default-directory "~")
        ;; trick comint into thinking the current window is 82 columns, since it
        ;; uses that to set the COLUMNS env var. otherwise it uses whatever the
        ;; current window's width is, which could be anything.
        (window-width (lambda () 82)))
    (mapcar 'shell my-local-shells)

    ;; https://snarfed.org/dotfiles/.emacs
    ;; prompt to run this once at startup on mac os x
    ;; (with-current-buffer "*shell0*"
    ;;   (insert "/Users/ryan/src/misc/macosx_startup.sh"))
    ;; (run-python (concat "/usr/local/bin/python -i " (getenv "HOME") "/.python"))
    ;; (with-current-buffer "*Python*" (emacs-lock-mode))

    ;; (async-shell-command
    ;;  "godoc --http=:6060 --index -v --index_files=/usr/local/go/godoc_index"
    ;;  "*godoc*")
    ;; (with-current-buffer "*godoc*" (emacs-lock-mode))
    ))

;; (defadvice start-my-shells (after color-fringe-arrow activate)
;;   "Color the marker arrow (for compilation, debugger, etc.) in the margin.
;; Advice only because it breaks on emacs 23.2 if it runs directly
;; in .emacs at startup. Looks like set-fringe-bitmap-face isn't
;; defined while starting with --daemon, but works fine while
;; starting normally. Grr."
;;   (make-face 'blue-fringe-arrow)
;;   (set-face-attribute 'blue-fringe-arrow nil :foreground "blue")
;;   (if (>= emacs-major-version 23)
;;       (set-fringe-bitmap-face 'right-triangle 'blue-fringe-arrow)))

(when (or window-system (server-running-p))
  (start-my-shells))
