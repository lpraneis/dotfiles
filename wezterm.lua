local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font('Berkeley Mono', { stretch = 'SemiCondensed' })
config.font_size = 13
config.use_fancy_tab_bar = false
config.show_tabs_in_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.window_decorations = "RESIZE"
config.colors = {
	background = '#121212'
}
config.color_scheme = 'Kanagawa (Gogh)'
config.audible_bell = "Disabled"

return config
