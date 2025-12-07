-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.font = wezterm.font("JetBrains Mono")
config.keys = {
	{
		key = "|",
		mods = "ALT|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "_",
		mods = "ALT|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
}

if os.getenv("XDG_CURRENT_DESKTOP") == "Hyprland" then
	config.enable_wayland = false
else
	config.enable_wayland = true
end

config.colors = {
	foreground = "white",
	background = "rgb(22, 23, 35)",

	cursor_bg = "#52ad70",
	cursor_fg = "black",
	cursor_border = "white",

	-- the foreground color of selected text
	selection_fg = "#a7a0bd",
	-- the background color of selected text
	selection_bg = "#160547",

	scrollbar_thumb = "#222222",

	-- The color of the split lines between panes
	split = "#444444",

	ansi = {
		"#1F2229",
		"#D41919",
		"#5EBDAB",
		"#FEA44C",
		"#367BF0",
		"#9755B3",
		"#49AEE6",
		"#E6E6E6",
	},
	brights = {
		"#198388",
		"#EC0101",
		"#47D4B9",
		"#FF8A18",
		"#277FFF",
		"#962AC3",
		"#05A1F7",
		"white",
	},

	indexed = { [136] = "#af8700" },
	compose_cursor = "orange",

	-- Colors for copy_mode and quick_select
	-- available since: 20220807-113146-c2fee766
	-- In copy_mode, the color of the active text is:
	-- 1. copy_mode_active_highlight_* if additional text was selected using the mouse
	-- 2. selection_* otherwise
	copy_mode_active_highlight_bg = { Color = "#000000" },
	-- use `AnsiColor` to specify one of the ansi color palette values
	-- (index 0-15) using one of the names "Black", "Maroon", "Green",
	--  "Olive", "Navy", "Purple", "Teal", "Silver", "Grey", "Red", "Lime",
	-- "Yellow", "Blue", "Fuchsia", "Aqua" or "White".
	copy_mode_active_highlight_fg = { AnsiColor = "Black" },
	copy_mode_inactive_highlight_bg = { Color = "#52ad70" },
	copy_mode_inactive_highlight_fg = { AnsiColor = "White" },

	quick_select_label_bg = { Color = "peru" },
	quick_select_label_fg = { Color = "#ffffff" },
	quick_select_match_bg = { AnsiColor = "Navy" },
	quick_select_match_fg = { Color = "#ffffff" },
}

function change_background(window)
	local window_dims = window:get_dimensions()
	local overrides = window:get_config_overrides() or {}

	if window_dims.is_full_screen then
		overrides.window_background_opacity = 1
		overrides.window_padding = {
			left = 25,
			right = 25,
			top = 25,
			bottom = 25,
		}
	else
		overrides.window_background_opacity = 0.96
		overrides.window_padding = nil
	end

	window:set_config_overrides(overrides)
end

wezterm.on("window-resized", function(window, pane)
	change_background(window)
end)

wezterm.on("window-config-reloaded", function(window)
	change_background(window)
end)

-- and finally, return the configuration to wezterm
return config
