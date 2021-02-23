;; Startup
;;;
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
(setq show-trailing-whitespace t)

;; appearance
(menu-bar-mode -1)
(setq visible-bell t)
;; gui emacs prep
(scroll-bar-mode -1)
(tool-bar-mode -1)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-M-j") 'counsel-switch-buffer)
(global-set-key (kbd "C-M-s") 'shell)  ; make yourself a shell!!

(define-key emacs-lisp-mode-map (kbd "C-x M-t") 'counsel-load-theme)

;;;
;; emacs diff editor
(defun command-line-diff (switch)
      (let ((file1 (pop command-line-args-left))
            (file2 (pop command-line-args-left)))
        (ediff file1 file2)))

    (add-to-list 'command-switch-alist '("diff" . command-line-diff))

; emacs -diff file1 file2

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

;; vim keybindings
(use-package evil)
(evil-mode 1)
;(define-key evil-normal-state-map "\C-q" 'evil-visual-block)
;;Exit insert mode by pressing j and then j quickly
(use-package key-chord)
(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
(key-chord-mode 1)

;; line numbers
(column-number-mode)
(global-display-line-numbers-mode t)
;; disable for some modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		eshell-mode-hook
		shell-mode-hook))
  (add-hook mode (lambda() (display-line-numbers-mode 0))))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; great C-h helper menu
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

; useful for a lot of ivy-rich and other packages
(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil)) ;Don't start searches with ^
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package helpful
  :ensure t
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package all-the-icons)
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package doom-themes
  :init (load-theme 'doom-dracula t))

(use-package general)

(general-define-key
; "M-x" 'amx
 "C-s" 'counsel-grep-or-swiper)

(use-package image+)

;; java autocomplete
(use-package company)
(global-company-mode t)
(use-package company-emacs-eclim)
(company-emacs-eclim-setup)
(define-key eclim-mode-map (kbd "C-c C-c") 'eclim-problems-correct)

;;;
;; Programming
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(company-emacs-eclim company helpful counsel ivy-rich which-key rainbow-delimiters doom-modeline evil swiper ivy use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
