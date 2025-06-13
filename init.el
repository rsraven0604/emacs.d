
;; 余計なファイルを生成しない
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq auto-save-list-file-prefix nil)

;; パッケージリポジトリの設定
(require 'package)
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(package-initialize)

;; 手動で更新したければ、 M-x package-refresh-contents

;; use-packageのインストール
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


(require 'use-package)

;; いらないUIを消す
(setq inhibit-startup-message t)       ;; スタートアップメッセージを非表示
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

(global-display-line-numbers-mode t)   ;; 行番号を表示

;; インデント設定
(setq-default indent-tabs-mode nil)  ;; タブをスペースに変換
(setq-default tab-width 4)           ;; タブ幅を4に設定
(setq indent-line-function 'insert-tab)

;; フォント設定
(set-face-attribute 'default nil :family "Monaspace Xenon Var" :height 120)
(setq-default line-spacing  0.2)

;; ウィンドウサイズ指定
(set-frame-size (selected-frame) 120 48)

;; キーバインド
;;; 削除ボタンを C-hに設定
(global-set-key "\C-h" `delete-backward-char)

;;; アクティブウィンドウ切り替えを C-tに設定
(defun other-window-or-split (val)
  (interactive)
  (when (one-window-p)
    (split-window-horizontally)
  )
  (other-window val))
(global-set-key "\C-t" (lambda () (interactive) (other-window-or-split 1)))


;; シンタックスハイライト
(global-font-lock-mode t)

;; 行末の空白を可視化
(setq show-trailing-whitespace t)


;; テーマの設定
;; use-package の使い方 https://qiita.com/kai2nenobu/items/5dfae3767514584f5220
(use-package zenburn-theme
  :ensure t
  :preface
  (setq zenburn-use-variable-pitch t)
  (setq zenburn-scale-org-headlines t)
  (setq zenburn-scale-outline-headlines t)
  ;; 全体的に少し暗くする
  (setq zenburn-override-colors-alist
        '(
        ("zenburn-bg-2" . "#040403")          
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
        ("zenburn-fg+2"  . "#E4DCC8")))

  :load-path "themes"
  :init
  :config
  (load-theme 'zenburn t))

;; 背景透過
(set-frame-parameter nil 'alpha-background 85)
(add-to-list 'default-frame-alist '(alpha-background . 85))

;; バージョン管理関連
;; magit https://github.com/magit/magit
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch-popup)))

;; Treemacsの設定
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                2000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-header-scroll-indicators        '(nil . "^^^^^^")
          treemacs-hide-dot-git-directory          t
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           t
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-files-by-mouse-dragging    t
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory) 
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-project-follow-into-home        nil
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           35
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

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

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

;; インストールする前に、以下コマンドでフォントをインストールする必要がある。
;; yay -S ttf-nerd-fonts-symbols
(use-package treemacs-nerd-icons
  :after treemacs
  :ensure t
  :config
  (treemacs-load-theme "nerd-icons")
  (setq treemacs-nerd-icons-scale-factor 1.0)
  (setq treemacs-nerd-icons-hl-face 'treemacs-root-face))

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(treemacs-start-on-boot)

;; org-mode, org-agendaの設定
;; 参考 https://qiita.com/mamo3gr/items/6324b695131fef9b6031
(use-package org
  :commands org-agenda
  :mode (("\\.org\\'" . org-mode))
  :init
  (setq org-directory "~/Dropbox/agenda/")
  (setq org-default-notes-file (concat org-directory "main.org"))
  (setq org-agenda-files (list org-directory))
  (defun my:org-goto-inbox ()
    (interactive)
    (find-file org-default-notes-file))
  :config
  (setq system-time-locale "C")  ;; to avoid Japanese in the time stamp
  (setq org-hide-leading-stars t)
  (setq org-startup-folded nil)
  ;; org-capture and enrty
  (setq org-todo-keywords
        '((sequence "TASK(t)" "WAIT(w)" "|" "DONE(d)" "ABORT(a)" "SOMEDAY(s)")))
  (setq org-tag-alist '(("PROJECT" . ?p) ("MEMO" . ?m) ("PETIT" . ?t)))
  (setq org-startup-indented t)
  (setq org-capture-templates
        '(("t" "Task" entry (file+headline org-default-notes-file "inbox")
           "** TASK %?\n   CREATED: %U\n")
          ("i" "Idea" entry (file+headline org-default-notes-file "idea")
           "** %?\n   CREATED: %U\n")
          ("k" "Knowledge" entry (file+headline org-default-notes-file "knowledge")
           "** %?\n   CREATED: %U\n")))
  (setq org-refile-targets '((org-agenda-files :maxlevel . 1)))
  ;; org-clock
  (setq org-log-done 'time)  ;; add a time stamp to the task when done
  (setq org-clock-clocked-in-display 'frame-title)
  :bind
  (("C-c a" . org-agenda)
   ("C-c c" . org-capture)
   ("C-c g" . org-clock-goto)
   ("C-c i" . my:org-goto-inbox)
   :map org-mode-map
   ("C-m" . org-return-indent)
   ("M-n" . org-forward-same-level)
   ("M-p" . org-backward-same-level)))

(use-package org-agenda
  :defer t
  :commands org-agenda
  :config
  (setq org-agenda-custom-commands
        '(("x" "Unscheduled Tasks" tags-todo
           "-SCHEDULED>=\"<today>\"-DEADLINE>=\"<today>\"" nil)
          ("d" "Daily Tasks" agenda ""
           ((org-agenda-span 1)))))
  (setq org-agenda-skip-scheduled-if-done t)
  (setq org-return-follows-link t)  ;; RET to follow link
  (setq org-agenda-columns-add-appointments-to-effort-sum t)
  (setq org-agenda-time-grid
        '((daily today require-timed)
          (0900 1200 1300 2000) "......" "----------------"))
  (setq org-columns-default-format
        "%68ITEM(Task) %6Effort(Effort){:} %6CLOCKSUM(Clock){:}")
  (defadvice org-agenda-switch-to (after org-agenda-close)
    "Close a org-agenda window when RET is hit on the window."
    (progn (delete-other-windows)
           (recenter-top-bottom)))
  (ad-activate 'org-agenda-switch-to)
  :bind
  (:map org-agenda-mode-map
        ("s" . org-agenda-schedule)
        ("S" . org-save-all-org-buffers)))

(use-package org-roam
  :defer t
  :ensure t
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (setq org-roam-database-connector 'sqlite-builtin)
  (setq org-roam-directory (file-truename "~/Dropbox/roam"))
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (setq org-roam-db-location "~/.org-roam.db")
  (setq org-roam-index-file "~/Dropbox/roam/Index.org")
  
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))

(use-package ob-mermaid
  :defer t
  :ensure t
  :config
  (org-babel-do-load-languages
    'org-babel-load-languages
    '((mermaid . t)
      (scheme . t)))
  (setq ob-mermaid-cli-path "/usr/bin/mmdc"))
(use-package mermaid-mode
  :ensure t
  :config
  (setq mermaid-output-format "/usr/bin/mmdc")
  )

(use-package org-modern
  :ensure t
  :config
  (with-eval-after-load 'org (global-org-modern-mode))
  )

(use-package org-indent)

(use-package org-modern-indent
  :load-path "~/repos/org-modern-indent/"
  :config
  (add-hook 'org-mode-hook #'org-indent-mode)
  (add-hook 'org-mode-hook #'org-modern-indent-mode 90))

;; org-superstar https://github.com/integral-dw/org-superstar-mode
(use-package org-superstar
  :load-path "~/repos/org-superstar-mode/"
  :config
  (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1))))

;; GitHub Copilot 連携 https://github.com/copilot-emacs/copilot.el
;; Installation
;; Mx copilot-install-server
;; M-x copilot-login
;; 確認 M-x copilot-diagnose (NotAuthorized だったらサブスクが有効でない）
(use-package copilot
  :vc (:url "https://github.com/copilot-emacs/copilot.el"
            :rev :newest
            :branch "main")
  :hook (prog-mode . copilot-mode)
  :init
  (setq copilot-indent-offset-warning-disable t) ;; インデントの警告を無効化
  (setq copilot-max-char-warning-disabled t) ;; 最大文字数の警告を無効化
  :bind (:map copilot-completion-map
              ("C-e" . copilot-accept-completion)
              ("M-f" . copilot-accept-completion-by-word)
              ("C-M-f" . copilot-accept-completion-by-paragraph)
              ("M-n" . copilot-accept-completion-by-line)
              ("C-M-n" . copilot-next-completion)
              ("C-M-p" . copilot-previous-completion))
  (:map copilot-mode-map
   ("M-i" . copilot-complete)
   ))

;; 基本インクリメンタル補完システム
(use-package vertico
  :ensure t
  :init
  (vertico-mode))

;; 補助情報の表示（marginalia）
(use-package marginalia
  :ensure t
  :after vertico
  :init
  (marginalia-mode))

;; より強力なコマンドセット
(use-package consult
  :ensure t
  :bind
  (("C-s" . consult-line)
   ("C-x b" . consult-buffer)  ;; バッファ・recentf・bookmarks・project files などを統合的に検索
   ("C-x C-r" . consult-recent-file)
   ("M-y" . consult-yank-pop))) ;; kill-ring からの検索・挿入

;; 補完スタイルをあいまい検索に変更
(use-package orderless
  :ensure t
  :init
  (setq completion-styles '(orderless)
        completion-category-defaults nil))

;; recentf による最近使ったファイル一覧
(use-package recentf
  :ensure nil ;; built-in パッケージなので `:ensure` は不要
  :init
  (recentf-mode 1)
  (setq recentf-max-menu-items 100
        recentf-max-saved-items 200
        recentf-auto-cleanup 'never))



;; pythonの設定
(use-package elpy
  :ensure t
  :init
  (elpy-enable)
  (setq python-shell-interpreter "ipython"
        python-shell-interpreter-args "-i --simple-prompt"))

;; lspによる補完
(use-package lsp-mode
    :ensure t
    :commands lsp
    :hook (python-mode . lsp)
    :config
    (lsp-enable-which-key-integration t))



;; git-gutter https://github.com/emacsorphanage/git-gutter
(use-package git-gutter
  :ensure t
  :config
  (global-git-gutter-mode +1))

;; 以下、自動生成行
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(consult copilot elpy git-gutter leuven-theme lsp-mode marginalia
             markdown-mode material-theme mermaid-mode modus-themes
             nord-theme ob-mermaid orderless org-modern org-roam
             spinner treemacs-icons-dired treemacs-magit
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

