# Increase the history size.
set-option -g history-limit 8192

# Size windows based on clients looking at that window.
set-window-option -g aggressive-resize on

# Renumber windows sequentially after closing any of them.
set-option -g renumber-windows on

# Start counting at 1 for easier navigation.
set-option -g base-index 1
set-window-option -g pane-base-index 1

# Disable delay when pressing ESC key. Do not set to zero.
# https://github.com/neovim/neovim/wiki/FAQ#esc-in-tmux-or-gnu-screen-is-delayed
set-option -sg escape-time 10

# Repeat-enabled keys can be used without prefix within this time.
set-option -sg repeat-time 250

# Monitor bells and propagate through.
set-option -gw monitor-bell on
set-option -g bell-action any
set-option -g visual-bell off

# Do not wrap around when searching.
set-window-option -g wrap-search off
