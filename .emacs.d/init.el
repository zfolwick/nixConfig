;;;
;; Startup
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
(setq show-trailing-whitespace t)

;; appearance
(menu-bar-mode -1)
(setq visible-bell t)
(load-theme 'wombat)
(global-set-key (kbd "<escape>") 'keyboard-escape-quite)
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
;;(add-hook 'after-init-hook 
;;      (lambda () (load-theme 'cyberpunk t)))

;;;
;; Package Initialization
(require 'package)

(setq package-archives'(
        ("org" . "http://orgmode.org/elpa/")
;        ("marmalade" . "http://marmalade-repo.org/packages/")
        ("elpa" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; initialize use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;;;
;; General Defaults
(fset 'yes-or-no-p 'y-or-n-p)
(use-package swiper)
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

;;;
;; vim keybindings
(use-package evil)
;;(require 'evil)
(evil-mode 1)
;(define-key evil-normal-state-map "\C-q" 'evil-visual-block)
;;Exit insert mode by pressing j and then j quickly
;(setq key-chord-two-keys-delay 0.5)
;(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
;(key-chord-mode 1)


;;;
;; Programming
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (doom-modeline evil swiper ivy use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
