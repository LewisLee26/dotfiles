-- Pull in the wezterm API
local wezterm = require("wezterm")

local keybinds = require("keybinds")
local colorscheme = require("colorscheme")
local status = require("status")

local config = wezterm.config_builder()

config = {
	disable_default_key_bindings = true,
	term = "xterm-256color",
	max_fps = 120,

	leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 },
	font_size = 12.0,
	enable_kitty_graphics = true,
	hide_tab_bar_if_only_one_tab = false,
	use_fancy_tab_bar = false,
	show_new_tab_button_in_tab_bar = false,
	status_update_interval = 1000,
	tab_max_width = 60,
	tab_bar_at_bottom = false,

	-- disables mac unicode symbol input via ALT/META
	send_composed_key_when_left_alt_is_pressed = true,
	send_composed_key_when_right_alt_is_pressed = true,

	inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.7,
	},
}

keybinds.apply(config)
colorscheme.apply(config)
status.load()

wezterm.plugin.update_all()

-- Return the configuration to wezterm
return config
