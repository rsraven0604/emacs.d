;; org-modern動作確認用デバッグファイル

;; 1. org-modernが読み込まれているか確認
(if (featurep 'org-modern)
    (message "✓ org-modern is loaded")
  (message "✗ org-modern is NOT loaded"))

;; 2. org-modern-modeが有効か確認
(with-current-buffer (get-buffer-create "*org-modern-test*")
  (org-mode)
  (if org-modern-mode
      (message "✓ org-modern-mode is active in org buffer")
    (message "✗ org-modern-mode is NOT active in org buffer")))

;; 3. global-org-modern-modeが有効か確認
(if global-org-modern-mode
    (message "✓ global-org-modern-mode is active")
  (message "✗ global-org-modern-mode is NOT active"))

;; 4. org-modern関連変数の状態を表示
(message "\n=== org-modern settings ===")
(message "org-modern-table: %s" org-modern-table)
(message "org-modern-keyword: %s" org-modern-keyword)
(message "org-modern-checkbox: %s" org-modern-checkbox)
(message "org-modern-priority: %s" org-modern-priority)
(message "org-modern-todo: %s" org-modern-todo)
(message "org-modern-tag: %s" org-modern-tag)
(message "org-modern-timestamp: %s" org-modern-timestamp)
(message "org-modern-statistics: %s" org-modern-statistics)
(message "org-modern-progress: %s" org-modern-progress)
(message "org-modern-list: %s" org-modern-list)
(message "org-modern-hide-stars: %s" org-modern-hide-stars)

;; 5. テストバッファを作成して実際の表示を確認
(with-current-buffer (get-buffer-create "*org-modern-visual-test*")
  (erase-buffer)
  (org-mode)
  (org-modern-mode 1)
  (insert "#+TITLE: org-modern Visual Test\n\n")
  (insert "* TODO Test heading with TODO keyword\n")
  (insert "** DONE Completed task :tag1:tag2:\n")
  (insert "*** Sub-heading with priority [#A]\n\n")
  (insert "- [ ] Checkbox item 1\n")
  (insert "- [X] Checkbox item 2\n")
  (insert "+ Plus list item\n")
  (insert "* Another item\n\n")
  (insert "| Table | Header |\n")
  (insert "|-------+--------|\n")
  (insert "| Cell1 | Cell2  |\n\n")
  (insert "#+BEGIN_SRC emacs-lisp\n")
  (insert "(message \"Code block test\")\n")
  (insert "#+END_SRC\n\n")
  (insert "Timestamp: <2025-01-07 Tue>\n")
  (insert "Deadline: DEADLINE: <2025-01-10 Fri>\n")
  (insert "Progress: [33%]\n")
  (insert "Statistics: [1/3]\n")
  (pop-to-buffer (current-buffer)))

(message "\n✓ Test buffer created. Check *org-modern-visual-test* buffer to see if org-modern styling is applied.")