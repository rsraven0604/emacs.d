;;; init.el --- Emacs init file -*- lexical-binding: t -*-

;; パッケージリポジトリの設定
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(package-initialize)

;; Custom が書き込む設定は init.el ではなく custom.el に置く（git 管理外）
(use-package emacs
  :config
  (setq custom-file (locate-user-emacs-file "custom.el"))
  (when (file-exists-p custom-file)
    (load custom-file)))

;; 余計なファイルを生成しない
(use-package files
  :config
  (setq make-backup-files nil)
  (setq auto-save-default nil)
  (setq auto-save-list-file-prefix nil))


;; UI設定
(use-package emacs
  :config
  (setq inhibit-startup-message t)
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (global-display-line-numbers-mode t)
  (global-font-lock-mode t)
  (setq-default show-trailing-whitespace t))

;; インデント設定
(use-package emacs
  :config
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 4))

;; フォント設定
(use-package emacs
  :config
  (set-face-attribute 'default nil :family "Monaspace Xenon NF" :height 120)
  ;; 行間は上下に半分ずつ置く（下だけに置くと、背景付きのラベルの中で文字が上に寄る。Emacs 31 から cons で書ける）
  (setq-default line-spacing '(0.1 . 0.1))
  ;; 日本語は Cica を 1.25 倍で使い、英字（10px）のちょうど2倍の幅（20px）にする（org の表の縦線を揃えるため）
  ;; 英字だけの行は 20px、日本語を含む行は 24px の高さになる（2026-10-10 実測）
  (setq face-font-rescale-alist '(("Cica" . 1.25)))
  (dolist (script '(han kana cjk-misc japanese-jisx0208))
    (set-fontset-font t script (font-spec :family "Cica")))
  (set-frame-size (selected-frame) 120 48))


;; キーバインド設定
(use-package emacs
  :preface
  (defun other-window-or-split (val)
    (interactive)
    (when (one-window-p)
      (split-window-horizontally))
    (other-window val))
  :bind
  (("C-h" . delete-backward-char)
   ("C-t" . (lambda () (interactive) (other-window-or-split 1)))))

;; テーマの設定
;; doom-sourcerer は doom-themes に含まれる（https://emacsthemes.com/themes/doom-sourcerer）
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-sourcerer t))

;; 背景透過
(use-package emacs
  :config
  (set-frame-parameter nil 'alpha-background 85)
  (add-to-list 'default-frame-alist '(alpha-background . 85)))

;; 参考 https://a.conao3.com/blog/2024/7c7c265/

;; autorevert Emacs外でファイルが更新された時に更新する
(use-package autorevert
  :config
  (global-auto-revert-mode 1))

;; 対応する括弧を強調する
(use-package paren
  :config
  (show-paren-mode 1))

;; ミニバッファの履歴を保存する
(use-package savehist
  :custom
  (savehist-file (locate-user-emacs-file "savehist"))
  :config
  (savehist-mode 1))

;; emacsclient から開けるようにサーバーを起動する（Claude Code の cockpit・確認シートから使う）
(use-package server
  :config
  (unless (server-running-p)
    (server-start)))

;; magit
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch-popup)))

;; Treemacs
(use-package treemacs
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
  :bind
  (("M-0"       . treemacs-select-window)
   ("C-x t 1"   . treemacs-delete-other-windows)
   ("C-x t t"   . treemacs)
   ("C-x t d"   . treemacs-select-directory)
   ("C-x t B"   . treemacs-bookmark)
   ("C-x t C-t" . treemacs-find-file)
   ("C-x t M-t" . treemacs-find-tag)))

;; Treemacs関連プラグイン
(use-package treemacs-nerd-icons
  :ensure t
  :after treemacs
  :config
  (treemacs-load-theme "nerd-icons")
  (setq treemacs-nerd-icons-scale-factor 1.0)
  (setq treemacs-nerd-icons-hl-face 'treemacs-root-face))

(use-package treemacs-icons-dired
  :ensure t
  :hook (dired-mode . treemacs-icons-dired-enable-once))

(use-package treemacs-magit
  :ensure t
  :after (treemacs magit))

;; org-mode設定
(use-package org
  :mode (("\\.org\\'" . org-mode))
  :preface
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
  (defvar-local my:org-wrap-off-in-table nil
    "カーソルが表の中にあるため折り返しを止めているとき t。")
  (defun my:org-toggle-wrap-at-table ()
    "カーソルが表の中にある間だけ折り返しを止める（折り返すと表の形が崩れるため）。"
    (let ((in-table (and (org-at-table-p) t)))
      (unless (eq in-table my:org-wrap-off-in-table)
        (setq my:org-wrap-off-in-table in-table)
        (if in-table
            (progn (visual-line-mode -1) (setq truncate-lines t))
          (visual-line-mode 1)))))
  (defun my:org-setup-look ()
    "org の見た目：行番号を消し、長い行を折り返す（表の中にいる間は折り返さない）。"
    (display-line-numbers-mode -1)
    (visual-line-mode 1)
    (add-hook 'post-command-hook #'my:org-toggle-wrap-at-table nil t))
  :init
  (setq org-directory "~/Dropbox/agenda/")
  (setq system-time-locale "C")
  (setq org-hide-leading-stars t)
  (setq org-startup-folded nil)
  (setq org-todo-keywords
        '((sequence "INBOX(i)" "TODO(t)" "NEXT(n)" "WAIT(w)" "PROJECT(p)" "|" "DONE(d)" "CANCELLED(c)" "SOMEDAY(s)")))
  (setq org-tag-alist
        '(("@office" . ?o) ("@home" . ?h) ("@computer" . ?c) ("@phone" . ?p) ("@errands" . ?e)
          ("@agenda" . ?a) ("@reading" . ?r) ("@waiting" . ?w)
          ("energy_high" . ?H) ("energy_low" . ?L) ("time_15min" . ?1) ("time_30min" . ?3) ("time_1hr" . ?6)))
  (setq org-startup-indented t)
  ;; 見た目：本文の字下げを深くし、強調の記号と #+TITLE: の文字を隠す
  (setq org-indent-indentation-per-level 3)
  (setq org-hide-emphasis-markers t)
  (setq org-hidden-keywords '(title))
  ;; 折り返しを日本語の文字の切れ目でも行う（既定では空白でしか折り返さない）
  (setq word-wrap-by-category t)
  (setq org-capture-templates
        '(("i" "📥 Inbox (GTD)" entry (file+headline org-default-notes-file "inbox")
           "** INBOX %?\n   CREATED: %U\n")
          ("t" "✅ Next Action (GTD)" entry (file+headline org-default-notes-file "next_actions")
           "** TODO %? %^G\n   CREATED: %U\n")
          ("p" "📋 Project (GTD)" entry (file+headline org-default-notes-file "projects")
           "** PROJECT %^{Project Name} %^G\n   CREATED: %U\n   %?")))
  (setq org-refile-targets '((org-agenda-files :maxlevel . 1)))
  (setq org-log-done 'time)
  (setq org-clock-clocked-in-display 'frame-title)
  (setq org-default-notes-file (concat org-directory "main.org"))
  :hook
  (org-mode . my:org-setup-look)
  :config
  ;; org-agenda-filesの設定
  (setq org-agenda-files
        (append '("~/Dropbox/agenda/")
                (when (file-exists-p "~/Dropbox/roam/daily/")
                  (directory-files-recursively "~/Dropbox/roam/daily/" "\\.org$"))))
  ;; 見出しの見た目：大きさで段差を付ける
  (set-face-attribute 'org-level-1 nil :height 1.4)
  (set-face-attribute 'org-level-2 nil :height 1.2)
  (set-face-attribute 'org-level-3 nil :height 1.1)
  (set-face-attribute 'org-level-4 nil :height 1.05)
  ;; 日本語に挟まれた =code= や *太字* も強調として扱う（既定では前後が空白・記号でないと効かない）
  (setcar org-emphasis-regexp-components
          (concat (car org-emphasis-regexp-components) "[:nonascii:]"))
  (setcar (nthcdr 1 org-emphasis-regexp-components)
          (concat (nth 1 org-emphasis-regexp-components) "[:nonascii:]"))
  (org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)
  :bind
  (("C-c a" . org-agenda)
   ("C-c c" . org-capture)
   ("C-c g" . org-clock-goto)
   ("C-c i" . my:org-goto-inbox)
   ("C-c d" . my:org-goto-diary)
   ("C-c C-d" . my:org-goto-diary-today)
   ("C-c A" . my:refresh-org-agenda-files)
   :map org-mode-map
   ("M-n" . org-forward-same-level)
   ("M-p" . org-backward-same-level)))

(use-package org-agenda
  :commands org-agenda
  :preface
  (defun my:org-agenda-close-after-switch (&rest _)
    "Close a org-agenda window when RET is hit on the window."
    (delete-other-windows)
    (recenter-top-bottom))
  :init
  (setq org-agenda-custom-commands
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
  (setq org-agenda-skip-scheduled-if-done t)
  (setq org-return-follows-link t)
  (setq org-agenda-columns-add-appointments-to-effort-sum t)
  (setq org-agenda-time-grid
        '((daily today require-timed)
          (0900 1200 1300 2000) "......" "----------------"))
  (setq org-columns-default-format
        "%68ITEM(Task) %6Effort(Effort){:} %6CLOCKSUM(Clock){:}")
  :config
  (advice-add 'org-agenda-switch-to :after #'my:org-agenda-close-after-switch)
  :bind
  (:map org-agenda-mode-map
   ("s" . org-agenda-schedule)
   ("S" . org-save-all-org-buffers)))

(use-package org-roam
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

(use-package org-modern
  :ensure t
  :config
  (global-org-modern-mode 1))

(use-package org-modern-indent
  :load-path "~/repos/org-modern-indent/"
  :hook (org-mode . org-modern-indent-mode))

;; 補完システム
(use-package vertico
  :ensure t
  :config
  (vertico-mode 1))

(use-package marginalia
  :ensure t
  :after vertico
  :config
  (marginalia-mode 1))

;; Consulting completing-read
(use-package consult
  :ensure t
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :functions consult-line
  :preface
  (defun c/consult-line (&optional at-point)
    "Consult-line uses things-at-point if set C-u prefix."
    (interactive "P")
    (if at-point
        (consult-line (thing-at-point 'symbol))
      (consult-line)))
  :custom
  (xref-show-xrefs-function #'consult-xref)
  (xref-show-definitions-function #'consult-xref)
  (consult-line-start-from-top t)
  :init
  ;; C-M-s（isearch-forward-regexp）を外し、下の C-M-s から始まるキーのプレフィックスにする
  (keymap-global-unset "C-M-s")
  :bind (;; C-c bindings (mode-specific-map)
         ([remap switch-to-buffer] . consult-buffer) ; C-x b
         ([remap project-switch-to-buffer] . consult-project-buffer) ; C-x p b

         ;; M-g bindings (goto-map)
         ([remap goto-line] . consult-goto-line)    ; M-g g
         ([remap imenu] . consult-imenu)            ; M-g i
         ("M-g f" . consult-flymake)

         ;; C-M-s bindings
         ("C-s" . c/consult-line)       ; isearch-forward
         ("C-M-s s" . isearch-forward)
         ("C-M-s C-s" . isearch-forward-regexp)
         ("C-M-s r" . consult-ripgrep)

         :map minibuffer-local-map
         ("C-r" . consult-history)))

;; Asynchronous Fuzzy Finder for Emacs
(use-package affe
  :ensure t
  :bind (("C-M-s f" . affe-find)))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless))
  (completion-category-defaults nil))

;; COmpletion in Region FUnction
;; :bind があると :config は後回しになるため、モードの有効化は :init で行う
(use-package corfu
  :ensure t
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0)
  (corfu-auto-prefix 1)
  (corfu-popupinfo-delay nil) ; manual
  :init
  (global-corfu-mode 1)
  (corfu-popupinfo-mode 1)
  :bind (:map corfu-map
         ("C-s" . corfu-insert-separator)))

;; Completion At Point Extensions
(use-package cape
  :ensure t
  :config
  (add-to-list 'completion-at-point-functions #'cape-file))

(use-package recentf
  :init
  (setq recentf-max-menu-items 100)
  (setq recentf-max-saved-items 200)
  (setq recentf-auto-cleanup 'never)
  :config
  (recentf-mode 1))

;; Markdown の編集
;; .md への割り当ては markdown-mode の autoload が行うため、読み込みは遅らせる
(use-package markdown-mode
  :ensure t
  :defer t)

;; Python開発環境
(use-package pyvenv
  :ensure t
  :config
  (setenv "WORKON_HOME" "~/.virtualenvs")
  (pyvenv-mode 1))

;; The Emacs Client for LSP servers
(use-package eglot
  :hook (clojure-mode . eglot-ensure)
  :custom
  (eldoc-echo-area-use-multiline-p nil)
  (eglot-connect-timeout 600))

(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode 1))

(use-package git-gutter
  :ensure t
  :config
  (global-git-gutter-mode 1))
