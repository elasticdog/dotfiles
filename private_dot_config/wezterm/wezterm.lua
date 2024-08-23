local wezterm = require("wezterm")

return {
	color_scheme = "elasticdog",

	front_end = "WebGpu",

	font = wezterm.font("JetBrains Mono", { weight = "DemiBold" }),
	font_size = 18.0,

	font_rules = {
		{
			intensity = "Bold",
			italic = false,
			font = wezterm.font("JetBrains Mono", { weight = "ExtraBold" }),
		},
	},

	bold_brightens_ansi_colors = false,

	hide_tab_bar_if_only_one_tab = true,

	keys = {
		{
			-- open http links in system browser
			key = "e",
			mods = "CTRL|ALT",
			action = wezterm.action.QuickSelectArgs({
				label = "open url",
				patterns = {
					"https?://\\S+",
				},
				action = wezterm.action_callback(function(window, pane)
					local url = window:get_selection_text_for_pane(pane)
					wezterm.log_info("opening: " .. url)
					wezterm.open_with(url)
				end),
			}),
		},
	},

	background = {
		{
			source = {
				File = wezterm.home_dir .. "/.config/wezterm/terminal-wallpaper.jpg"
			},
			hsb = {
				brightness = 1.1,
				saturation = 0.2,
			},
			opacity = 0.9,
		}
	},

	inactive_pane_hsb = {
		saturation = 0.4,
		brightness = 0.8,
	},
}
