local wezterm = require("wezterm")

return {
	color_scheme = "ElasticDog",

	front_end = "WebGpu",

	font = wezterm.font("JetBrains Mono", { weight = "Medium" }),
	font_size = 17.0,

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
}
