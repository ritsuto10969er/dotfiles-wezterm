# WezTerm 設定プロジェクト

## 環境
- 機種: MacBook Air 13インチ M5
- OS: macOS Tahoe
- 外部モニター: BenQ GW2790 27インチ (1920×1080)

## ファイル構成

```
wezterm.lua      # エントリーポイント。各モジュールをrequireするだけ
keybinds.lua     # キーバインド定義
appearance.lua   # 外観設定（ペインのdim等）
statusbar.lua    # ステータスバー（ワークスペース名・モード色）
tab.lua          # タブタイトル（アイコン・プロジェクト名）
```

## 設定方針

### キーバインド
- `SUPER` = Cmd（⌘）キー
- `LEADER` = Ctrl+Space（タイムアウト2秒）
- コピー/ペースト/タブ操作はSUPERキーベース
- Pane操作・コピーモードはLEADERまたはCTRL（vi/Emacs慣習）
- デフォルトキーバインドは無効（`disable_default_key_bindings = true`）

### レンダリング
- `WebGpu + HighPerformance`（MetalバックエンドでM5に最適）

### macOS固有
- `macos_window_background_blur = 20`
- `use_ime = true`（日本語入力対応）
- WSL・PowerShell関連の設定は不使用

## 参考
- [mozumasu氏のdotfiles](https://github.com/mozumasu/dotfiles/tree/main/.config/wezterm)
