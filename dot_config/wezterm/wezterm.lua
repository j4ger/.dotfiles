local wezterm = require("wezterm")

return {
	font = wezterm.font_with_fallback({
		"FiraCode Nerd Font Mono",
		"Noto Sans CJK SC",
	}),
	font_size = 14.0,
	enable_tab_bar = false,
	enable_scroll_bar = false,
	window_background_opacity = 0.6,
	color_scheme = "nord",
	enable_wayland = true,
}
