local wezterm = require("wezterm")

return {
	font = wezterm.font_with_fallback({
		"FiraCode Nerd Font Mono",
		"Noto Sans Mono CJK SC",
		"Noto Emoji"
	}),
	font_size = 16.0,
	enable_tab_bar = false,
	enable_scroll_bar = false,
	window_background_opacity = 0.85,
	color_scheme = "nord",
	enable_wayland = true,
	default_cursor_style = "BlinkingBar",
	window_padding = {
		left = 15,
		right = 0,
		top = 5,
		bottom = 0,
	},
}
