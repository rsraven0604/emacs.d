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
   (org-agenda-files . '("~/Dropbox/agenda/"))
   (system-time-locale . "C")
   (org-hide-leading-stars . t)
   (org-startup-folded . nil)
   (org-todo-keywords . '((sequence "TASK(t)" "WAIT(w)" "|" "DONE(d)" "ABORT(a)" "SOMEDAY(s)")))
   (org-tag-alist . '(("PROJECT" . ?p) ("MEMO" . ?m) ("PETIT" . ?t)))
   (org-startup-indented . t)
   (org-capture-templates . 
    '(("t" "Task" entry (file+headline org-default-notes-file "inbox")
       "** TASK %?\n   CREATED: %U\n")
      ("i" "Idea" entry (file+headline org-default-notes-file "idea")
       "** %?\n   CREATED: %U\n")
      ("k" "Knowledge" entry (file+headline org-default-notes-file "knowledge")
       "** %?\n   CREATED: %U\n")))
   (org-refile-targets . '((org-agenda-files :maxlevel . 1)))
   (org-log-done . 'time)
   (org-clock-clocked-in-display . 'frame-title))
  :init
  (setq org-default-notes-file (concat org-directory "main.org"))
  (defun my:org-goto-inbox ()
    (interactive)
    (find-file org-default-notes-file))
  :bind
  (("C-c a" . org-agenda)
   ("C-c c" . org-capture)
   ("C-c g" . org-clock-goto)
   ("C-c i" . my:org-goto-inbox))
  :bind
  (:org-mode-map
   ("C-m" . org-return-indent)
   ("M-n" . org-forward-same-level)
   ("M-p" . org-backward-same-level)))

(leaf org-agenda
  :commands org-agenda
  :pre-setq
  ((org-agenda-custom-commands . 
    '(("x" "Unscheduled Tasks" tags-todo
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
  (org-roam-db-autosync-mode)
  (require 'org-roam-protocol)
  :bind
  (("C-c n l" . org-roam-buffer-toggle)
   ("C-c n f" . org-roam-node-find)
   ("C-c n g" . org-roam-graph)
   ("C-c n i" . org-roam-node-insert)
   ("C-c n c" . org-roam-capture)
   ("C-c n j" . org-roam-dailies-capture-today)))

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
  :ensure t
  :bind
  (("C-s" . consult-line)
   ("C-x b" . consult-buffer)
   ("C-x C-r" . consult-recent-file)
   ("M-y" . consult-yank-pop)))

(leaf orderless
  :ensure t
  :custom
  ((completion-styles . '(orderless))
   (completion-category-defaults . nil)))

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

(leaf lsp-mode
  :ensure t
  :hook (python-mode . lsp)
  :pre-setq
  ((lsp-enable-links . nil))
  :config
  (lsp-enable-which-key-integration t))

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
