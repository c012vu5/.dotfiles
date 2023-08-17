;; load-path

(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-lebel-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))

;; (add-to-load-path "xxx" "yyy" "zzz")
(add-to-load-path "elisp")

;; SETTINGS
;; common lisp
(require 'cl)

;; Char code
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setq file-name-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)

;; general
(setq inhibit-startup-screen t)
(setq initial-scratch-message "")
(tool-bar-mode -1)
(menu-bar-mode -1)
(set-scroll-bar-mode nil)

(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

(global-display-line-numbers-mode t)

(set-face-attribute 'line-number nil
		    :foreground "#800"
		    :height 0.9)

(setq line-number-format "%4d ")
(show-paren-mode t)
(setq show-paren-delay 0)
(set-face-background 'region "#555")
(setq-default show-trailing-whitespace t)
(set-face-background 'trailing-whitespace "#b14770")
(setq-default indent-tabs-mode nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(tab-width 4))
(fset 'yes-or-no-p 'y-or-n-p)
(recentf-mode t)
(setq recentf-max-menu-items 10)
(setq recentf-max-saved-items 3000)
(savehist-mode 1)
(setq history-length 3000)
(setq make-backup-files nil)
(setq-default line-spacing 0)

(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)

(setq comint-scroll-show-maximum-output t)
(line-number-mode t)
(column-number-mode t)

(cua-mode t)
(setq cua-enable-cua-keys nil)

(defvar my-lines-page-mode t)
(defvar my-mode-line-format)

(when my-lines-page-mode
  (setq my-mode-line-format "%d")
  (if size-indication-mode
      (setq my-mode-line-format (concat my-mode-line-format " of %%I")))
  (cond ((and (eq line-number-mode t) (eq column-number-mode t))
	 (setq my-mode-line-format (concat my-mode-line-format " (%%l,%%c)")))
	((eq line-number-mode t)
	 (setq my-mode-line-format (concat my-mode-line-format " L%%l")))
	((eq column-number-mode t)
	 (setq my-mode-line-format (concat my-mode-line-format " C%%c"))))

  (setq mode-line-position
	'(:eval (format my-mode-line-format
			(count-lines (point-max) (point-min))))))

(setq ring-bell-function 'ignore)
(setq vc-follow-symlinks t)

(require 'yaml-mode nil t)
(autoload 'yaml-mode "yaml-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.ya?ml\\'" . yaml-mode))

;; didn't finish setting yet
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:background "color-236")))))

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(global-hl-line-mode)

(setq delete-auto-save-files t)

(setq c-tab-always-indent nil)
