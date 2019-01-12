;; dependency
;; flake8
;; autopep8

(require 'package)
;; tsinghua melpa mirror
(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                         ("melpa" . "http://elpa.emacs-china.org/melpa/")))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    material-theme
    elpy
    flycheck
    magit
    ivy
    counsel
    swiper
    py-autopep8
    irony
    irony-eldoc
    company
    company-irony
    yasnippet
    yasnippet-snippets
    ))

;; install packages in myPackages
(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; ------------------------------------

(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'material t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally
(menu-bar-mode -1) ;; disable menubar
(tool-bar-mode -1) ;; disable toolbar
(scroll-bar-mode -1) ;;disable scrollbar
(elpy-enable)

;; use jupyter console for elpy
(setq python-shell-interpreter "jupyter"
      python-shell-interpreter-args "console --simple-prompt"
      python-shell-prompt-detect-failure-warning nil)
(add-to-list 'python-shell-completion-native-disabled-interpreters
             "jupyter")

;; use flycheck in elpy-mode
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; use flycheck in c++-mode
(add-hook 'c++-mode-hook 'flycheck-mode)

;; org mode settings
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(setq org-log-done t)

;; magit setting
(global-set-key (kbd "C-x g") 'magit-status)

;; ivy setting
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

;; py-autopep8 setting
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; irony
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook #'irony-eldoc)
(add-hook 'c++-mode-hook 'company-mode)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; company-irony
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

;; yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;; html
(setq sgml-quick-keys 'close)

;; disable auto backup
(setq make-backup-files nil)

;; end

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (protobuf-mode company company-c-headers google-translate flycheck elpy material-theme better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
