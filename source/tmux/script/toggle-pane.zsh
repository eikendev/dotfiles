#!/usr/bin/env zsh

# https://github.com/kutsan/dotfiles

# If there is more than one pane in the current window...
if (( $(tmux display-message -p '#{window_panes}') > 1 )) {
	# If the zoom is active...
	if [[ $(tmux display-message -p '#{window_zoomed_flag}') == '1' ]] {
		# Unzoom and go to last pane.
		tmux resize-pane -Z
		tmux last-pane
	} else {
		# Go to last pane and zoom.
		tmux last-pane
		tmux resize-pane -Z
	}
} else {
	# Create a new pane with 30 percent height.
	tmux split-window -v -p 30 -c "#{pane_current_path}"
}
