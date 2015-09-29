;;; This is a file that I call from the handy dandy .emacs file. 

;;(let ((git-emacs "~/git/tf-config/.emacs"))
;;  (if (file-exists-p git-emacs) (load-file git-emacs)))

;; generate tab stop list
(setq tab-stop-list (number-sequence 4 120 4))

;; simple modes
(setq column-number-mode t)
(setq line-number-mode t)
(transient-mark-mode t)
(menu-bar-mode -1)
(global-font-lock-mode t)

;; general settings
(setq ring-bell-function 'ignore)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq undo-limit 100000)

;; For undoing window changes (has to come before keybindings)
(when (fboundp 'winner-mode)
  (let ((winner-dont-bind-my-keys t))
    (winner-mode 1))
  (global-set-key (kbd "C-c w <left>") 'winner-undo)
  (global-set-key (kbd "C-c w <right>") 'winner-redo))

;; keybindings
(global-set-key (kbd "<home>") 'move-beginning-of-line)
(global-set-key (kbd "<end>") 'move-end-of-line)
(global-set-key (kbd "DEL") 'backward-delete-char)
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "M-s") 'save-buffer)
(global-set-key (kbd "M-z") 'undo)
(global-set-key (kbd "C-c C-c") 'comment-region)
(global-set-key (kbd "C-c C-u") 'uncomment-region)
(global-set-key (kbd "M-c") 'compile)

(global-set-key (kbd "M-n") '(lambda ()
			       (interactive)
			       (dotimes (number 5 i)
				 (next-line))))
(global-set-key (kbd "M-p") '(lambda ()
			       (interactive)
			       (dotimes (number 5 i)
				 (previous-line))))

;; moving around buffers
(global-set-key (kbd "C-c <left>") 'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>") 'windmove-up)
(global-set-key (kbd "C-c <down>") 'windmove-down)
(global-set-key (kbd "C-c b") 'windmove-left)
(global-set-key (kbd "C-c f") 'windmove-right)
(global-set-key (kbd "C-c p") 'windmove-up)
(global-set-key (kbd "C-c n") 'windmove-down)

;; scrolling
(global-set-key (kbd "C-M-p") 'scroll-down-line)
(global-set-key (kbd "C-M-n") 'scroll-up-line)

;; typing
(show-paren-mode t)			; highlight parenthesis
(setq show-paren-style 'parethesis)	; highlihght just parenthesis
(setq echo-keystrokes 0.1)		; quick keystrokes

(set-keyboard-coding-system nil)	; for using a Mac

;; disable autosave
(setq auto-save-default nil)		; autosave
(setq backup-inhibited t)		; backup

;; hooks
(add-hook 'lisp-mode-hook 		; CLISP
	  (lambda ()
	    (auto-fill-mode)
	    (set-fill-column 80)
	    (set (make-local-variable 'lisp-indent-function)
		 'common-lisp-indent-function) ; not dumb indentation
	    (set-lisp-comments)))

(add-hook 'emacs-lisp-mode-hook		; EMACS LISP
	  (lambda ()
	    (auto-fill-mode)
	    (set-fill-column 80)
	    (set-lisp-comments)))

(add-hook 'c-mode-common-hook		; C-like languages
	  (lambda ()
	    (auto-fill-mode 80)
	    ;; norm
	    (setq c-basic-offset 4
		  indent-tabs-mode t
		  c-backspace-function 'backward-delete-char
		  c-tab-always-indent nil
		  tab-width 4)
	    ;; indentation of openning { in blocks
	    (c-set-offset 'substatement-open 0)
	    ;; uncommenting a region
	    (local-set-key (kbd "C-c C-u") 'uncomment-region)
	    ;; hide show
	    (hs-minor-mode t)
	    (define-key c-mode-map (kbd "C-c C-s") 'hs-show-block)
	    (define-key c-mode-map (kbd "C-c C-b") 'hs-hide-block)
	    (define-key c-mode-map (kbd "C-c C-M-s") 'hs-show-all)
	    (define-key c-mode-map (kbd "C-c C-M-b") 'hs-hide-all)))
(add-hook 'winner-mode-hook
	  (lambda ()
	    (define-key winner-mode-map (kbd "C-c w <left>") 'winner-undo)
	    (define-key winner-mode-map (kbd "C-c w <right>") 'winner-redo)
	    (define-key winner-mode-map (kbd "C-c <left>") 'windmove-left)
	    (define-key winner-mode-map (kbd "C-c <right>") 'windmove-right)))

;; functions used in hooks
(defun set-lisp-comments ()
  (setq comment-start "; "
	comment-end ""))

;; add-ons
(add-to-list 'load-path "~/Copy/42/git/tf-config/emacs-load")
(require 'sr-speedbar)
(require 'php-mode)

;; Enable mouse support
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] '(lambda ()
			      (interactive)
			      (scroll-down
			       2)))
  (global-set-key [mouse-5] '(lambda ()
			      (interactive)
			      (scroll-up
			       2)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t))

;; http://emacsredux.com/blog/2013/05/04/rename-file-and-buffer/
(defun rename-file-and-buffer ()
  "Rename the current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
	(if (not (and filename (file-exists-p filename)))
		(message "Buffer is not visiting a file!")
	  (let ((new-name (read-file-name "New name: " filename)))
		(cond
		 ((vc-backend filename) (vc-rename-file filename new-name))
		 (t
		  (rename-file filename new-name t)
		            (set-visited-file-name new-name t t)))))))
(global-set-key (kbd "C-c r")  'rename-file-and-buffer)
