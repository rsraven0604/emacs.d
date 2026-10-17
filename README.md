# emacs.d

個人用の Emacs 設定。`init.el` は `use-package` で書いている。

## WSL（Ubuntu）への導入

Ubuntu 26.04 の WSL2（WSLg）で確認した手順。apt で入る Emacs は 30.2。

### 1. Emacs と依存ツールを入れる

```bash
sudo apt install emacs-pgtk ripgrep
```

- `emacs` ではなく `emacs-pgtk` を入れる。`emacs` は X11 版（`emacs-gtk`）を入れるため WSLg では XWayland 経由になるが、`emacs-pgtk` は Wayland で直接動く。
- `ripgrep` は `consult-ripgrep`（`C-M-s r`）が使う。

### 2. 設定をリンクする

```bash
ln -s ~/projects/emacs.d ~/.emacs.d
```

`~/.emacs`・`~/.emacs.el`・`~/.config/emacs` があると `~/.emacs.d` より優先されるので、無いことを確かめておく。
パッケージは `~/.emacs.d/elpa/`（リポジトリの中）に入るが、`.gitignore` で除外している。

### 3. MELPA に無いパッケージを取得する

`org-modern-indent` は `:load-path "~/repos/org-modern-indent/"` から読む。無いと org ファイルを開くたびに `org-mode-hook` でエラーになる。

```bash
git clone https://github.com/jdtsmith/org-modern-indent ~/repos/org-modern-indent
```

### 4. フォントを入れる

Windows に入れたフォントは WSL の Emacs からは見えない。`~/.local/share/fonts/` に置いてキャッシュを更新する。

```bash
fc-cache -f
fc-list : family | grep -iE 'monaspace|cica'
```

| フォント | 用途 |
| --- | --- |
| `Monaspace Xenon NF` | 英字（`default` の `:family`） |
| `Cica` | 日本語。1.25 倍にして英字のちょうど2倍の幅にし、org の表の縦線を揃える |

`init.el` が指定しているファミリー名と、入れたフォントのファミリー名を一致させること。
一致しないとエラーにはならず、別のフォントで表示される（`fc-match "<ファミリー名>"` で何に置き換わるかを確認できる）。

### 5. 日本語入力（fcitx5 + Mozc）

```bash
sudo apt install fcitx5 fcitx5-mozc fcitx5-frontend-gtk3 fcitx5-config-qt
```

`~/.bashrc` で環境変数を設定し、fcitx5 を起動しておく。

```bash
if command -v fcitx5 >/dev/null 2>&1; then
  export GTK_IM_MODULE=fcitx QT_IM_MODULE=fcitx XMODIFIERS=@im=fcitx GLFW_IM_MODULE=ibus
  pgrep -u "$USER" -x fcitx5 >/dev/null || (fcitx5 -d --replace --disable=wayland,waylandim >/dev/null 2>&1 &)
fi
```

- WSLg のコンポジタは `zwp_input_method_v1` を受け付けず、fcitx5 がそのエラーで終了するため、Wayland のアドオンを `--disable=wayland,waylandim` で切っている。
- `GLFW_IM_MODULE=ibus` は kitty 用（Emacs には関係しない）。
- 入力メソッドに Mozc を追加するのは `fcitx5-config-qt` で行う。

### 6. 初回起動

```bash
emacs
```

- 初回は `:ensure t` のパッケージを MELPA / GNU ELPA から取得するため、起動に時間がかかる。
- 起動したら `M-x nerd-icons-install-fonts` を実行する（`treemacs-nerd-icons` のアイコン用）。

### 前提にしているディレクトリ

| パス | 使う設定 |
| --- | --- |
| `~/Dropbox/roam/` | `org-roam-directory`・`org-roam-dailies`・`org-agenda-files`（`daily/` の下） |
| `~/Dropbox/claude/goals/goals.org` | `org-capture` の `g`（やりたいこと箱） |
| `~/repos/org-modern-indent/` | `org-modern-indent` |
