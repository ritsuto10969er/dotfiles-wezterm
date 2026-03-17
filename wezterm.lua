local wezterm = require("wezterm")
local config = wezterm.config_builder()

----------------------------------------------------
-- Color Scheme
----------------------------------------------------

local colors = {
  background = "#000000",
  white = "#FFFFFF",
  tab_inactive = "#5c6d74",
  tab_active = "#ae8b2d",
}

----------------------------------------------------
-- Basic Settings
----------------------------------------------------

config.automatically_reload_config = true

-- フォント設定
-- config.font = wezterm.font_with_fallback({
--   "PlemolJP Console NF",  -- 将来インストールした時用
--   "Consolas",              -- 現在使用
-- })
config.font = wezterm.font("UDEV Gothic 35NFLG")
config.font_size = 12.0

-- IME設定
config.use_ime = true

-- レンダリング設定
config.front_end = "Software"

-- 背景設定
config.window_background_opacity = 0.75

-- macOS専用設定
if wezterm.target_triple:find("darwin") then
  config.macos_window_background_blur = 20
end

-- デフォルトでWSLを起動（ホームディレクトリ）
config.default_prog = { "wsl.exe", "--cd", "~" }

----------------------------------------------------
-- Window & Tab Bar
----------------------------------------------------

-- ウィンドウ装飾
config.window_decorations = "RESIZE"

-- タブバー表示設定
config.show_tabs_in_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
-- config.use_fancy_tab_bar = false  -- falseにすると透過が効かなくなる
-- config.show_close_tab_button_in_tabs = false  -- nightly版のみ

-- タブバーの透過設定
config.window_frame = {
  inactive_titlebar_bg = "none",
  active_titlebar_bg = "none",
}

-- 背景色設定
config.window_background_gradient = {
  colors = { colors.background },
}

-- タブ境界線の非表示
config.colors = {
  tab_bar = {
    inactive_tab_edge = "none",
  },
}

----------------------------------------------------
-- Tab Title Formatting
----------------------------------------------------

-- Nerd Fontsアイコン
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle

-- タブタイトルのカスタマイズ
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local background = colors.tab_inactive
  local foreground = colors.white
  local edge_background = "none"

  if tab.is_active then
    background = colors.tab_active
    foreground = colors.white
  end

  local edge_foreground = background
  local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "

  return {
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_LEFT_ARROW },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_RIGHT_ARROW },
  }
end)

----------------------------------------------------
-- Key Bindings
----------------------------------------------------

config.disable_default_key_bindings = true
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 2000 }

-- 外部ファイルから読み込み
local keybinds = require("keybinds")
config.keys = keybinds.keys
config.key_tables = keybinds.key_tables

return config
