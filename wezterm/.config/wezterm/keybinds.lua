local wezterm = require("wezterm")
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
workspace_switcher.get_choices = function(opts)
	-- this will ONLY show the workspace elements, NOT the Zoxide results
	return workspace_switcher.choices.get_workspace_elements({})
end

local act = wezterm.action

local M = {}

-- Direction keys mapping
local direction_keys = {
	Left = "h",
	Down = "j",
	Up = "k",
	Right = "l",
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

-- Function to check if the pane is running Neovim
local function is_vim(pane)
	return pane:get_user_vars().IS_NVIM == "true"
end

-- Function to create navigation and resize actions
local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

function M.apply(config)
	config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 800 }

	-- LEADER KEYBINDS
	config.keys = {
		-- Splitting panes
		{
			mods = "LEADER",
			key = "-",
			action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			mods = "LEADER",
			key = "=",
			action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		-- Rotating panes
		{
			mods = "LEADER",
			key = "Space",
			action = act.RotatePanes("Clockwise"),
		},
		-- Swapping panes
		{
			mods = "LEADER",
			key = "0",
			action = act.PaneSelect({
				mode = "SwapWithActive",
			}),
		},
		-- Activate copy mode
		{
			key = "Enter",
			mods = "LEADER",
			action = act.ActivateCopyMode,
		},
		{
			key = "r",
			mods = "LEADER",
			action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
		},

		-- Move between split panes
		split_nav("move", "h"),
		split_nav("move", "j"),
		split_nav("move", "k"),
		split_nav("move", "l"),

		-- Resize panes
		split_nav("resize", "h"),
		split_nav("resize", "j"),
		split_nav("resize", "k"),
		split_nav("resize", "l"),
		-- Existing keybindings
		{
			key = "f",
			mods = "LEADER",
			action = act.ToggleFullScreen,
		},
		{
			key = "P",
			mods = "SHIFT|CTRL",
			action = act.ActivateCommandPalette,
		},
		{
			key = "x",
			mods = "LEADER",
			action = act.CloseCurrentPane({ confirm = false }),
		},
		{
			key = "X",
			mods = "LEADER",
			action = act.CloseCurrentTab({ confirm = false }),
		},
		{
			key = "q",
			mods = "LEADER",
			action = act.QuitApplication,
		},
		{
			key = "m",
			mods = "LEADER",
			action = act.ActivateKeyTable({ name = "move_tab", one_shot = false }),
		},
		{
			key = "t",
			mods = "LEADER",
			action = act.ShowTabNavigator,
		},
		{
			key = "n",
			mods = "LEADER",
			action = act.SpawnTab("CurrentPaneDomain"),
		},
		{
			key = "h",
			mods = "ALT",
			action = act.ActivateTabRelative(-1),
		},

		{
			key = "l",
			mods = "ALT",
			action = act.ActivateTabRelative(1),
		},

		-- Rename tab
		{
			key = ",",
			mods = "LEADER",
			action = act.PromptInputLine({
				description = "Enter new tab title",
				action = wezterm.action_callback(function(window, _, line)
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},
		-- Workspace
		{
			key = "w",
			mods = "LEADER",
			action = workspace_switcher.switch_workspace(),
		},
		-- {
		-- 	key = "w",
		-- 	mods = "LEADER",
		-- 	action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
		-- },
		{
			key = "W",
			mods = "LEADER",
			action = act.PromptInputLine({
				description = wezterm.format({
					{ Attribute = { Intensity = "Bold" } },
					{ Foreground = { AnsiColor = "Fuchsia" } },
					{ Text = "Enter name for new workspace" },
				}),
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
		{
			key = "[",
			mods = "LEADER",
			action = act.SwitchWorkspaceRelative(1),
		},
		{
			key = "]",
			mods = "LEADER",
			action = act.SwitchWorkspaceRelative(-1),
		},
		{
			key = "Q",
			mods = "LEADER",
			action = act.QuitApplication,
		},
		{
			key = "z",
			mods = "LEADER",
			action = act.TogglePaneZoomState,
		},
		{
			key = "p",
			mods = "LEADER",
			action = act({ PasteFrom = "Clipboard" }),
		},
		{
			key = "y",
			mods = "LEADER",
			action = act({ CopyTo = "Clipboard" }),
		},
		{
			key = "c",
			mods = "LEADER",
			action = act.SpawnTab("CurrentPaneDomain"),
		},
	}
	-- Quick tab movement
	for i = 1, 9 do
		table.insert(config.keys, {
			key = tostring(i),
			mods = "LEADER",
			action = act.ActivateTab(i - 1),
		})
	end

	config.key_tables = {
		resize_pane = {
			{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
			{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
			{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
			{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
			{ key = "Escape", action = "PopKeyTable" },
			{ key = "Enter", action = "PopKeyTable" },
		},
		move_tab = {
			{ key = "h", action = act.MoveTabRelative(-1) },
			{ key = "j", action = act.MoveTabRelative(-1) },
			{ key = "k", action = act.MoveTabRelative(1) },
			{ key = "l", action = act.MoveTabRelative(1) },
			{ key = "Escape", action = "PopKeyTable" },
			{ key = "Enter", action = "PopKeyTable" },
		},
	}
end

return M
