;;; Package --- Summary
;;; Code:
;;; Commentary:
;; Useful reminders
;;   To describe a variable:	C-h v

;; First of all - skip the copyright message
(setq inhibit-startup-message t)
(setq enable-recursive-minibuffers t)
(xterm-mouse-mode 1)

(require 'package)
;;(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(package-initialize)


(defun install-use-package ()
  (when (not (package-installed-p 'use-package))
    (package-install 'use-package)))

(condition-case nil
    (install-use-package)
  (error
   (package-refresh-contents)
   (install-use-package)))


;;(use-package csharp-mode:ensure t)

(eval-when-compile
  (require 'use-package))

;; First of all - skip the copyright message
(setq inhibit-startup-message t)
(setq enable-recursive-minibuffers  t)


;;(hc-toggle-highlight-tabs)
(setq-default show-trailing-whitespace t)
(setq make-backup-files nil)

;; Define function to ask before exiting
(defun ask-before-exiting ()
  "Ask for confirmation before exiting Emacs."
  (interactive)
  (cond ((y-or-n-p "Really quit Emacs? ") (save-buffers-kill-emacs))
        (t (message "Nope."))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(current-language-environment "UTF-8")
 '(custom-safe-themes (quote ("5a0eee1070a4fc64268f008a4c7abfda32d912118e080e18c3c865ef864d1bea" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "90edd91338ebfdfcd52ecd4025f1c7f731aced4c9c49ed28cfbebb3a3654840b" default)))
 '(default-input-method "rfc1345")
 '(delete-selection-mode nil nil (delsel))
 '(global-font-lock-mode t nil (font-lock))
 '(scroll-bar-mode (quote right))
 '(show-paren-mode t nil (paren))
 '(transient-mark-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'cc-mode)
(add-hook 'c-mode-common-hook
          '(lambda()
             ;; Use bsd style
             (c-set-style "bsd")
             ;; Want some more text on each line (for e.g. Esc-Q)
             (setq fill-column 76)
             ;; To be compatilbe with VC++
             (c-set-offset 'case-label 4)
             (setq c-basic-offset 4)
             (c-set-offset 'statement-cont 0)
;            (define-key ctrl-map "[" 'c-beginning-of-statement)
;            (define-key ctrl-map "]" 'c-end-of-statement)
             ;; Bind Esc-M to man in c-mode (normally back-to-indentation)
             (local-set-key "\M-m" 'man)
             (local-set-key "\M-n" 'next-error) ;goto-next-error-in-other-buffer
             (local-set-key "\M-e" 'call-last-kbd-macro)
             ;; Auto-newline
             (c-toggle-auto-state -1)
             ;; Also use spaces instead of tabs
             (add-hook 'local-write-file-hooks
                       '(lambda()
                          (untabify (point-min) (point-max))))
             ;; Display function/method name in status line
             (which-function-mode 1)
             ;; Don't want line-wrapping when printing code
                                        ;(make-local-variable 'ps-number-of-columns)
             (setq ps-number-of-columns 1)
                                        ;(setq c-font-lock-extra-types (append c-font-lock-extra-types '("Bool_")))
                                        ;(setq c++-font-lock-extra-types (append c++-font-lock-extra-types '("Bool_")))
                                        ;(setq c++-font-lock-extra-types (append c++-font-lock-extra-types '("OpString")))
             ))

;; Various customizations

(setq column-number-mode t)
(setq line-number-mode t)
(setq tab-width 2)

(setq-default cperl-continued-statement-offset 4)
(setq-default cperl-indent-level 4)

;; just give up and use something else...
(load-theme 'cyberpunk)

;; flycheck for syntax checking
(add-hook 'after-init-hook #'global-flycheck-mode)
;; Customizations for tramp
;;
;; (This only works on systems w/tramp - otherwise warnings result)

(cond ((equal system-name "scxcore-suse01.opsmgr.lan")
       (setq tramp-default-method "ssh"
;;           tramp-default-user "jeffcof"
             )

       (add-to-list 'backup-directory-alist
                    (cons tramp-file-name-regexp nil))
       )
      )

;; Set up a few key definitions

(global-set-key [f6]             'compile)

;;(set 'compile-command "cd ~/dev/work/opsmgr/build && SCX_TESTRUN_NAMES=XXX make all test")

(global-set-key [f1]            'goto-line)
(global-set-key [f2]            'save-buffer)
(global-set-key [f3]            'find-file)
(global-set-key [f5]            'dired)
(global-set-key [f7]            'split-window)
(global-set-key [f8]            'split-window-horizontally)
(global-set-key [f9]            'delete-window)
(global-set-key [f10]           'delete-other-windows)
(global-set-key [home]          'beginning-of-line)
(global-set-key [C-home]        'beginning-of-buffer)
(global-set-key [end]           'end-of-line)
(global-set-key [C-end]         'end-of-buffer)
(global-set-key "\C-X\C-C"      'ask-before-exiting)
(global-set-key (kbd "S-C-<left>")     'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>")    'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>")     'shrink-window)
(global-set-key (kbd "S-C-<up>")       'enlarge-window)

(put 'erase-buffer 'disabled nil)

;; Bind Esc-g to goto-line
(define-key     esc-map "g"     'goto-line)

;; Bind Esc-r to revert-buffer
(define-key	esc-map "r"	'revert-buffer-noconf)
(defun revert-buffer-noconf ()
  (interactive)
  (revert-buffer nil t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; T F S  S U P P O R T
;; Quick and dirty by Andreas Lalloo
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Checkout
(defun tf-checkout()
  "Check out the file in the current buffer from TFS"
  (interactive)
  (shell-command-to-string (concat "tf checkout " buffer-file-name))
  (revert-buffer nil t))

;; Undo (no confirmation!)
(defun tf-undo()
  "Undo the changes of the file in current buffer"
  (interactive)
  (shell-command-to-string (concat "tf undo " buffer-file-name))
  (revert-buffer nil t))

(defun tf-diff-changes()
  "Diff changes from base version"
  (interactive)
  (let* ((filename-full buffer-file-name)
		 (filename (file-name-nondirectory buffer-file-name))
		 (filename-ns (file-name-sans-extension filename))
		 (filesuffix (file-name-extension filename t))
		 (baseversion (tf-get-baseversion filename-full))
		 (basefilename (concat filename-ns "." baseversion filesuffix "~")))
	;; Get the base version
	(message (concat "Getting base version (" baseversion ") of " filename))
	(shell-command-to-string (concat "tf print -version:" baseversion " " filename-full " > " basefilename))
	;; Diff
	(ediff basefilename filename-full)))

(defun tf-diff-head()
  "Diff changes from head version"
  (interactive)
  (let* ((filename-full buffer-file-name)
		 (filename (file-name-nondirectory buffer-file-name))
		 (filename-ns (file-name-sans-extension filename))
		 (filesuffix (file-name-extension filename t))
		 (headfilename (concat filename-ns ".head" filesuffix "~")))
	;; Get head version
	(message (concat "Gettting head version of " filename))
	(shell-command-to-string (concat "tf print " filename-full " > " headfilename))
	;; Diff
	(ediff headfilename filename-full)))

;; Handle the lousy merge tool in Teamprise
(defun tf-merge()
  "Save the modified file as a backup, undo edit, get server version, tf-edit it and open files in ediff."
  (interactive)
  (let* ((filename-full buffer-file-name)
		 (filename (file-name-nondirectory buffer-file-name))
		 (filename-ns (file-name-sans-extension filename))
		 (filesuffix (file-name-extension filename t))
		 (baseversion (tf-get-baseversion filename-full))
		 (localchfilename (concat filename-ns ".localchanges" filesuffix "~"))
		 (headfilename (concat filename-ns ".head" filesuffix "~"))
		 (basefilename (concat filename-ns "." baseversion filesuffix "~")))
	(message (concat "Saving backup as file " localchfilename))
	(write-file localchfilename)
	;; Get the base version
	(message (concat "Getting base version (" baseversion ") of " filename))
	(shell-command-to-string (concat "tf print -version:" baseversion " " filename-full " > " basefilename))
	;; Get head version
	(message (concat "Gettting head version of " filename))
	(shell-command-to-string (concat "tf print " filename-full " > " headfilename))
	;; Get head version in ordinary file
	;;(message "Getting latest version")
	;;(shell-command-to-string (concat "tf get " filename-full))
	(message (concat "Undoing changes to " filename))
	(shell-command-to-string (concat "tf undo " filename-full))
	(message (concat "Getting latest version of " filename))
	(shell-command-to-string (concat "tf get " filename-full)) ; Since this seems to be required the get first operation could be removed, of course. Some day.
	(message (concat "Checking out " filename " again"))
	(shell-command-to-string (concat "tf checkout " filename-full))
	;;(emerge-files-with-ancestor 4 localchfilename headfilename basefilename filename-full)
	(ediff-merge-files-with-ancestor localchfilename headfilename basefilename nil filename-full)))


(defun tf-get-baseversion(srcfile)
  "Retrieve the changeset number of the file supplied as argument."
  (interactive "f")
  (message "Looking up base version number")
  (shell-command-to-string
   (concat "tf properties " srcfile "|egrep \"Changeset:   ([[:digit:]]+)\" | awk '{printf \"%d\", $2}'")))

;; auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

;;
;; Query-replace - inserting newline:
;;  M-% oldstring<enter>C-Q C-J
;; where C-Q is the quote and C-J is the newline.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; E N D  O F  F I L E
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(put 'upcase-region 'disabled nil)
