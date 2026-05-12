local wezterm = require("wezterm")
local module = {}

function module.apply_to_config(config)
  -- ウィンドウ装飾
  config.window_decorations = "RESIZE"
  config.window_close_confirmation = "NeverPrompt"

  -- 背景
  config.window_background_opacity = 0.75
  config.window_background_gradient = { colors = { "#000000" } }
  if wezterm.target_triple:find("darwin") then
    config.macos_window_background_blur = 20
  end

  -- 非アクティブペインをdim
  config.inactive_pane_hsb = {
    hue = 1.0,
    saturation = 0.9,
    brightness = 0.7,
  }

  -- タブバー
  config.show_tabs_in_tab_bar = true
  config.hide_tab_bar_if_only_one_tab = true
  config.show_new_tab_button_in_tab_bar = false
  config.use_fancy_tab_bar = true
  config.tab_max_width = 30
  config.window_frame = {
    inactive_titlebar_bg = "none",
    active_titlebar_bg = "none",
  }

  -- 色設定
  config.colors = {
    tab_bar = {
      background = "none",
      inactive_tab_edge = "none",
    },
    cursor_bg = "#80EBDF",
    cursor_fg = "#000000",
    cursor_border = "#80EBDF",
    selection_bg = "#ffdd00",
    selection_fg = "#000000",
  }
end

return module
