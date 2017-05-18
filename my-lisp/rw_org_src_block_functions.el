(defun move-to-end-of-src-block-and-results-plus-line ()
  "Do what the name says."

  ;; Define type of, start and end of block.
  ;; Declare that location will be used.
  (let* ((src (org-element-context))
	 (start (org-element-property :begin src))
	 (end (org-element-property :end src))
	 location)

    (goto-char start)

    ;; Set location to be beginning of results: section, if there is
    ;; one, otherwise nil.
    (setq location (org-babel-where-is-src-block-result nil nil))

    (if (not location)

	;; If there is *not* a results: section, go to end of current
	;; src block.
	(goto-char end)

      ;; If there is a results: section, go to the beginning of it.	
      (goto-char location)

      ;; Now go to end of that results: section.
      (goto-char (org-element-property :end (org-element-context))))

    ;; Two blank lines after end.
    ;;(insert "blah\n\nblah")

    ) ;; let
  )


(defun insert-block-same-as-current (el)
  "docstring"
  (let* ((language (org-element-property :language el))
	 (parameters (org-element-property :parameters el)))
    (beginning-of-line)
    (insert (format "#+BEGIN_SRC %s %s

#+END_SRC\n\n" language parameters)))
  (previous-line)
  (previous-line)
  (previous-line)
  )


(defun move-and-insert-new-block (below)
  "Do two things with one call."
  ;; Find out if we need to go up or down.

  (let* ((el (org-element-context)))

    (if below

	(move-to-end-of-src-block-and-results-plus-line)

      (org-babel-goto-src-block-head)

      ) ;; if below

    (insert-block-same-as-current el)
    )
  )


(defun insert-new-block-same-as-current (&optional below)
  "Insert a src block above the current point.
	  With prefix arg BELOW, insert it below the current point."

  (interactive "P")

  (cond

   ((org-in-src-block-p)

    ;; If we are in a src block, do this stuff.
    (move-and-insert-new-block below))

   ) ;; cond

  ) ;; defun

(defun insert-new-block-same-as-current-below ()
  (interactive)
  (insert-new-block-same-as-current t))


(defun select-current-line ()
  "Select the current line"
  (interactive)
  (end-of-line) ; move to end of line
  (set-mark (line-beginning-position)))


(defun python-shell-send-line ()
  "docstring"
  (interactive)
  ;;(select-current-line)
  (let ((start (line-beginning-position))
  	(end (line-end-position)))
    (python-shell-send-region start end))  ;; part of python mode
  )

;;
;; from
;; https://emacs.stackexchange.com/questions/24190/send-orgmode-sh-babel-block-to-eshell-term-in-emacs
;; needs
;; https://github.com/metaperl/shell-current-directory/blob/master/shell-current-directory.el
;;

;; (use-package shell-current-directory
;;   :bind ("M-S" . shell-current-directory)
;;   :config (load-file (expand-file-name "shell.el"
;; 				       user-emacs-directory)))


;; (defun kdm/sh-send-line-or-region () 
;;   (interactive)
;;   (if (use-region-p) 
;;       (append-to-buffer (get-buffer (directory-shell-buffer-name)) (mark)(point))
;;     (let (p1 p2)
;;       (setq p1 (line-beginning-position))
;;       (setq p2 (line-end-position))
;;       (append-to-buffer (get-buffer (directory-shell-buffer-name)) p1 p2)
;;       ))
;;   (let (b)
;;     (setq b (get-buffer (current-buffer)))
;;     (switch-to-buffer-other-window (get-buffer (directory-shell-buffer-name)))
;;     (execute-kbd-macro "\C-m")
;;     (switch-to-buffer-other-window b)
;;     )
;;   )

;; (global-set-key "\M-s" 'kdm/sh-send-line-or-region)
