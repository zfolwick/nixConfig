;;;
;; Startup
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
(setq show-trailing-whitespace t)

;;;
;; emacs diff editor
(defun command-line-diff (switch)
      (let ((file1 (pop command-line-args-left))
            (file2 (pop command-line-args-left)))
        (ediff file1 file2)))

    (add-to-list 'command-switch-alist '("diff" . command-line-diff))
    
;; emacs -diff file1 file2

;;;
;; Appearance
(add-hook 'after-init-hook 
      (lambda () (load-theme 'cyberpunk t)))

;;;
;; Package Initialization
(require 'package)

(setq package-archives
      '(("org" . "http://orgmode.org/elpa/")
        ("marmalade" . "http://marmalade-repo.org/packages/")
        ("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("ELPA" . "http://tromey.com/elpa/")
        ))

(package-initialize)


;;;
;; General Defaults
(fset 'yes-or-no-p 'y-or-n-p)


;;;
;; Evil-mode specific
(require 'evil)
(evil-mode 1)

(define-key evil-normal-state-map "\C-q" 'evil-visual-block)
;;Exit insert mode by pressing j and then j quickly
(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
(key-chord-mode 1)


;;;
;; Programming
