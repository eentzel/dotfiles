;;; .emacs --- Emacs initialization file -*- lexical-binding: t; -*-

;; Do these early to avoid flicker
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (string-equal system-type "gnu/linux")
  (set-face-attribute 'default nil :font "DejaVu Sans Mono-10")
  (set-frame-font "DejaVu Sans Mono-10" nil t))

;; package.el configuration
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; use-package bootstrap
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
;; (setq use-package-verbose t)
;; (setq use-package-compute-statistics t)

;; Solarized
(use-package solarized-theme
  :ensure t
  :config
  (setq solarized-scale-org-headlines nil)
  (setq custom-safe-themes
        '("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879"
          "fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c"
          "2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3"
          "c433c87bd4b64b8ba9890e8ed64597ea0f8eb0396f4c9a9e01bd20a04d15d358"
          "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default))
  (load-theme 'solarized-dark)
  :bind (("C-c c d" . (lambda () (interactive) (load-theme 'solarized-dark)))
         ("C-c c l" . (lambda () (interactive) (load-theme 'solarized-light)))))

;; ffap
(use-package ffap
  :bind (("C-c f" . ffap)))

;; org-mode
(use-package epe-org
  :load-path "lisp/"
  :bind (("C-c a" . epe-org-agenda)
         ("C-c l" . go-link)
         ("<f5>" . epe-org-agenda-full)
         ("<f6>" . org-capture))
  :config
  (setq org-capture-templates '(("t" "note" entry (file "") "* %?" :jump-to-captured t))))


;; scratch buffer customizations
(use-package epe-scratch
  :load-path "lisp/")

;; expand-region
(use-package expand-region
  :ensure t
  :bind ("M-SPC" . er/expand-region))

;; helm
(use-package helm-config
  :ensure helm
  :bind ("C-c r" . helm-recentf))

;; haskell
(use-package haskell-mode
  :ensure t)

;; server
(use-package server
  :unless noninteractive
  :no-require
  :hook (after-init . server-start))

;; builtins
(setq browse-url-browser-function 'browse-url-chrome
      transient-mark-mode nil
      make-backup-files nil
      use-dialog-box nil)

(show-paren-mode t)
(defalias 'yes-or-no-p 'y-or-n-p)

;;; .emacs ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ediff-window-setup-function 'ediff-setup-windows-plain)
 '(package-selected-packages '(elpher haskell-mode use-package solarized-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
