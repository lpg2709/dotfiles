local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Gruvbox Dark (Gogh)"
config.font = wezterm.font("TerminessTTF Nerd Font Mono")
config.font_size = 16.0

--config.window_decorations = "TITLE"

config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.scrollback_lines = 3000

config.leader  = { key = "b", mods = "CTRL" }
config.keys = {
	{
		key = "%",
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitHorizontal({domain = "CurrentPaneDomain"})
	},
	{
		key = "\"",
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitVertical({domain = "CurrentPaneDomain"})
	},
	{
		key = "h",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Left")
	},
	{
		key = "l",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Right")
	},
	{
		key = "k",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Up")
	},
	{
		key = "j",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Down")
	},
	{
		key = "w",
		mods = "LEADER",
		action = wezterm.action.ShowTabNavigator
	},
	{
		key = ",",
		mods = "LEADER",
		action = wezterm.action.PromptInputLine({
			description = "Rename tab: ",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{
		key = ":",
		mods = "LEADER|SHIFT",
		action = wezterm.action.ActivateCommandPalette
	},
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain")
	},
	{
		key = "[",
		mods = "LEADER",
		action = wezterm.action.ActivateCopyMode
	},
	{
		key = "]",
		mods = "LEADER",
		action = wezterm.action.PasteFrom("Clipboard")
	},
	{ key = "?", mods = "LEADER", action = wezterm.action.Search({ CaseSensitiveString = "" }) },
	{ key = "x", mods = "LEADER", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
	{ key = "F11", mods = "", action = wezterm.action.ToggleFullScreen },
	{ key = "1", mods = "LEADER", action = wezterm.action({ ActivateTab = 0 }) },
	{ key = "2", mods = "LEADER", action = wezterm.action({ ActivateTab = 1 }) },
	{ key = "3", mods = "LEADER", action = wezterm.action({ ActivateTab = 2 }) },
	{ key = "4", mods = "LEADER", action = wezterm.action({ ActivateTab = 3 }) },
	{ key = "5", mods = "LEADER", action = wezterm.action({ ActivateTab = 4 }) },
	{ key = "6", mods = "LEADER", action = wezterm.action({ ActivateTab = 5 }) },
	{ key = "7", mods = "LEADER", action = wezterm.action({ ActivateTab = 6 }) },
	{ key = "8", mods = "LEADER", action = wezterm.action({ ActivateTab = 7 }) },
	{ key = "9", mods = "LEADER", action = wezterm.action({ ActivateTab = 8 }) },
}

config.status_update_interval = 1000
wezterm.on("update-right-status", function(window, pane)
	local ws_name = window:active_workspace()
	local time = wezterm.strftime("%d/%m/%Y %H:%M")
	local cwd = pane:get_current_working_dir()

	window:set_right_status(wezterm.format({
		{ Background = { Color = "#98971A" } },
		{ Foreground = { Color = "#1C1C1C" } },
		{ Text = " [ " .. time .. " ]"}
	}))
end)

return config
