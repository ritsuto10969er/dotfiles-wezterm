local wezterm = require("wezterm")
local config = wezterm.config_builder()

----------------------------------------------------
-- Basic Settings
----------------------------------------------------

config.automatically_reload_config = true

config.font = wezterm.font("UDEV Gothic 35NFLG")
config.font_size = 12.0

config.use_ime = true

config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

config.status_update_interval = 1500

----------------------------------------------------
-- QuickSelect (SUPER + Space)
----------------------------------------------------

config.quick_select_patterns = {
  "\\bhttps?://[\\w\\-._~:/?#@!$&'()*+,;=%]+",
  "(?<=[\\s:=(\"'`])(?:~|/)[/\\w\\-.@~]+",
  "(?m)^(?:~|/)[/\\w\\-.@~]+(?=\\s*$)",
  "\\b[0-9a-f]{7,40}\\b",
  "\\b(?:[0-9]{1,3}\\.){3}[0-9]{1,3}\\b",
  "\\b[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\\b",
  "\\b[\\w.+-]+@[\\w.-]+\\.[a-zA-Z]{2,}\\b",
}

----------------------------------------------------
-- Key Bindings
----------------------------------------------------

config.disable_default_key_bindings = true
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 2000 }

local keybinds = require("keybinds")
config.keys = keybinds.keys
config.key_tables = keybinds.key_tables

----------------------------------------------------
-- Modules
----------------------------------------------------

require("appearance").apply_to_config(config)
require("tab").apply_to_config(config)
require("statusbar").apply_to_config(config)

return config
