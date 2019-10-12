(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
	     '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives
	     '("marmalade" . "https://marmalade-repo.org/packages/") t)

(package-initialize)

(if (not (package-installed-p 'use-package))
    (progn
      (package-refresh-contents)
      (package-install 'use-package)))

(require 'use-package)

;; Package: diminish
(use-package diminish
  :config (progn
	    (diminish 'abbrev-mode))
  :ensure t)

;; Package: powerline
(use-package powerline
  :ensure t)

;; Package: moe-theme
(use-package moe-theme
  :config (progn
	    (load-theme 'moe-dark t)
	    (setq moe-theme-highlight-buffer-id t)
	    (moe-theme-set-color 'green)
	    (powerline-moe-theme))
  :ensure t)

;; Transparent background when opened in the terminal
(defun on-frame-open (&optional frame)
  "If the FRAME created in terminal don't load background color."
  (unless (display-graphic-p frame)
    (set-face-background 'default "unspecified-bg" frame)))

(add-hook 'after-make-frame-functions 'on-frame-open)

;; hide menu-bar, scroll-bar and tool-bar
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; show column number
(column-number-mode t)

;; activate whitespace-mode to view all whitespace characters
(global-set-key (kbd "C-c w") 'whitespace-mode)

;; show unncessary whitespace that can mess up your diff
(add-hook 'prog-mode-hook
	  (lambda ()
	    (interactive)
	    (setq show-trailing-whitespace 1)))

;; automatically indent when press RET
(global-set-key (kbd "RET") 'newline-and-indent)

;; delete selected region
(delete-selection-mode 1)
(global-set-key (kbd "C-c d r") 'delete-region)

;; show the function you are in
(which-function-mode t)

;; create alias for yes or no ?s
(defalias 'yes-or-no-p 'y-or-n-p)

(setq backup-inhibited t)
(setq auto-save-default nil)
(setq inhibit-startup-message t)

(use-package cc-mode
  :config (progn
	    (setq c-default-style "linux")
	    (setq-default c-basic-offset 8 indent-tabs-mode t tab-width 8)
	    (add-hook 'c-mode-common-hook 'hs-minor-mode)))

;; Package: ispell
(use-package ispell
  :bind (("C-c s w" . ispell-word)
         ("C-c s b" . ispell-buffer))
  :defer t)

;; show the cursor when moving after big movements in the window
(use-package beacon
  :init (beacon-mode 1)
  :ensure t)

;; Package: mic-paren
(use-package mic-paren
  :config (progn
	    (paren-activate)
	    (setq paren-match-face 'highlight)
	    (setq paren-sexp-mode t)
	    (setq paren-dont-touch-blink t))
  :ensure t)

;; Package: smartparens
(use-package smartparens
  :init (smartparens-global-mode 1)
  :config (progn
	    (require 'smartparens-config)
	    (setq sp-base-key-bindings 'paredit)
	    (setq sp-autoskip-closing-pair 'always)
	    (setq sp-hybrid-kill-entire-symbol nil)
	    (sp-use-paredit-bindings))
  :diminish smartparens-mode
  :ensure t)

;; Package: clean-aindent-mode
(use-package clean-aindent-mode
  :init (add-hook 'prog-mode-hook 'clean-aindent-mode)
  :ensure t)

;; Package: ws-butler
(use-package ws-butler
  :init (add-hook 'prog-mode-hook 'ws-butler-mode)
  :config (progn
	    (add-hook 'c-mode-common-hook 'ws-butler-mode)
	    (add-hook 'text-mode 'ws-butler-mode)
	    (add-hook 'fundamental-mode 'ws-butler-mode))
  :diminish ws-butler-mode
  :ensure t)

;; Package: dtrt-indent
(use-package dtrt-indent
  :init (dtrt-indent-mode 1)
  :config (setq dtrt-indent-verbosity 0)
  :ensure t)

;; Package: yasnippet
(use-package yasnippet
  :config (progn
	    (use-package yasnippet-snippets
	      :ensure t)
	    (yas-global-mode 1)
	    (yas-minor-mode 1))
  :diminish yas-minor-mode
  :ensure t)

;; Package: anzu
(use-package anzu
  :init (anzu-mode +1)
  :bind (("M-%" . 'anzu-query-replace)
	 ("C-M-%" . 'anzu-query-replace-regexp))
  :diminish anzu-mode
  :ensure t)

;; Package: volatile-highlights
(use-package volatile-highlights
  :init (volatile-highlights-mode t)
  :diminish volatile-highlights-mode
  :ensure t)

;; Package: duplicate-thing
(use-package duplicate-thing
  :bind ("M-c" . 'duplicate-thing)
  :ensure t)

;; Package: comment-dwim-2
(use-package comment-dwim-2
  :bind ("M-;" . 'comment-dwim-2)
  :ensure t)

;; Package: dumb-jump
(use-package dumb-jump
  :bind (("M-g j" . dumb-jump-go)
         ("M-g k" . dumb-jump-back)
         ("M-g l" . dumb-jump-quick-look))
  :config (setq dumb-jump-prefer-searcher 'ag)
  :ensure t)

;; Package: pulse
(use-package pulse
  :commands pulse-momentary-highlight-one-line
  :config (progn
            (setq pulse-iterations 8
                  pulse-delay .05)
            (set-face-background 'pulse-highlight-start-face
				 (face-foreground 'font-lock-keyword-face))))

;; Package: magit
(use-package magit
  :bind (("C-x m" . magit-status)
         ("C-c m b" . magit-blame-addition)
         ("C-c m l" . magit-log-buffer-file))
  :commands magit-status
  :ensure t)

;; Package: git-messenger
(use-package git-messenger
  :config (setq git-messenger:show-detail t)
  :bind ("C-c m g" . git-messenger:popup-message)
  :ensure t)

;; Package: git-timemachine
(use-package git-timemachine
  :commands (git-timemachine)
  :bind ("C-c m t" . git-timemachine)
  :defer t
  :ensure t)

;; Package: company
(use-package company
  :config (progn
	    (add-hook 'after-init-hook 'global-company-mode)
	    (add-to-list 'company-backends 'company-c-headers))
  :diminish global-company-mode
  :ensure t)

;; Package: auto-complete
(use-package auto-complete
  :config (progn
            (use-package auto-complete-config)
	    (use-package fuzzy
	      :ensure t)
	    (ac-config-default)
	    (ac-fuzzy-complete))
  :init (auto-complete-mode 1)
  :diminish auto-complete-mode
  :ensure t)

;; Package: ac-c-headers
(use-package ac-c-headers
  :config (progn
	    (add-hook 'c++-mode-hook
		      (lambda ()
			(add-to-list 'ac-sources 'ac-source-c-headers)
			(add-to-list 'ac-sources 'ac-source-c-header-symbols t)
			(add-to-list 'cc-search-directories "/usr/include"))))
  :ensure t)

;; Package: meson-mode
(use-package meson-mode
  :config (add-hook 'meson-mode-hook 'company-mode)
  :ensure t)

;; Package: avy
(use-package avy
  :bind ("C-c a v" . avy-goto-word-1)
  :ensure t)

;; Package: vimish-fold
(use-package vimish-fold
  :init (vimish-fold-global-mode 1)
  :bind (("C-c f f" . vimish-fold)
	 ("C-c f d" . vimish-fold-delete)
	 ("C-c f u" . vimish-fold-toggle))
  :ensure t)

;; Package: counsel - ivy + swiper
(use-package counsel
  :init (ivy-mode 1)
  :bind (("C-s" . 'swiper)
	 ("M-x" . 'counsel-M-x)
	 ("C-x C-f" . 'counsel-find-file)
	 ("C-c C-r" . 'ivy-resume)
	 ("C-c g" . 'counsel-git)
	 ("C-c j" . 'counsel-git-grep)
	 ("C-c k" . 'counsel-ag)
	 ("C-c l" . 'counsel-locate)
	 ("C-c d f" . 'counsel-describe-function)
	 ("C-c d v" . 'counsel-describe-variable)
	 ("C-c f l" . 'counsel-find-library)
	 ("C-c i s" . 'counsel-info-lookup-symbol))
  :diminish ivy-mode
  :ensure t)

;; Package: undo-tree
(use-package undo-tree
  :config (global-undo-tree-mode 1)
  :bind (("C-c u u" . undo-tree-undo)
         ("C-c u r" . undo-tree-redo)
         ("C-c u b" . undo-tree-switch-branch)
         ("C-c u v" . undo-tree-visualize))
  :diminish undo-tree-mode
  :ensure t)

;; Package: dts-mode
(use-package dts-mode
  :ensure t)

;; Package: clang-format
(use-package clang-format
  :bind ("C-c f c" . clang-format-region)
  :ensure t)

;; Package: irony
(use-package irony
  :diminish irony-mode
  :preface (defun my-irony-mode-hook ()
	     (define-key irony-mode-map [remap completion-at-point]
               'counsel-irony)
	     (define-key irony-mode-map [remap complete-symbol]
               'counsel-irony))
  :config (progn
	      (add-hook 'c++-mode-hook 'irony-mode)
	      (add-hook 'c-mode-hook 'irony-mode)
	      (add-hook 'irony-mode-hook 'my-irony-mode-hook)
	      (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))
  :ensure t)

;; Package: rust-mode
(use-package rust-mode
  :config (progn
	    (setq rust-format-on-save t)
	    (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode)))
  :ensure t)

;; Package: go-mode
(use-package go-mode
  :config (progn
	    (add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
	    (add-to-list 'ac-modes 'go-mode))
  :ensure t)

;; Package: web-mode
(use-package web-mode
  :config (progn
	    (setq web-mode-enable-current-column-highlight t)
	    (setq web-mode-enable-current-element-highlight t)
	    (setq web-mode-markup-indent-offset 2)
	    (setq web-mode-css-indent-offset 2)
	    (add-to-list 'auto-mode-alist '("\\.ts\\'" . web-mode))
	    (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
	    (add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
	    (add-to-list 'auto-mode-alist '("\\.js?\\'" . web-mode)))
  :ensure t)

;; Package: flycheck
(use-package flycheck
  :init (global-flycheck-mode)
  :config (add-hook 'after-init-hook #'global-flycheck-mode)
  :diminish flycheck-mode
  :ensure t)

;; Package yaml-mode
(use-package yaml-mode
  :config (progn
	    (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode)))
  :ensure t)

;; Package lua-mode
(use-package lua-mode
  :config (progn
	    (add-to-list 'auto-mode-alist '("\\.lua\\'" . lua-mode))
	    (add-to-list 'interpreter-mode-alist '("lua" . lua-mode)))
  :ensure t)

;; Package: rainbow-delimiters
(use-package rainbow-delimiters
  :config (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  :ensure t)

;; Package: rainbow-identifiers
(use-package rainbow-identifiers
  :config (add-hook 'prog-mode-hook 'rainbow-identifiers-mode)
  :ensure t)

;; Package: anaconda-mode
(use-package anaconda-mode
  :config (progn
	    (add-hook 'python-mode-hook 'anaconda-mode)
	    (add-hook 'python-mode-hook 'anaconda-eldoc-mode))
  :diminish anaconda-mode
  :ensure t)

;; Package: rst-mode
(use-package rst
  :config (progn
	    (add-to-list 'auto-mode-alist '("\\.txt\\'" . rst-mode))
	    (add-to-list 'auto-mode-alist '("\\.rst\\'" . rst-mode))
	    (add-to-list 'auto-mode-alist '("\\.rest\\'" . rst-mode)))
  :ensure t)

(use-package ggtags
  :config (progn
	    (add-hook 'c-mode-common-hook
		      (lambda ()
			(when (derived-mode-p 'c-mode 'c++-mode)
			  (ggtags-mode 1)))))
  :bind (("C-c f s" . 'ggtags-find-other-symbol)
	 ("C-c f h" . 'ggtags-view-tag-history)
	 ("C-c f r" . 'ggtags-find-reference)
	 ("C-c f c" . 'ggtags-create-tags)
	 ("C-c f a" . 'ggtags-find-tag-dwim)
	 ("C-c f p" . 'pop-tag-mark)
	 ("C-c <" . 'ggtags-prev-mark)
	 ("C-c >" . 'ggtags-next-mark))
  :diminish ggtags-mode
  :ensure t)
