;; [[file:README.org::Package-Init][Package-Init]]
(require 'package)
(add-to-list 'package-archives '("elpa" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-devel" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))

(package-initialize)
;; (package-refresh-contents) Uncomment When Done Configuring
;; Package-Init ends here

;; [[file:README.org::Appearance][Appearance]]
(setq debug-on-error t) ;; Debug on Errors
(setq image-auto-resize nil) ;; Resize Images

(setq-default indent-tabs-mode nil) ;; Set Default Tab to Two Spaces
(setq-default tab-width 2)

(add-to-list 'default-frame-alist '(foreground-color . "#FFFFFF")) ;; Background
(add-to-list 'default-frame-alist '(background-color . "#000000")) ;; Foreground
(add-to-list 'default-frame-alist '(fullscreen . maximized)) ;; Start Maximized

(set-frame-parameter nil 'alpha-background 100)
(add-to-list 'default-frame-alist '(alpha-background . 100))

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(set-face-attribute 'default nil :font "Noto Sans Mono")
(set-fontset-font t 'unicode (font-spec :family "Noto Color Emoji"))
(set-face-foreground 'font-lock-comment-face "#C28aa1")
;; Appearance ends here

;; [[file:README.org::Org Mode Appearance][Org Mode Appearance]]
(require 'org)
(require 'org-modern)
(add-hook 'org-mode-hook #'org-modern-mode)

(setq org-hide-emphasis-markers t)
(setq org-confirm-babel-evaluate nil)
(setq org-hide-keywords t)

(custom-set-faces
 '(org-block
   (
    (t
     (:background "#0a0017" :foreground "white" :weight normal)
     ))))
;; Org Mode Appearance ends here

;; [[file:README.org::General Environment][General Environment]]
(setq inhibit-startup-screen t)
(setq backup-directory-alist `(("." . ,"~/.emacs.d/.backups")))
(setq make-backup-files t)
(setq backup-by-copying t)
(setq version-control t)
(setq delete-old-versions t)
(setq delete-by-moving-to-trash t)
(setq kept-old-versions 5)
(setq kept-new-versions 10)
(setq auto-save-default t)
(setq auto-save-timeout 20)
(setq auto-save-interval 200)
(defalias 'yes-or-no-p 'y-or-n-p)

(global-auto-revert-mode 1) ;; Refresh Buffers on Change
(setq global-auto-revert-non-file-buffers t)
(setq auto-rever-verbose nil)

(add-to-list 'display-buffer-alist '("\\*Buffer List\\*" (display-buffer-same-window)))


;; Open Ansi-Term as Default Terminal Emulator
(defun open-ansi-term-here (dir) "Open an ansi-term in DIR."
       (let (
             (default-directory
              (file-name-as-directory
               (expand-file-name dir))))
         (ansi-term (getenv "SHELL")))) 

;; Reload the Init File
(defun reload-init ()
  "Reloading Emacs Init"
  (interactive)
  (load-file user-init-file))

(defun ensure-package-and-require (pkg)
  "Install PKG if it isn't installed, then require it."
  (unless (package-installed-p pkg)
    (package-install pkg))
  (require pkg))

(add-hook 'emacs-startup-hook (lambda () (interactive) (ansi-term (getenv "SHELL"))))
;; General Environment ends here

;; [[file:README.org::Org Latex][Org Latex]]
(with-eval-after-load 'org
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

(setq org-latex-listings 'minted)
(setq org-latex-packages-alist '(("" "minted")))
(setq org-latex-minted-options
      '(("breaklines" "true")
        ("fontsize" "\\scriptsize")
        ("frame" "single")))
;; Org Latex ends here

;; [[file:README.org::Org Links][Org Links]]
(add-hook 'org-mode-hook #'hs-minor-mode)
(add-hook 'org-mode-hook #'yas-minor-mode)
;; Org Links ends here

;; [[file:README.org::Org Programming][Org Programming]]
(require 'ob)
(require 'ob-python)
(unless (package-installed-p 'ess)
  (package-refresh-contents)
  (package-install 'corfu))
(require 'ess)
(require 'ess-site)
(require 'ob-R)
(require 'ob-julia)
;; Org Programming ends here

;; [[file:README.org::Org Babel Languages][Org Babel Languages]]
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (C          . t)
   (R          . t)
   (python     . t)
   (latex      . t)
   (shell      . t)
   (julia      . t)))
;; Org Babel Languages ends here

;; [[file:README.org::Remote Shortcuts][Remote Shortcuts]]
(add-to-list 'load-path "~/.emacs.d/lisp/") 
(require 'remote-shortcuts)
;; Remote Shortcuts ends here

;; [[file:README.org::Global-Keybinds][Global-Keybinds]]
(global-set-key (kbd "C-h C-r") 'reload-init)
(global-set-key (kbd "M-s M-s")
                (lambda ()
                  (interactive)
                  (ansi-term (getenv "SHELL"))))
;; Global-Keybinds ends here

;; [[file:README.org::C++-Mode-Keybinds][C++-Mode-Keybinds]]
(add-hook 'c++-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-v") 'compile)))
;; C++-Mode-Keybinds ends here

;; [[file:README.org::Snippets][Snippets]]
(require 'yasnippet)
(yas-global-mode 1)
;; Snippets ends here

;; [[file:README.org::Treemacs Configs][Treemacs Configs]]
(unless (package-installed-p 'treemacs)
  (package-refresh-contents)
  (package-install 'treemacs))
(unless (package-installed-p 's)
  (package-refresh-contents)
  (package-install 's))

(require 'treemacs)
(require 's)

(with-eval-after-load 'treemacs
  (defun treemacs-custom-filter (file _)
    (or (s-ends-with? ".aux" file)
        (s-ends-with? ".log" file)
        (s-ends-with? ".o" file)
        (s-ends-with? ".pyc" file)
        (s-ends-with? ".bak" file)
        (s-ends-with? "~" file)))
  
  (add-to-list 'treemacs-ignored-file-predicates
               #'treemacs-custom-filter))
;; Treemacs Configs ends here

;; [[file:README.org::Magit Setup][Magit Setup]]
(unless (package-installed-p 'magit)
  (package-refresh-contents)
  (package-install 'magit))
(require 'magit)
(setq magit-diff-refine-hunk 'all)
(global-auto-revert-mode 1)
;; Magit Setup ends here

;; [[file:README.org::General Programming Hooks][General Programming Hooks]]
(add-hook 'prog-mode-hook #'hs-minor-mode)
;; General Programming Hooks ends here

;; [[file:README.org::Disable Flymake][Disable Flymake]]
(setq flymake-diagnostic-functions
      (remove 'flymake-cc flymake-diagnostic-functions))
(add-hook 'c-mode-hook
          (lambda ()
            (setq-local flymake-diagnostic-functions nil)))
(add-hook 'c++-mode-hook
          (lambda ()
            (setq-local flymake-diagnostic-functions nil)))
(add-hook 'python-mode-hook
        (lambda ()
          (setq-local flymake-diagnostic-functions nil)))
;; Disable Flymake ends here

;; [[file:README.org::imenu][imenu]]
(unless (package-installed-p 'imenu-list)
 (package-refresh-contents)
 (package-install 'imenu-list))
(require 'imenu-list)
(setq imenu-list-focus-after-activation t
      imenu-list-auto-resize t
      imenu-list-size 30)
(global-set-key (kbd "C-c i") #'imenu-list-smart-toggle)
(add-hook 'prog-mode-hook #'outline-minor-mode)
;; imenu ends here

;; [[file:README.org::Python Environment Setup][Python Environment Setup]]
(require 'pyvenv)
(pyvenv-mode 1)
(pyvenv-tracking-mode 1)
;; Python Environment Setup ends here

;; [[file:README.org::Emacs IPython Notebooks][Emacs IPython Notebooks]]
(unless (package-installed-p 'ein)
  (package-refresh-contents)
  (package-install ein))

(require 'ein)
(setq ein:jupyter-default-server-command
    (lambda ()
      (expand-file-name "bin/jupyter" pyvenv-virtual-env)))
(add-to-list 'auto-mode-alist '("\\.ipynb\\'" . ein:notebook-mode))
;; Emacs IPython Notebooks ends here

;; [[file:README.org::Debuggers][Debuggers]]
(unless (package-installed-p 'dap-mode)
         (package-refresh-contents)
         (package-install 'dap-mode))
(require 'dap-gdb-lldb)
(require 'dap-cpptools)
(require 'dap-ui)
(dap-ui-mode 1)
;; Optional: automatically enable DAP for C/C++ buffers
(add-hook 'c++-mode-hook #'dap-mode)
(add-hook 'c-mode-hook #'dap-mode)
;; Debuggers ends here

;; [[file:README.org::*Eglot][Eglot:1]]
(require 'eglot)
;; Eglot:1 ends here

;; [[file:README.org::Python Eglot][Python Eglot]]
(add-hook 'python-mode-hook #'eglot-ensure)

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(python-mode
                 . ("/home/alex/.pyenv/shims/pyright-langserver" "--stdio")))
  (add-to-list 'eglot-server-programs
               '(python-ts-mode
                 . ("/home/alex/.pyenv/shims/pyright-langserver" "--stdio")))
  )
;; Python Eglot ends here

;; [[file:README.org::C and C++ Eglot][C and C++ Eglot]]
(add-hook 'c-mode-hook #'eglot-ensure)
(add-hook 'c++-mode-hook #'eglot-ensure)

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(c++-mode
                 . ("clangd")))
  (add-to-list 'eglot-server-programs
               '(c-mode
                 . ("clangd")))
  )
;; C and C++ Eglot ends here

;; [[file:README.org::Corfu Completion Rules][Corfu Completion Rules]]
(unless (package-installed-p 'corfu)
  (package-refresh-contents)
  (package-install 'corfu))
(require 'corfu)
(require 'corfu-popupinfo)

(global-corfu-mode 1)
(setq corfu-auto t)
(setq corfu-cycle t)
(setq corfu-quit-no-match 'seperator)
(setq corfu-auto-delay 0)
(setq corfu-auto-prefix 1)

(define-key corfu-map (kbd "TAB") 'corfu-next)
(define-key corfu-map (kbd "<tab>") 'corfu-next)
(define-key corfu-map (kbd "S-TAB") 'corfu-next)
;; Corfu Completion Rules ends here

;; [[file:README.org::Eldoc Appearance Configuration][Eldoc Appearance Configuration]]
(unless (package-installed-p 'eldoc-box)
  (package-refresh-contents)
  (package-install 'eldoc-box))
(require 'eldoc-box)
(add-hook 'eglot-managed-mode-hook #'eldoc-box-hover-mode)

(setq eldoc-documentation-strategy 'eldoc-documentation-compose)
(setq eldoc-box-max-pixel-width 500)
(setq eldoc-box-max-pixel-height 400)
;; Eldoc Appearance Configuration ends here

;; [[file:README.org::*Conclusion][Conclusion:1]]
(provide 'init)
;; Conclusion:1 ends here
