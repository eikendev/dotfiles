# Enable the Tc terminal capability for the outer terminal to which tmux is attached.
set-option -ga terminal-overrides ",xterm-256color:Tc"
set-option -g default-terminal "tmux-256color"

# Do not show status bar by default.
set-option -g status off

# Load plugins manually.
run-shell ~/.config/tmux/plugin/tmux-yank/yank.tmux

# Enable custom theme.
set-option -g @onedark_widgets "#(uname -sr)"
set-option -g @onedark_date_format "%Y-%m-%d"
set-option -g @onedark_time_format "%H:%M"
run-shell ~/.config/tmux/onedark.tmux
