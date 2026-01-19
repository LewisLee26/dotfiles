local wezterm = require("wezterm")

local M = {}

function M.apply(config)
	-- Colorscheme
	config.colors = {
		foreground = "#ECE1D7",
		-- background = "#292522",
		background = "#161312",

		cursor_bg = "#ECE1D7",
		cursor_border = "#ECE1D7",
		cursor_fg = "#292522",

		selection_bg = "#403A36",
		selection_fg = "#ECE1D7",

		ansi = {
			"#34302C", -- black
			"#BD8183", -- red
			"#78997A", -- green
			"#E49B5D", -- yellow
			"#7F91B2", -- blue
			"#B380B0", -- magenta
			"#7B9695", -- cyan
			"#C1A78E", -- white
		},

		brights = {
			"#867462", -- blackBright
			"#D47766", -- redBright
			"#85B695", -- greenBright
			"#EBC06D", -- yellowBright
			"#A3A9CE", -- blueBright
			"#CF9BC2", -- magentaBright
			"#89B3B6", -- cyanBright
			"#ECE1D7", -- whiteBright
		},
	}
end

return M
