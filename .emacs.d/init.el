;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Packages
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(package-initialize)

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/")
             t)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/")
             t)
(add-to-list 'package-archives
             '("marmalade" . "https://marmalade-repo.org/packages/")
             t)

(autoload 'package-pinned-packages "package")

(setq required-packages '(
                          (ag . "melpa-stable")
                          (align-cljlet . "melpa-stable")
                          (cider . "melpa-stable")
                          (company . "melpa-stable")
                          (clojure-mode . "melpa-stable")
                          (expand-region . "melpa-stable")
                          (ido-vertical-mode . "melpa-stable")
                          (paredit . "melpa-stable")
                          (projectile . "melpa-stable")
                          (rainbow-delimiters . "melpa-stable")
                          (solarized-theme . "melpa-stable")
                          (smex . "melpa-stable")
                          (yaml-mode . "melpa-stable")
                          (yassnippet . "melpa-stable")
                          ))

;;(dolist (package required-packages)
;;  (unless (package-installed-p (car package))
;;    (package-install (car package))))

(defun install-required-packages ()
  (interactive)
  (mapc (lambda (package)
          (message "%s" (car package))
          (package-install (car package)))
        required-packages))


(projectile-global-mode t)

(require 'ido)
(ido-mode t)

(global-company-mode)
;; (add-hook 'cider-repl-mode-hook #'company-mode)
;; (add-hook 'cider-mode-hook #'company-mode)

(require 'yasnippet)
(yas-global-mode 1)

(eval-after-load 'paredit
  '(progn
     (define-key paredit-mode-map (kbd "M-p a") 'paredit-splice-sexp-killing-backward)
     (define-key paredit-mode-map (kbd "M-p b")  'paredit-splice-sexp-killing-forward)
     (define-key paredit-mode-map (kbd "M-p c")  'paredit-forward-slurp-sexp)
     (define-key paredit-mode-map (kbd "M-p d")  'paredit-forward-barf-sexp)
     (define-key paredit-mode-map (kbd "M-k")  'kill-sexp)))

(menu-bar-mode -1)

;;;hooks
(add-to-list 'load-path "~/.emacs.d/ccapurso")
(load "ccapurso_clojure")

(add-hook 'clojure-mode-hook (lambda ()
			       (cider-mode +1)
			       (paredit-mode +1)
			       (rainbow-delimiters-mode +1)
                               (require 'align-cljlet)
			       ;; (auto-complete-mode +1)
                               ))

(add-hook 'emacs-lisp-mode-hook (lambda ()
				  (paredit-mode +1)
				  (rainbow-delimiters-mode +1)))


(defun psc-switch-to-repl-buffer ()
  (interactive)
  (progn
    (switch-to-buffer-other-window "*test*")
    (cider-switch-to-repl-buffer)))

(eval-after-load 'clojure-mode
  '(progn
     (define-key clojure-mode-map (kbd "C-c s s") 'cider-connect)
     (define-key clojure-mode-map (kbd "C-c C-z") 'psc-switch-to-repl-buffer)))

(eval-after-load 'clojure-mode
  '(define-key clojure-mode-map (kbd "C-c C-z") 'psc-switch-to-repl-buffer))

(eval-after-load 'clojure-mode
  '(define-key clojure-mode-map (kbd "C-c C-a") 'align-cljlet))


(add-hook 'before-save-hook 'delete-trailing-whitespace)


;;make things look nice
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/blackboard-theme.el")
;; (load-theme 'blackboard t)


(global-set-key (kbd "C-c j") 'join-line)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "<f5>") 'revert-buffer)

;;; 1)cider-connect should read port fromn dot file in project
;;; 2)snippets
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" default)))
 '(js-indent-level 2)
 '(package-selected-packages
   (quote
    (cider rainbow-delimiters yasnippet yaml-mode terraform-mode smex projectile php-mode paredit org mediawiki markdown-mode magit ido-vertical-mode ido-ubiquitous fixme-mode expand-region company coffee-mode better-defaults bats-mode align-cljlet ag)))
 '(show-paren-delay 0))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq-default indent-tabs-mode nil)

(require 'ido-vertical-mode)
(ido-mode 1)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)

(setq nrepl-use-ssh-fallback-for-remote-hosts 't)
