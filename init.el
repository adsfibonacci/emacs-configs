;; Package Initialization
(require 'package)
(add-to-list 'package-archives '("elpa" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-devel" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(package-initialize)

(setq debug-on-error t)
(setq image-auto-resize nil) ; if you have such a package
;; Automatically revert all buffers when the underlying file changes
(global-auto-revert-mode 1)

(add-to-list 'default-frame-alist '(foreground-color . "#FFFFFF"))
(add-to-list 'default-frame-alist '(background-color . "#000000"))
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Include remote (TRAMP) files
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)  ;; optional, quiets messages
(add-hook 'image-mode-hook #'auto-revert-mode)

;; (add-to-list 'default-frame-alist '(alpha-background . 90)) ; For all new frames henceforth

(defun set-frame-opacity (alpha)
  "Set the current frame's transparency to ALPHA (1-100)."
  (interactive "nEnter opacity (1-100): ")
  (when (or (< alpha 1) (> alpha 100))
    (user-error "Opacity must be between 1 and 100"))
  (set-frame-parameter nil 'alpha alpha)
  (message "Frame opacity set to %d%%" alpha))

;; Bind to F9
(global-set-key (kbd "<f9>") 'set-frame-opacity)



;;(require 'ox-latex)
(require 'magit)
(require 'org)
(with-eval-after-load 'org
  ;; Ensure org-preview-latex-process-alist is defined
  (setq org-preview-latex-process-alist
        '((dvipng :programs ("latex" "dvipng")
                  :description "dvi > png"
                  :message "you need to install the programs: latex and dvipng."
                  :use-xcolor t
                  :image-input-type "dvi"
                  :image-output-type "png"
                  :image-size-adjust (1.0 . 1.0)
                  :latex-compiler ("latex -interaction nonstopmode -output-directory %o %f")
                  :image-converter ("dvipng -D %D -T tight -o %O %f")))))

(setq frameset-filter-alist
      '((background-color . nil)
        (foreground-color . nil)
        (cursor-color     . nil)
        (font             . nil)
        (tty-type         . nil)
        (tty              . nil)))


;; Enable hs-minor-mode in programming modes
(add-hook 'prog-mode-hook #'hs-minor-mode)
(add-hook 'org-mode-hook #'hs-minor-mode)

(require 'yasnippet)
(yas-global-mode 1)
(setq org-hide-emphasis-markers t)
(setq org-confirm-babel-evaluate nil)

(require 'org-modern)
(add-hook 'org-mode-hook #'org-modern-mode)
(add-hook 'org-mode-hook #'yas-minor-mode)
(require 'ob)
(require 'ob-python)
(require 'ob-R)
(require 'ob-julia)
(require 'ess-site)

(setq org-latex-listings 'minted)
(setq org-latex-packages-alist '(("" "minted")))
(setq org-latex-minted-options
      '(("breaklines" "true")
        ("fontsize" "\\scriptsize")
        ("frame" "single")))
	  
;; Appearance and functionality
;; (load-theme 'atom-one-dark t)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(set-frame-parameter nil 'alpha-background 100)
(add-to-list 'default-frame-alist '(alpha-background . 100))

;; Disable the built-in C/C++ Flymake backend (flymake-cc)
(setq flymake-diagnostic-functions
      (remove 'flymake-cc flymake-diagnostic-functions))

(add-hook 'c-mode-hook
          (lambda ()
            (setq-local flymake-diagnostic-functions
                        (remove 'flymake-cc flymake-diagnostic-functions))))

(add-hook 'c++-mode-hook
          (lambda ()
            (setq-local flymake-diagnostic-functions
                        (remove 'flymake-cc flymake-diagnostic-functions))))


;; Set Environment Variables
(setq inhibit-startup-screen t)
(setq backup-directory-alist `(("." . ,"~/.emacs.d/.backups")))
(setq make-backup-files t
      backup-by-copying t
      version-control t
      delete-old-versions t
      delete-by-moving-to-trash t
      kept-old-versions 6
      kept-new-versions 9
      auto-save-default t
      auto-save-timeout 20
      auto-save-interval 200
      )
(set-face-foreground 'font-lock-comment-face "#C28aa1")
(defalias 'yes-or-no-p 'y-or-n-p)

(require 'dap-gdb-lldb)
(require 'dap-cpptools)
(require 'lsp-mode)
(add-hook 'c++-mode-hook #'lsp)
(add-hook 'c-mode-hook #'lsp)
(add-hook 'lsp-mode-hook #'lsp-lens-mode)
(require 'rust-mode)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
(add-hook 'rust-mode-hook #'lsp)

(add-hook 'c++-mode-hook #'hs-minor-mode)
(add-hook 'c-mode-hook #'hs-minor-mode)

;; Example: change C++ keywords to bright red
(custom-set-faces
 '(font-lock-keyword-face ((t (:foreground "#FF5555" :weight bold))))
 '(font-lock-type-face ((t (:foreground "#F1FA8C"))))    ;; types in yellow
 '(font-lock-function-name-face ((t (:foreground "#8BE9FD")))) ;; functions in cyan
 '(font-lock-comment-face ((t (:foreground "#BB63E8")))) ;; comments in purple
 '(font-lock-string-face ((t (:foreground "#50FA7B")))) ;; strings in green
)


(global-auto-revert-mode t)

(setenv "WORKON_HOME" "~/.pyenv/versions/3.12.7")
(pyvenv-mode)
(pyvenv-activate "~/.pyenv/versions/3.12.7")
(with-eval-after-load 'flycheck
  (setq flycheck-gcc-include-path
        (list
         "/home/alex/.pyenv/versions/3.12.7/include/python3.12"
         "/home/alex/.pyenv/versions/3.12.7/lib/python3.12/site-packages/pybind11/include")))


;; Emacs Usability Hooks
(add-hook 'emacs-startup-hook (lambda () (interactive) (ansi-term (getenv "SHELL"))))

;; Emacs Keybinds
(global-set-key (kbd "C-h C-r") 'reload-init)
(global-set-key (kbd "C-x C-b") 'buffer-menu)
(global-set-key (kbd "M-s M-s") (lambda () (interactive) (ansi-term (getenv "SHELL"))))

(with-eval-after-load 'treemacs
  (defun treemacs-custom-filter (file _)
    (or (s-ends-with? ".aux" file)
        (s-ends-with? ".log" file)
	(s-ends-with? ".o" file)))
  (push #'treemacs-custom-filter treemacs-ignored-file-predicates))
(desktop-save-mode 1)
(defun reload-init ()
  "Reloading Emacs Init"
  (interactive)
  (load-file user-init-file))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(display-line-numbers-grow-only t)
 '(display-line-numbers-widen nil)
 '(display-line-numbers-width 2)
 '(elcord-boring-buffers-regexp-list
   '("^ " "\\\\*Messages\\\\*" "\\\\*ansi-term\\\\*"
     "\\\\*Customize Group: Elcord\\\\*" "\\\\*Buffer List\\\\*"))
 '(elcord-display-buffer-details t)
 '(elcord-display-line-numbers nil)
 '(elcord-editor-icon nil)
 '(elcord-idle-message "Researching...")
 '(elcord-idle-timer 600)
 '(elcord-quiet t)
 '(elcord-refresh-rate 10)
 '(org-babel-load-languages
   '((emacs-lisp . t) (C . t) (R . t) (python . t) (latex . t) (shell . t) (julia . t )))
 '(package-selected-packages
   '(## auctex dap-mode elcord ess linum-off
	lsp-latex lsp-ui magit neotree org-modern pdf-tools pyvenv
	rust-mode treemacs-all-the-icons yasnippet)) ;;atom-one-dark-theme 
 '(warning-suppress-types '((ox-latex))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-string-face ((t nil)))
 '(line-number ((t (:background "gray8" :foreground "thistle" :slant italic :width ultra-condensed))))
 '(line-number-current-line ((t (:background "gray20" :foreground "thistle" :slant italic :width ultra-condensed))))
 '(line-number-major-tick ((t (:background "grey75" :weight bold))))
 '(org-block ((t (:background "gray5" :foreground "dim gray" :weight semi-bold)))))
(provide 'init)
