;; パッケージリポジトリの設定
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(package-initialize)

;; leafの設定
(unless (package-installed-p 'leaf)
  (package-refresh-contents)
  (package-install 'leaf))

(leaf leaf
  :ensure t
  :require t)

;; leaf-keywordsの設定（:ensureなどを使うため）
(leaf leaf-keywords
  :ensure t
  :require t
  :config
  (leaf-keywords-init))

;; 余計なファイルを生成しない
(leaf files
  :config
  (setq make-backup-files nil)
  (setq auto-save-default nil)
  (setq auto-save-list-file-prefix nil))

;; UI設定
(leaf ui-config
  :config
  (setq inhibit-startup-message t)
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (global-display-line-numbers-mode t)
  (global-font-lock-mode t)
  (setq show-trailing-whitespace t))

;; インデント設定
(leaf indentation
  :config
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 4)
  (setq indent-line-function 'insert-tab))

;; フォント設定
(leaf font-config
  :config
  (set-face-attribute 'default nil :family "Monaspace Xenon Var" :height 120)
  (setq-default line-spacing 0.2)
  (set-frame-size (selected-frame) 120 48))

;; キーバインド設定
(leaf keybindings
  :config
  (defun other-window-or-split (val)
    (interactive)
    (when (one-window-p)
      (split-window-horizontally))
    (other-window val))
  :bind
  (("C-h" . delete-backward-char)
   ("C-t" . (lambda () (interactive) (other-window-or-split 1)))))

;; テーマの設定
(leaf zenburn-theme
  :ensure t
  :pre-setq
  ((zenburn-use-variable-pitch . t)
   (zenburn-scale-org-headlines . t)
   (zenburn-scale-outline-headlines . t)
   (zenburn-override-colors-alist . 
    '(("zenburn-bg-2" . "#040403")
      ("zenburn-bg-1" . "#080806")          
      ("zenburn-bg-08" . "#121210")          
      ("zenburn-bg-05" . "#121210")
      ("zenburn-bg"    . "#151511")
      ("zenburn-bg+0"  . "#161613")
      ("zenburn-bg+04" . "#171714")
      ("zenburn-bg+05" . "#181816")
      ("zenburn-bg+1"  . "#1F1F1C")
      ("zenburn-bg+2"  . "#2F2F24")
      ("zenburn-bg+3"  . "#3F3F30")
      ("zenburn-fg"    . "#DCDCCC")
      ("zenburn-fg+1"  . "#E0DCC0")
      ("zenburn-fg+2"  . "#E4DCC8"))))
  :config
  (load-theme 'zenburn t))

;; 背景透過
(leaf transparency
  :config
  (set-frame-parameter nil 'alpha-background 85)
  (add-to-list 'default-frame-alist '(alpha-background . 85)))

;; 参考 https://a.conao3.com/blog/2024/7c7c265/

;; autorevert Emacs外でファイルが更新された時に更新する
(leaf autorevert
  :doc "revert buffers when files on disk change"
  :global-minor-mode global-auto-revert-mode)

(leaf paren
  :doc "highlight matching paren"
  :global-minor-mode show-paren-mode)

(leaf savehist
  :doc "Save minibuffer history"
  :custom `((savehist-file . ,(locate-user-emacs-file "savehist")))
  :global-minor-mode t)

;; magit
(leaf magit
  :ensure t
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch-popup)))

;; Treemacs
(leaf treemacs
  :ensure t
  :config
  (setq treemacs-collapse-dirs (if treemacs-python-executable 3 0))
  (setq treemacs-deferred-git-apply-delay 0.5)
  (setq treemacs-directory-name-transformer #'identity)
  (setq treemacs-display-in-side-window t)
  (setq treemacs-eldoc-display 'simple)
  (setq treemacs-file-event-delay 2000)
  (setq treemacs-file-extension-regex treemacs-last-period-regex-value)
  (setq treemacs-file-follow-delay 0.2)
  (setq treemacs-file-name-transformer #'identity)
  (setq treemacs-follow-after-init t)
  (setq treemacs-expand-after-init t)
  (setq treemacs-find-workspace-method 'find-for-file-or-pick-first)
  (setq treemacs-git-command-pipe "")
  (setq treemacs-goto-tag-strategy 'refetch-index)
  (setq treemacs-header-scroll-indicators '(nil . "^^^^^^"))
  (setq treemacs-hide-dot-git-directory t)
  (setq treemacs-indentation 2)
  (setq treemacs-indentation-string " ")
  (setq treemacs-is-never-other-window t)
  (setq treemacs-max-git-entries 5000)
  (setq treemacs-missing-project-action 'ask)
  (setq treemacs-move-files-by-mouse-dragging t)
  (setq treemacs-move-forward-on-expand nil)
  (setq treemacs-no-png-images nil)
  (setq treemacs-no-delete-other-windows t)
  (setq treemacs-project-follow-cleanup nil)
  (setq treemacs-position 'left)
  (setq treemacs-read-string-input 'from-child-frame)
  (setq treemacs-recenter-distance 0.1)
  (setq treemacs-recenter-after-file-follow nil)
  (setq treemacs-recenter-after-tag-follow nil)
  (setq treemacs-recenter-after-project-jump 'always)
  (setq treemacs-recenter-after-project-expand 'on-distance)
  (setq treemacs-litter-directories '("/node_modules" "/.venv" "/.cask"))
  (setq treemacs-project-follow-into-home nil)
  (setq treemacs-show-cursor nil)
  (setq treemacs-show-hidden-files t)
  (setq treemacs-silent-filewatch nil)
  (setq treemacs-silent-refresh nil)
  (setq treemacs-sorting 'alphabetic-asc)
  (setq treemacs-select-when-already-in-treemacs 'move-back)
  (setq treemacs-space-between-root-nodes t)
  (setq treemacs-tag-follow-cleanup t)
  (setq treemacs-tag-follow-delay 1.5)
  (setq treemacs-text-scale nil)
  (setq treemacs-user-mode-line-format nil)
  (setq treemacs-user-header-line-format nil)
  (setq treemacs-wide-toggle-width 70)
  (setq treemacs-width 35)
  (setq treemacs-width-increment 1)
  (setq treemacs-width-is-initially-locked t)
  (setq treemacs-workspace-switch-cleanup nil)
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (treemacs-fringe-indicator-mode 'always)
  (when treemacs-python-executable
    (treemacs-git-commit-diff-mode t))
  (pcase (cons (not (null (executable-find "git")))
               (not (null treemacs-python-executable)))
    (`(t . t)
     (treemacs-git-mode 'deferred))
    (`(t . _)
     (treemacs-git-mode 'simple)))
  (treemacs-hide-gitignored-files-mode nil)
  (treemacs-start-on-boot)
  :bind
  (("M-0"       . treemacs-select-window)
   ("C-x t 1"   . treemacs-delete-other-windows)
   ("C-x t t"   . treemacs)
   ("C-x t d"   . treemacs-select-directory)
   ("C-x t B"   . treemacs-bookmark)
   ("C-x t C-t" . treemacs-find-file)
   ("C-x t M-t" . treemacs-find-tag)))

;; Treemacs関連プラグイン
(leaf treemacs-nerd-icons
  :ensure t
  :after treemacs
  :config
  (treemacs-load-theme "nerd-icons")
  (setq treemacs-nerd-icons-scale-factor 1.0)
  (setq treemacs-nerd-icons-hl-face 'treemacs-root-face))

(leaf treemacs-icons-dired
  :ensure t
  :hook (dired-mode . treemacs-icons-dired-enable-once))

(leaf treemacs-magit
  :ensure t
  :after (treemacs magit))

;; org-mode設定
(leaf org
  :mode (("\\.org\\'" . org-mode))
  :pre-setq
  ((org-directory . "~/Dropbox/agenda/")
   (system-time-locale . "C")
   (org-hide-leading-stars . t)
   (org-startup-folded . nil)
   (org-todo-keywords . '((sequence "INBOX(i)" "TODO(t)" "NEXT(n)" "WAIT(w)" "PROJECT(p)" "|" "DONE(d)" "CANCELLED(c)" "SOMEDAY(s)")))
   (org-tag-alist . '(("@office" . ?o) ("@home" . ?h) ("@computer" . ?c) ("@phone" . ?p) ("@errands" . ?e) 
                      ("@agenda" . ?a) ("@reading" . ?r) ("@waiting" . ?w)
                      ("energy_high" . ?H) ("energy_low" . ?L) ("time_15min" . ?1) ("time_30min" . ?3) ("time_1hr" . ?6)))
   (org-startup-indented . t)
   (org-capture-templates . 
    '(("i" "📥 Inbox (GTD)" entry (file+headline org-default-notes-file "inbox")
       "** INBOX %?\n   CREATED: %U\n")
      ("t" "✅ Next Action (GTD)" entry (file+headline org-default-notes-file "next_actions")
       "** TODO %? %^G\n   CREATED: %U\n")
      ("p" "📋 Project (GTD)" entry (file+headline org-default-notes-file "projects")
       "** PROJECT %^{Project Name} %^G\n   CREATED: %U\n   %?")))
   (org-refile-targets . '((org-agenda-files :maxlevel . 1)))
   (org-log-done . 'time)
   (org-clock-clocked-in-display . 'frame-title))
  :init
  (setq org-default-notes-file (concat org-directory "main.org"))
  :config
  ;; org-agenda-filesの設定
  (setq org-agenda-files 
        (append '("~/Dropbox/agenda/")
                (when (file-exists-p "~/Dropbox/roam/daily/")
                  (directory-files-recursively "~/Dropbox/roam/daily/" "\\.org$"))))
  (defun my:org-goto-inbox ()
    (interactive)
    (find-file org-default-notes-file))
  (defun my:org-goto-diary ()
    "Open current month's diary file"
    (interactive)
    (find-file (concat "~/Dropbox/diary/" (format-time-string "%Y%m") ".org")))
  (defun my:org-goto-diary-today ()
    "Open today's entry in diary"
    (interactive)
    (my:org-goto-diary)
    (goto-char (point-min))
    (search-forward (format-time-string "* %Y-%m-%d") nil t))
  (defun my:refresh-org-agenda-files ()
    "Refresh org-agenda-files to include new org-roam daily files"
    (interactive)
    (setq org-agenda-files 
          (append '("~/Dropbox/agenda/")
                  (when (file-exists-p "~/Dropbox/roam/daily/")
                    (directory-files-recursively "~/Dropbox/roam/daily/" "\\.org$"))))
    (message "Refreshed org-agenda-files with %d files" (length org-agenda-files)))
  :bind
  (("C-c a" . org-agenda)
   ("C-c c" . org-capture)
   ("C-c g" . org-clock-goto)
   ("C-c i" . my:org-goto-inbox)
   ("C-c d" . my:org-goto-diary)
   ("C-c C-d" . my:org-goto-diary-today)
   ("C-c A" . my:refresh-org-agenda-files))
  :bind
  (:org-mode-map
   ("C-m" . org-return-indent)
   ("M-n" . org-forward-same-level)
   ("M-p" . org-backward-same-level)))

(leaf org-agenda
  :commands org-agenda
  :pre-setq
  ((org-agenda-custom-commands . 
    '(("g" . "GTD Views")
      ("gi" "Inbox" tags-todo "TODO=\"INBOX\"")
      ("gn" "Next Actions" tags-todo "TODO=\"NEXT\"")
      ("gw" "Waiting For" tags-todo "TODO=\"WAIT\"")
      ("gp" "Projects" tags-todo "TODO=\"PROJECT\"")
      ("gs" "Someday/Maybe" tags-todo "TODO=\"SOMEDAY\"")
      ("gc" "Contexts")
      ("gco" "@office" tags-todo "@office")
      ("gch" "@home" tags-todo "@home")
      ("gcc" "@computer" tags-todo "@computer")
      ("gcp" "@phone" tags-todo "@phone")
      ("gce" "@errands" tags-todo "@errands")
      ("gr" "Reviews")
      ("grd" "Daily Review" agenda ""
       ((org-agenda-span 1)))
      ("grw" "Weekly Review" agenda ""
       ((org-agenda-span 7)))
      ("gru" "Unscheduled" tags-todo
       "-SCHEDULED>=\"<today>\"-DEADLINE>=\"<today>\"")
      ("x" "Unscheduled Tasks" tags-todo
       "-SCHEDULED>=\"<today>\"-DEADLINE>=\"<today>\"" nil)
      ("d" "Daily Tasks" agenda ""
       ((org-agenda-span 1)))))
   (org-agenda-skip-scheduled-if-done . t)
   (org-return-follows-link . t)
   (org-agenda-columns-add-appointments-to-effort-sum . t)
   (org-agenda-time-grid . 
    '((daily today require-timed)
      (0900 1200 1300 2000) "......" "----------------"))
   (org-columns-default-format . 
    "%68ITEM(Task) %6Effort(Effort){:} %6CLOCKSUM(Clock){:}"))
  :config
  (defadvice org-agenda-switch-to (after org-agenda-close)
    "Close a org-agenda window when RET is hit on the window."
    (progn (delete-other-windows)
           (recenter-top-bottom)))
  (ad-activate 'org-agenda-switch-to)
  :bind
  (:org-agenda-mode-map
   ("s" . org-agenda-schedule)
   ("S" . org-save-all-org-buffers)))

(leaf org-roam
  :ensure t
  :config
  (setq org-roam-database-connector 'sqlite-builtin)
  (setq org-roam-directory (file-truename "~/Dropbox/roam"))
  (setq org-roam-node-display-template 
        (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (setq org-roam-db-location "~/.org-roam.db")
  (setq org-roam-index-file "~/Dropbox/roam/Index.org")
  
  ;; org-roam-capture-templates設定（知識管理専用）
  (setq org-roam-capture-templates
        '(("d" "🧠 Knowledge Note" plain "%?"
           :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                             "#+title: ${title}\n#+date: %U\n\n")
           :unnarrowed t)
          ("s" "💻 Code Snippet" plain "#+begin_src %^{Language}\n%?\n#+end_src"
           :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                             "#+title: ${title}\n#+date: %U\n#+filetags: :snippet:\n\n")
           :unnarrowed t)
          ("r" "📚 Reference" plain "URL: %^{URL}\n\n%?"
           :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                             "#+title: ${title}\n#+date: %U\n#+filetags: :reference:\n\n")
           :unnarrowed t)))

  ;; org-roam-dailies設定
  (setq org-roam-dailies-directory "daily/")
  (setq org-roam-dailies-capture-templates
        '(("d" "default" entry
           "* %<%H:%M> %?"
           :target (file+head "%<%Y-%m-%d>.org"
                             "#+title: %<%Y-%m-%d>\n#+filetags: :daily:\n\n"))
          ("t" "task" entry
           "* %<%H:%M> TASK %?"
           :target (file+head "%<%Y-%m-%d>.org"
                             "#+title: %<%Y-%m-%d>\n#+filetags: :daily:\n\n"))
          ("m" "meeting" entry
           "* %<%H:%M> %^{Meeting} :meeting:\n** 参加者: %^{Participants}\n** アジェンダ:\n%?"
           :target (file+head "%<%Y-%m-%d>.org"
                             "#+title: %<%Y-%m-%d>\n#+filetags: :daily:\n\n"))
          ("l" "log" entry
           "* %<%H:%M> %^{Title} :log:\n#+begin_src %^{Language}\n%?\n#+end_src"
           :target (file+head "%<%Y-%m-%d>.org"
                             "#+title: %<%Y-%m-%d>\n#+filetags: :daily:\n\n"))))
  
  (org-roam-db-autosync-mode)
  (require 'org-roam-protocol)
  :bind
  (("C-c n l" . org-roam-buffer-toggle)
   ("C-c n f" . org-roam-node-find)
   ("C-c n g" . org-roam-graph)
   ("C-c n i" . org-roam-node-insert)
   ("C-c n c" . org-roam-capture)
   ("C-c n j" . org-roam-dailies-capture-today)
   ("C-c n d" . org-roam-dailies-goto-today)
   ("C-c n y" . org-roam-dailies-goto-yesterday)
   ("C-c n t" . org-roam-dailies-goto-tomorrow)
   ("C-c n D" . org-roam-dailies-goto-date)))
(leaf ob-mermaid
  :ensure t
  :pre-setq
  ((ob-mermaid-cli-path . "/usr/bin/mmdc"))
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((mermaid . t)
     (scheme . t))))

(leaf mermaid-mode
  :ensure t
  :pre-setq
  ((mermaid-output-format . "/usr/bin/mmdc")))

(leaf org-modern
  :ensure t
  :hook (org-mode . global-org-modern-mode))

(leaf org-modern-indent
  :load-path "~/repos/org-modern-indent/"
  :hook ((org-mode . org-indent-mode)
         (org-mode . org-modern-indent-mode)))

(leaf org-superstar
  :load-path "~/repos/org-superstar-mode/"
  :hook (org-mode . org-superstar-mode))

;; GitHub Copilot
(leaf copilot
  :vc (:url "https://github.com/copilot-emacs/copilot.el"
            :rev :newest
            :branch "main")
  :hook (prog-mode . copilot-mode)
  :pre-setq
  ((copilot-indent-offset-warning-disable . t)
   (copilot-max-char-warning-disabled . t))
  :bind
  (:copilot-completion-map
   ("C-e" . copilot-accept-completion)
   ("M-f" . copilot-accept-completion-by-word)
   ("C-M-f" . copilot-accept-completion-by-paragraph)
   ("M-n" . copilot-accept-completion-by-line)
   ("C-M-n" . copilot-next-completion)
   ("C-M-p" . copilot-previous-completion))
  :bind
  (:copilot-mode-map
   ("M-i" . copilot-complete)))

;; 補完システム
(leaf vertico
  :ensure t
  :global-minor-mode t)

(leaf marginalia
  :ensure t
  :after vertico
  :global-minor-mode t)

(leaf consult
  :doc "Consulting completing-read"
  :ensure t
  :hook (completion-list-mode-hook . consult-preview-at-point-mode)
  :defun consult-line
  :preface
  (defun c/consult-line (&optional at-point)
    "Consult-line uses things-at-point if set C-u prefix."
    (interactive "P")
    (if at-point
        (consult-line (thing-at-point 'symbol))
      (consult-line)))
  :custom ((xref-show-xrefs-function . #'consult-xref)
           (xref-show-definitions-function . #'consult-xref)
           (consult-line-start-from-top . t))
  :bind (;; C-c bindings (mode-specific-map)
         ([remap switch-to-buffer] . consult-buffer) ; C-x b
         ([remap project-switch-to-buffer] . consult-project-buffer) ; C-x p b

         ;; M-g bindings (goto-map)
         ([remap goto-line] . consult-goto-line)    ; M-g g
         ([remap imenu] . consult-imenu)            ; M-g i
         ("M-g f" . consult-flymake)

         ;; C-M-s bindings
         ("C-s" . c/consult-line)       ; isearch-forward
         ("C-M-s" . nil)                ; isearch-forward-regexp
         ("C-M-s s" . isearch-forward)
         ("C-M-s C-s" . isearch-forward-regexp)
         ("C-M-s r" . consult-ripgrep)

         (minibuffer-local-map
          :package emacs
          ("C-r" . consult-history))))

(leaf affe
  :doc "Asynchronous Fuzzy Finder for Emacs"
  :ensure t
  :custom ((affe-highlight-function . 'orderless-highlight-matches)
           (affe-regexp-function . 'orderless-pattern-compiler))
  :bind (("C-M-s r" . affe-grep)
         ("C-M-s f" . affe-find)))

(leaf orderless
  :ensure t
  :custom
  ((completion-styles . '(orderless))
   (completion-category-defaults . nil)))

(leaf corfu
  :doc "COmpletion in Region FUnction"
  :ensure t
  :global-minor-mode global-corfu-mode corfu-popupinfo-mode
  :custom ((corfu-auto . t)
           (corfu-auto-delay . 0)
           (corfu-auto-prefix . 1)
           (corfu-popupinfo-delay . nil)) ; manual
  :bind ((corfu-map
          ("C-s" . corfu-insert-separator))))

(leaf cape
  :doc "Completion At Point Extensions"
  :ensure t
  :config
  (add-to-list 'completion-at-point-functions #'cape-file))

(leaf recentf
  :global-minor-mode t
  :pre-setq
  ((recentf-max-menu-items . 100)
   (recentf-max-saved-items . 200)
   (recentf-auto-cleanup . 'never)))

;; Python開発環境
(leaf pyvenv
  :ensure t
  :config
  (setenv "WORKON_HOME" "~/.virtualenvs")
  (pyvenv-mode 1))

(leaf eglot
  :doc "The Emacs Client for LSP servers"
  :hook ((clojure-mode-hook . eglot-ensure))
  :custom ((eldoc-echo-area-use-multiline-p . nil)
           (eglot-connect-timeout . 600)))

(leaf eglot-booster
  :when (executable-find "emacs-lsp-booster")
  :vc ( :url "https://github.com/jdtsmith/eglot-booster")
  :global-minor-mode t)

(leaf flycheck
  :ensure t
  :global-minor-mode t)

(leaf blacken
  :ensure t
  :hook (python-mode . blacken-mode)
  :pre-setq
  ((blacken-line-length . 99)
   (blacken-fast-unsafe . t)))

(leaf company
  :ensure t
  :global-minor-mode t
  :pre-setq
  ((company-idle-delay . 0.2)
   (company-minimum-prefix-length . 1)
   (company-selection-wrap-around . t)
   (company-tooltip-align-annotations . t)))

(leaf company-box
  :ensure t
  :hook (company-mode . company-box-mode)
  :pre-setq
  ((company-box-show-single-candidate . t)))

(leaf git-gutter
  :ensure t
  :global-minor-mode t)

;; 自動生成された設定（そのまま残す）
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(blacken company-box consult copilot elpy flycheck git-gutter leaf
             leuven-theme lsp-mode marginalia material-theme
             mermaid-mode modus-themes nord-theme ob-mermaid orderless
             org-modern org-roam treemacs-icons-dired treemacs-magit
             treemacs-nerd-icons vertico zenburn-theme))
 '(package-vc-selected-packages
   '((copilot :url "https://github.com/copilot-emacs/copilot.el" :branch
              "main"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
