
;; Load ~/.emacs.d/init.el
;; Bound do M-x e
(fset 'e
      [?\C-x ?\C-f ?\C-a ?\C-k ?~ ?/ ?. ?e ?m ?a ?c ?s ?. ?d
             ?/ ?i ?n ?i ?t ?. ?e ?l return])

;; Insert
;            from erpy.ipshell import ipshell
;            ipshell('here')
;;
(fset 'ip
   [home return return up up tab ?f ?r ?o ?m ?  ?e ?r ?p ?y ?. ?i ?p ?s ?h ?e ?l ?l ?\( ?i backspace backspace ?  ?i ?m ?p ?o ?r ?t ?  ?i ?p ?s ?h ?e ?l ?l end home end home down tab ?i ?p ?s ?h ?e ?l ?l ?\( ?\' ?h ?e ?r ?e ?\' ?\) end return ?\C-r ?\' ?h ?e ?r ?e ?\' left right right right right right right])


;; rsync using shell, not tramp
(defun rsyncparbrutus ()
  "Calls rsyncpar (.py)."
  (interactive)
  (shell-command (concat "rsyncpar " buffer-file-name " brutus"))
  )
(defun rsyncparlefty ()
  "Calls rsyncpar (.py)."
  (interactive)
  (shell-command (concat "rsyncpar " buffer-file-name " lefty"))
  )
(defun rsyncparalina ()
  "Calls rsyncpar (.py)."
  (interactive)
  (shell-command (concat "rsyncpar " buffer-file-name " alina"))
  )

;; http://stackoverflow.com/questions/644917/change-the-frame-width-in-emacs-interactively
;;
;; Also, in *scratch* buffer:
;; (set-frame-width (selected-frame) 164)  ;; ^J to execute.
;;
;;
(defvar myfullscreen '()
  "non-nil if current frame is in fullscreen mode. See myfullscreen-on, myfullscreen-off, myfullscreen-toggle")

(defun myfullscreen-on ()
  "Sets fullscreen on (based on ???display??? with font ???)"
  (interactive)
  (set-frame-width (selected-frame) 164); adapt size
  (set-frame-height (selected-frame) 47); adapt size
  (setq myfullscreen t)
  )

(defun myfullscreen-off ()
  "Sets fullscreen off (based on ???display??? with font ???)"
  (interactive)
  (set-frame-width (selected-frame) 81); adapt size
  (set-frame-height (selected-frame) 37); adapt size
  (setq myfullscreen nil)
  )

(defun myfullscreen-on2 ()
  (interactive)
  (myfullscreen-on)
  (myfullscreen-on)
  )
(defun myfullscreen-off2 ()
  (interactive)
  (myfullscreen-off)
  (myfullscreen-off)
  )

;; RYAN: need to run -on or -off twice for it to work, but not sure how to do
;; that in elisp.
(defun myfullscreen-toggle ()
  "Toggles fullscreen on/off (based on ???Display??? with font ???)"
  (interactive)
  (if (eq myfullscreen 'nil)
      ;;((interactive)
       (myfullscreen-on)
       ;;(myfullscreen-on))
  ;else
    ;;((interactive)
     (myfullscreen-off)
     ;;(myfullscreen-off))
    )
  )

(defun unfill-paragraph (arg)
  "Pull this whole paragraph up onto one line."
  (interactive "*p")
  (let ((fill-column 10000))
    (fill-paragraph arg))
  )

(fset 'cycle-3-windows
   [?\C-x ?b return ?\C-x ?o ?\C-x ?b return ?\C-x ?o ?\C-x ?b return ?\C-x ?o])
(fset 'smart-split-vertical
   [?\C-x ?2 ?\C-x ?o ?\C-x ?b return])
(fset 'smart-split-horizontal
   [?\C-x ?3 ?\C-x ?o ?\C-x ?b return])

;; Stack esh1, esh2 and esh3 in one frame.
(fset 'esh-three-horiz
   [?\C-x ?2 ?\C-x ?2 ?\C-x ?+ ?\C-x ?b ?E ?S ?H ?- ?1 return
          ?\C-x ?o ?\C-x ?b ?E ?S ?H ?- ?2 return
          ?\C-x ?o ?\C-x ?b ?E ?S ?H ?- ?3 return ?\C-x ?o])

(fset 'esh-ipy-three-horiz
   [?\C-x ?2 ?\C-x ?2 ?\C-x ?+ ?\C-x ?b ?E ?S ?H ?- ?1 return
          ?\C-x ?o ?\C-x ?b ?E ?S ?H ?- ?2 return
          ?\C-x ?o ?\C-x ?b ?I ?P ?Y ?- ?1 return ?\C-x ?o])

(defun new-max-rename-frame ()
  (interactive)
  (make-frame-command)
  (other-frame)
  (maximize-frame)
  (rename-frame)
  )

(defun bs-show-one-window ()
  (interactive)
  (bs-show nil)
  (delete-other-windows)
  )

(fset 'new-max-rename-frame-macro2 [?\M-x ?m ?a ?k ?e ?- ?f ?r ?a
   ?m ?e ?- ?c ?o ?m ?m ?a ?n ?d return ?\C-x ?5 ?o ?\M-x ?m ?a ?x ?i ?m ?i
   ?z ?e ?- ?f ?r ?a ?m ?e return ?\M-x ?r ?e ?n ?a ?m ?e ?- ?f
   ?r ?a ?m ?e])

(fset 'grow-height-by-five
   "\C-u5\C-x^")
(fset 'shrink-height-by-five
   "\C-u-5\C-x^")
(fset 'grow-width-by-five
   "\C-u5\C-x}")
(fset 'shrink-width-by-five
   "\C-u5\C-x{")
(fset 'delete-other-window
   (lambda (&optional arg) "Keyboard macro." (interactive "p")
     (kmacro-exec-ring-item (quote ([24 111 24 107 return 24 111] 0 "%d")) arg)))
(fset 'bury-other-window
   (lambda (&optional arg) "Keyboard macro." (interactive "p")
     (kmacro-exec-ring-item (quote ([24 111 134217848 98 117 114 121 45 98
                                        117 102 102 101 114 return 24 111]
                                    0 "%d")) arg)))

(fset 'save-frame-config-and-delete-others
   (lambda (&optional arg) "Keyboard macro." (interactive "p")
     (kmacro-exec-ring-item (quote ([134217848 115 97 118 101 45 102
                                               114 97 109 101 45 99
                                               111 110 102 105 103
                                               return 24 49] 0 "%d")) arg)))

(fset 'split-esh1
   [?\C-x ?2 ?\C-x ?o ?\C-x ?b ?E ?S ?H ?- ?1 return])
(fset 'split-ipy1
   [?\C-x ?2 ?\C-x ?o ?\C-x ?b ?I ?P ?Y ?- ?1 return])
(fset 'split-term1
   [?\C-x ?2 ?\C-x ?o ?\C-x ?b ?t ?e ?r ?m ?1 return])
(fset 'new-ansi-term
   [?\M-x ?a ?n ?s ?i ?- ?t ?e ?r ?m return return])
(fset 'py-shell-goto
   [?\M-x ?p ?y ?- ?s ?h ?e ?l ?l return ?\C-x ?o])
(fset 'other-only
   "\C-xo\C-x1")
(fset 'other-window-reverse
      (lambda (&optional arg) "Keyboard macro." (interactive "p")
        (kmacro-exec-ring-item (quote ("-1o" 0 "%d")) arg)))
(fset 'stack-3-recent-buffers
   (lambda (&optional arg) "Keyboard macro." (interactive "p")
     (kmacro-exec-ring-item (quote ([24 50 24 98 return
                                        24 50 24 98 return 24 43] 0 "%d")) arg)))
(fset 'grid-recent-buffers
   [?\C-x ?2 ?\C-x ?3 ?\C-x ?o ?\C-x ?b return
          ?\C-x ?o ?\C-x ?3 ?\C-x ?b return
          ?\C-x ?o ?\C-x ?b return ?\C-x ?o])
(fset 'does-not-work
   [?\C-x ?\C-f ?b ?j ?l ?k ?j backspace backspace backspace backspace
          ?l ?a ?h ?b ?l ?a ?h ?b ?l ?a ?h return ?y return ?o return return
          ?y return ?o return return ?y return ?o return return
          ?# ?# ?# ?# ?# ?# ?# ?# ?# ?# ?# ?# ?# ?# ?# ?# ?# ?#
          ?# ?# ?# ?# ?# ?# ?# ?# ?# ?# ?# ?# ?# ?# ?# return return
          ?T ?h ?i ?s ?  ?d ?o ?e ?s ?  ?n ?o ?t ?  ?w ?o ?r ?k ?  ?y ?e ?t ?.
          return return ?H ?i ?t ?  ?C ?t ?r ?l ?- ?F ?3 ?  ?a ?n ?d ?
          ?g ?e ?t ?  ?b ?a ?c ?k ?  ?t ?o ?  ?w ?o ?r ?k ?. return return
          ?I ?  ?a ?m ?  ?w ?a ?i ?t ?i ?n ?g ?. ?. ?.])

; Get rid of '^M' carriage return from Windows/DOS files
(defun ridm ()
  "Remove intrusive CTRL-Ms from the buffer"
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (replace-string "\C-m\C-j" "\C-j")))

;;; http://www.gnu.org/software/emacs/emacs-lisp-intro/html_node/Counting-Words.html
;;; Final version: while
(defun count-words-region (beginning end)
  "Print number of words in the region."
  (interactive "r")
  (message "Counting words in region ... ")

;;; 1. Set up appropriate conditions.
  (save-excursion
    (let ((count 0))
      (goto-char beginning)

;;; 2. Run the while loop.
      (while (and (< (point) end)
                  (re-search-forward "\\w+\\W*" end t))
        (setq count (1+ count)))

;;; 3. Send a message to the user.
      (cond ((zerop count)
             (message
              "The region does NOT have any words."))
            ((= 1 count)
             (message
              "The region has 1 word."))
            (t
             (message
              "The region has %d words." count))))))

(defun server-shutdown ()
  "Save buffers, Quit, and Shutdown (kill) server"
  (interactive)
  (save-some-buffers)
  (kill-emacs)
  )

