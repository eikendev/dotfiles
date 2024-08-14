local wezterm = require 'wezterm'
local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

local config = wezterm.config_builder()

config.enable_wayland = true

config.color_scheme = 'MaterialDarker'

config.window_background_opacity = 0.8

config.hide_mouse_cursor_when_typing = false

config.check_for_updates = false

config.enable_tab_bar = false

config.font_size = 13

return config
