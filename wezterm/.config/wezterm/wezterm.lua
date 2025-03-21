-- Pull in the wezterm API
local wezterm = require("wezterm")

local keybinds = require("keybinds")
local status = require("status")

local config = wezterm.config_builder()

config = {
	disable_default_key_bindings = true,
	term = "xterm-256color",
	max_fps = 120,

	leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 },
	font_size = 11.0,
	enable_kitty_graphics = true,
	hide_tab_bar_if_only_one_tab = false,
	use_fancy_tab_bar = false,
	show_new_tab_button_in_tab_bar = false,
	status_update_interval = 1000,
	tab_max_width = 60,
	tab_bar_at_bottom = false,
	--
	-- disables mac unicode symbol input via ALT/META
	send_composed_key_when_left_alt_is_pressed = true,
	send_composed_key_when_right_alt_is_pressed = true,

	-- Colorscheme
	colors = {
		foreground = "#f0f3f6", -- fg.default
		background = "#0a0c10", -- canvas.default

		cursor_bg = "#f0f3f6", -- fg.default
		cursor_border = "#f0f3f6", -- fg.default
		cursor_fg = "#0a0c10", -- canvas.default

		selection_bg = "rgba(64,158,255,0.4)", -- selectionBg
		selection_fg = "#f0f3f6", -- fg.default

		scrollbar_thumb = "#7a828e", -- border.default
		split = "#7a828e", -- border.default

		ansi = {
			"#0a0c10", -- black
			"#ff9492", -- red
			"#71b7ff", -- blue (originaly green "#26cd4d")
			"#f0b72f", -- yellow
			"#0a0c10", -- black (originaly blue "#71b7ff")
			"#cb9eff", -- magenta
			"#39c5cf", -- cyan
			"#d9dee3", -- white
		},
		brights = {
			"#9ea7b3", -- blackBright
			"#ffb1af", -- redBright
			"#f0f3f6", -- white (originaly greenBright "#4ae168")
			"#f7c843", -- yellowBright
			"#91cbff", -- blueBright
			"#dbb7ff", -- magentaBright
			"#ffb1af", -- cyanBright
			"#ffffff", -- whiteBright
		},
	},

	inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.7,
	},
}

keybinds.apply(config)
status.load()

-- Return the configuration to wezterm
return config
