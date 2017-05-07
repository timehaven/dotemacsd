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

  ,#+END_SRC\n\n" language parameters)))
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
  ;;
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
  (define-key org-mode-map (kbd "<f3>") 'org-previous-block)
  ;;(define-key org-mode-map (kbd "<f3>") 'org-babel-goto-src-block-head)
  ;;  
  ;;
  ;; F10
  ;; go to top of next block
  (define-key org-mode-map (kbd "<f10>") 'org-next-block)
  ;;
  ;;
  ;; Block creation
  ;;
  ;; F4
  ;; new block, same as, above
  (define-key org-mode-map (kbd "<f4>") 'insert-new-block-same-as-current)
  ;;
  ;; F9
  ;; new block, same as, below
  (define-key org-mode-map (kbd "<f9>") 'insert-new-block-same-as-current-below)
  )

(my-org-keymap)
