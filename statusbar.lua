local wezterm = require("wezterm")
local module = {}

local WORKSPACE_COLORS = {
  default = "#80EBDF",
  copy_mode = "#ffd700",
  resize_pane = "#39FF14",
  activate_pane = "#39FF14",
}

local last_color = nil

function module.apply_to_config(_)
  wezterm.on("update-status", function(window, pane)
    local workspace = window:active_workspace()
    local key_table = window:active_key_table()
    local color = WORKSPACE_COLORS[key_table] or WORKSPACE_COLORS.default

    -- 左ステータスにワークスペース名を表示
    window:set_left_status(wezterm.format({
      { Background = { Color = "transparent" } },
      { Foreground = { Color = color } },
      { Text = "  " .. workspace .. "  " },
    }))

    -- モード変化時にカーソル色を変更
    if last_color ~= color then
      last_color = color
      pane:inject_output("\x1b]12;" .. color .. "\x1b\\")
    end
  end)
end

return module
