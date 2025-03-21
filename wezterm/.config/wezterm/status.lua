local wezterm = require("wezterm")
local mux = wezterm.mux
local M = {}

local function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return " " + title + " "
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return " " + tab_info.active_pane.title + " "
end

function M.load()
	wezterm.on("update-right-status", function(window, pane)
		local workspace_or_leader = window:active_workspace()
		-- Change the worspace name status if leader is active
		if window:active_key_table() then
			workspace_or_leader = window:active_key_table()
		end
		if window:leader_is_active() then
			workspace_or_leader = "LEADER"
		end

		local time = wezterm.strftime("%H:%M")
		local battery = ""
		for _, b in ipairs(wezterm.battery_info()) do
			battery = string.format("%.0f%%", b.state_of_charge * 100)
		end

		window:set_right_status(wezterm.format({
			{ Foreground = { Color = "FFB86C" } },
			"ResetAttributes",
			{ Text = wezterm.nerdfonts.oct_table .. " " .. workspace_or_leader },
			{ Text = " | " },
			{ Text = " " .. battery .. " " },
			{ Text = " | " },
			{ Text = wezterm.nerdfonts.md_clock .. " " .. time },
			{ Text = " | " },
		}))
	end)

	wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
		local title = tab_title(tab)
		if tab.is_active then
			return {
				{ Text = " " .. title .. " " },
			}
		end
		return title
	end)
end

return M
