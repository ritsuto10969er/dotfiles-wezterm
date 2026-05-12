local wezterm = require("wezterm")
local act = wezterm.action

----------------------------------------------------
-- Helper Functions
----------------------------------------------------

-- 現在のディレクトリを保持してPaneを分割
local function split_pane_with_cwd(window, pane, split_action)
  local cwd_uri = pane:get_current_working_dir()
  local cwd_path = nil

  if cwd_uri then
    cwd_path = cwd_uri.file_path
  end

  window:perform_action(
    split_action({
      domain = "CurrentPaneDomain",
      cwd = cwd_path,
    }),
    pane
  )
end

----------------------------------------------------
-- Key Bindings
----------------------------------------------------

return {
  keys = {
    ----------------------------------------------------
    -- Workspace
    ----------------------------------------------------
    {
      -- ワークスペースの切り替え
      key = "w",
      mods = "LEADER",
      action = act.ShowLauncherArgs({ flags = "WORKSPACES", title = "Select workspace" }),
    },
    {
      -- ワークスペースの名前変更
      key = "$",
      mods = "LEADER",
      action = act.PromptInputLine({
        description = "(wezterm) Set workspace title:",
        action = wezterm.action_callback(function(win, pane, line)
          if line then
            wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
          end
        end),
      }),
    },
    {
      -- 新規ワークスペース作成
      key = "W",
      mods = "LEADER|SHIFT",
      action = act.PromptInputLine({
        description = "(wezterm) Create new workspace:",
        action = wezterm.action_callback(function(window, pane, line)
          if line then
            window:perform_action(
              act.SwitchToWorkspace({
                name = line,
              }),
              pane
            )
          end
        end),
      }),
    },

    ----------------------------------------------------
    -- Command Palette & System
    ----------------------------------------------------
    { key = "p", mods = "LEADER", action = act.ActivateCommandPalette },
    { key = "p", mods = "SUPER|SHIFT", action = act.ActivateCommandPalette },
    { key = "r", mods = "SUPER", action = act.ReloadConfiguration },
    { key = "q", mods = "SUPER", action = act.QuitApplication },
    { key = "Enter", mods = "SUPER", action = act.ToggleFullScreen },

    ----------------------------------------------------
    -- Tab
    ----------------------------------------------------
    -- Tab切り替え
    { key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
    { key = "Tab", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },
    { key = "1", mods = "LEADER", action = act.ActivateTab(0) },
    { key = "2", mods = "LEADER", action = act.ActivateTab(1) },
    { key = "3", mods = "LEADER", action = act.ActivateTab(2) },
    { key = "4", mods = "LEADER", action = act.ActivateTab(3) },
    { key = "5", mods = "LEADER", action = act.ActivateTab(4) },
    { key = "6", mods = "LEADER", action = act.ActivateTab(5) },
    { key = "7", mods = "LEADER", action = act.ActivateTab(6) },
    { key = "8", mods = "LEADER", action = act.ActivateTab(7) },
    { key = "9", mods = "LEADER", action = act.ActivateTab(-1) },
    -- Tab操作
    { key = "t", mods = "SUPER", action = act({ SpawnTab = "CurrentPaneDomain" }) },
    { key = "w", mods = "SUPER", action = act({ CloseCurrentTab = { confirm = true } }) },
    { key = "{", mods = "LEADER", action = act({ MoveTabRelative = -1 }) },
    { key = "}", mods = "LEADER", action = act({ MoveTabRelative = 1 }) },

    ----------------------------------------------------
    -- Copy & Paste
    ----------------------------------------------------
    { key = "[", mods = "LEADER", action = act.ActivateCopyMode },
    { key = "c", mods = "SUPER", action = act.CopyTo("Clipboard") },
    { key = "v", mods = "LEADER", action = act.PasteFrom("Clipboard") },
    { key = "v", mods = "SUPER", action = act.PasteFrom("Clipboard") },

    ----------------------------------------------------
    -- Pane
    ----------------------------------------------------

    -- Pane作成（カレントディレクトリを保持）
    {
      key = "d",
      mods = "LEADER",
      action = wezterm.action_callback(function(window, pane)
        split_pane_with_cwd(window, pane, act.SplitVertical)
      end),
    },
    {
      key = "r",
      mods = "LEADER",
      action = wezterm.action_callback(function(window, pane)
        split_pane_with_cwd(window, pane, act.SplitHorizontal)
      end),
    },
    -- Pane移動
    { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
    { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
    { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
    { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
    -- Pane操作
    { key = "x", mods = "LEADER", action = act({ CloseCurrentPane = { confirm = true } }) },
    { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
    { key = "[", mods = "SUPER|SHIFT", action = act.PaneSelect },
    -- Paneモード
    { key = "s", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },
    {
      key = "a",
      mods = "LEADER",
      action = act.ActivateKeyTable({ name = "activate_pane", timeout_milliseconds = 1000 }),
    },

    ----------------------------------------------------
    -- Font
    ----------------------------------------------------
    { key = "+", mods = "SUPER", action = act.IncreaseFontSize },
    { key = "-", mods = "SUPER", action = act.DecreaseFontSize },
    { key = "0", mods = "SUPER", action = act.ResetFontSize },

    ----------------------------------------------------
    -- QuickSelect
    ----------------------------------------------------
    { key = "Space", mods = "SUPER", action = act.QuickSelect },

    ----------------------------------------------------
    -- Cheatsheet
    ----------------------------------------------------
    -- チートシート表示
    {
      key = "?",
      mods = "LEADER|SHIFT",
      action = act.SplitVertical({
        domain = "CurrentPaneDomain",
        args = {
          "bash",
          "-c",
          "bat ~/.config/wezterm/wezterm-cheatsheet.md 2>/dev/null || cat ~/.config/wezterm/wezterm-cheatsheet.md; read -r",
        },
      }),
    },
  },
  ----------------------------------------------------
  -- Key Tables
  ----------------------------------------------------
  -- https://wezfurlong.org/wezterm/config/key-tables.html
  key_tables = {
    ----------------------------------------------------
    -- Paneサイズ調整モード (Leader + s)
    ----------------------------------------------------
    resize_pane = {
      { key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
      { key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
      { key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
      { key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
      { key = "Enter", action = "PopKeyTable" },
    },

    ----------------------------------------------------
    -- Pane連続移動モード (Leader + a)
    ----------------------------------------------------
    activate_pane = {
      { key = "h", action = act.ActivatePaneDirection("Left") },
      { key = "j", action = act.ActivatePaneDirection("Down") },
      { key = "k", action = act.ActivatePaneDirection("Up") },
      { key = "l", action = act.ActivatePaneDirection("Right") },
    },

    ----------------------------------------------------
    -- コピーモード (Leader + [)
    ----------------------------------------------------
    copy_mode = {
      -- 移動
      { key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
      { key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
      { key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
      { key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
      -- 最初と最後に移動
      { key = "^", mods = "NONE", action = act.CopyMode("MoveToStartOfLineContent") },
      { key = "$", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
      -- 左端に移動
      { key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
      { key = "o", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEnd") },
      { key = "O", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
      --
      { key = ";", mods = "NONE", action = act.CopyMode("JumpAgain") },
      -- 単語ごと移動
      { key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
      { key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
      { key = "e", mods = "NONE", action = act.CopyMode("MoveForwardWordEnd") },
      -- ジャンプ機能 t f
      { key = "t", mods = "NONE", action = act.CopyMode({ JumpForward = { prev_char = true } }) },
      { key = "f", mods = "NONE", action = act.CopyMode({ JumpForward = { prev_char = false } }) },
      { key = "T", mods = "NONE", action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
      { key = "F", mods = "NONE", action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
      -- 一番下へ
      { key = "G", mods = "NONE", action = act.CopyMode("MoveToScrollbackBottom") },
      -- 一番上へ
      { key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },
      -- viweport
      { key = "H", mods = "NONE", action = act.CopyMode("MoveToViewportTop") },
      { key = "L", mods = "NONE", action = act.CopyMode("MoveToViewportBottom") },
      { key = "M", mods = "NONE", action = act.CopyMode("MoveToViewportMiddle") },
      -- スクロール
      { key = "b", mods = "CTRL", action = act.CopyMode("PageUp") },
      { key = "f", mods = "CTRL", action = act.CopyMode("PageDown") },
      { key = "d", mods = "CTRL", action = act.CopyMode({ MoveByPage = 0.5 }) },
      { key = "u", mods = "CTRL", action = act.CopyMode({ MoveByPage = -0.5 }) },
      -- 範囲選択モード
      { key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
      { key = "v", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Block" }) },
      { key = "V", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Line" }) },
      -- コピー
      { key = "y", mods = "NONE", action = act.CopyTo("Clipboard") },

      -- コピーモードを終了
      {
        key = "Enter",
        mods = "NONE",
        action = act.Multiple({ { CopyTo = "ClipboardAndPrimarySelection" }, { CopyMode = "Close" } }),
      },
      { key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
      { key = "c", mods = "CTRL", action = act.CopyMode("Close") },
      { key = "q", mods = "NONE", action = act.CopyMode("Close") },
    },
  },
}


