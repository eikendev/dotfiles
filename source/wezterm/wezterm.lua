local wezterm = require 'wezterm'
local act = wezterm.action
local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

local config = wezterm.config_builder()

config.enable_wayland = true

config.disable_default_key_bindings = true
config.keys = {
	{ key="C", mods="CTRL|SHIFT", action=act.CopyTo("ClipboardAndPrimarySelection") },
	{ key="V", mods="CTRL|SHIFT", action=act.PasteFrom("Clipboard") },
	{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
	{ key = "+", mods = "CTRL", action = act.IncreaseFontSize },
}

config.window_padding = {
	left = "8pt",
	right = "8pt",
	top = "8pt",
	bottom = "8pt",
}

local scheme = wezterm.color.get_builtin_schemes()['MaterialDarker']
scheme.background = 'black'

config.color_scheme = 'MaterialDarker'
config.color_schemes = {
	['MaterialDarker'] = scheme
}

config.font = wezterm.font_with_fallback { 'Monaspace Neon', 'Symbols Nerd Font', 'Noto Color Emoji' }
config.font_size = 13
config.harfbuzz_features = {'calt', 'ss01', 'ss02', 'ss03', 'ss07', 'ss09', 'liga'}

config.window_background_opacity = 0.8

config.hide_mouse_cursor_when_typing = false

config.check_for_updates = false

config.enable_tab_bar = false

config.enable_scroll_bar = false
config.scrollback_lines = 0

return config
