;; ~/.emacs
;;
;; vim:ft=lisp:
;;


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(browse-url-browser-function (quote browse-url-mozilla))
 '(browse-url-mozilla-new-window-is-tab t)
 '(browse-url-mozilla-program "/opt/seamonkey/seamonkey")
 '(case-fold-search t)
 '(column-number-mode t)
 '(display-battery-mode t)
 '(display-time-24hr-format t)
 '(display-time-mode t)
 '(display-time-use-mail-icon t)
 '(global-font-lock-mode t nil (font-lock))
 '(inhibit-startup-screen t)
 '(mail-use-rfc822 t)
 '(rmail-display-summary t)
 '(rmail-enable-mime t)
 '(rmail-mail-new-frame t)
 '(rmail-preserve-inbox t)
 '(rmail-redisplay-summary t)
 '(rmail-summary-scroll-between-messages nil)
 '(scroll-bar-mode (quote right))
 '(show-paren-mode t nil (paren))
 '(size-indication-mode t)
 '(xterm-mouse-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-button ((t (:background "#aeb2c3" :box (:line-width 1 :style released-button)))))
 '(custom-button-pressed ((t (:background "#aeb2c3" :box (:line-width 1 :style pressed-button)))))
 '(default ((t (:background "#fff7e9" :foreground "black"))))
 '(widget-field ((t (:background "#fff7e9" :box (:line-width 1 :color "#b24d7a")))))
 '(widget-single-line-field ((t (:background "#fff7e9" :box (:line-width 1 :color "#b24d7a"))))))

(if (eq system-type 'darwin)
	(if (eq window-system 'x)
;;		(set-default-font
;;			"-Adobe-Courier-medium-r-normal--*-*-*-*-m-*-iso10646-1")
		(set-default-font
			"-ibm-Courier-normal-normal-normal-*-18-*-*-*-m-0-iso10646-1")
		;; else (eq window-system 'x)
		(if (eq window-system 'ns)
			(progn
				;; Toolbar is already on on modern emacsen
;;				(ns-toggle-toolbar)
				(set-default-font
					"-apple-Courier_New-medium-normal-normal-*-18-*-*-*-m-0-iso10646-1")
				;; An alternative way to set font on Mac OS X,
				;; as set-default-font doesn't work for new frames.
				(set-face-attribute
					'default nil
					:foundry "apple"
					:family "Courier_New"
					:height 180
					:weight 'normal))
			;; else (eq window-system 'ns)
			(when (eq window-system 'mac)
				(progn
					;; Toolbar is already on by default
;;					(toggle-tool-bar-mode-from-frame)

					(set-default-font "-*-Courier New-normal-normal-normal-*-18-*-*-*-m-0-iso10646-1")
					(set-face-font 'default "-*-Courier New-normal-normal-normal-*-18-*-*-*-m-0-iso10646-1")))))
	;; else (eq system-type 'darwin)
	(if (eq system-type 'gnu/linux)
		(when (eq window-system 'x)
			;; Can also be set via X resources (emacs.Font)
			;; No Xft:
			;;(set-default-font
			;;	"-monotype-courier new-medium-r-normal--*-120-*-*-m-0-iso10646-1"))
			;; Xft:
			(set-default-font
				"Courier New:size=13"))
		;; else (not gnu/linux)
		(when (eq system-type 'windows-nt)
			(progn
				(prefer-coding-system 'windows-1251)
				(if (eq window-system 'w32)
					(set-face-attribute
						'default nil
						:foundry "outline"
						:family "Courier New"
						:height 120
						:slant 'normal
						:weight 'normal
						:width 'normal)
					;; else
					(when (not window-system)
						(set-terminal-coding-system 'cp866)))))))

(setq default-tab-width 8)
(setq c-basic-offset 8)
(setq truncate-partial-width-windows t)
(setq default-truncate-lines t)
(setq font-lock-maximum-decoration t)
(setq-default display-time-mode t)
(setq-default indent-tabs-mode t)
(setq-default transient-mark-mode t)
;;(global-set-key [(C-f1)] (lambda () (interactive) (manual-entry (current-word))))
(global-set-key (kbd "TAB") 'self-insert-command)
(global-set-key [mouse-4] 'scroll-down)
(global-set-key [mouse-5] 'scroll-up)
(set-scroll-bar-mode 'right)
(autoload 'vm "vm" "Start VM on your primary inbox." t)
(autoload 'vm-other-frame "vm" "Like `vm' but starts in another frame." t)
(autoload 'vm-visit-folder "vm" "Start VM on an arbitrary folder." t)
(autoload 'vm-visit-virtual-folder "vm" "Visit a VM virtual folder." t)
(autoload 'vm-mode "vm" "Run VM major mode on a buffer" t)
(autoload 'vm-mail "vm" "Send a mail message using VM." t)
(autoload 'vm-submit-bug-report "vm" "Send a bug report about VM." t)

(put 'downcase-region 'disabled nil)
(put 'erase-buffer 'disabled nil)
(put 'upcase-region 'disabled nil)

;; Package support
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
