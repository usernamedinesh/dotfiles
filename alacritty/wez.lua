local wezterm = require("wezterm")

return {
	-- color_scheme = "terminal.sexy",
	color_scheme = "Catppuccin Mocha",
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	font_size = 16.0,
	font = wezterm.font("JetBrains Mono"),
	-- macos_window_background_blur = 40,
	macos_window_background_blur = 30,

	-- window_background_image = "/home/dinesh/Desktop/wall/nixos-wallpaper-catppuccin-mocha.png",
	-- window_background_image_hsb = {
	-- 	brightness = 0.01,
	-- 	hue = 1.0,
	-- 	saturation = 0.5,
	-- },
	window_background_opacity = 0.92,
	-- window_background_opacity = 0.78,
	-- window_background_opacity = 0.20,
	window_decorations = "RESIZE",
	keys = {
		{
			key = "f",
			mods = "CTRL",
			action = wezterm.action.ToggleFullScreen,
		},

		-- open new tab
		{
			key = "i",
			mods = "SUPER",
			action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }),
		},

		--switch the tab or buffer
		{
			key = "[",
			mods = "SUPER",
			action = wezterm.action({ ActivateTabRelative = -1 }),
		},
		{
			key = "]",
			mods = "SUPER",
			action = wezterm.action({ ActivateTabRelative = 1 }),
		},
		--close current tab or buffer
		{
			key = "x",
			mods = "SUPER",
			action = wezterm.action({ CloseCurrentTab = { confirm = true } }),
		},
	},
	mouse_bindings = {
		-- Ctrl-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
}
