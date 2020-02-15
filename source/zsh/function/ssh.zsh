# Do not rename tmux window when running ssh.
function ssh {
	if [ -n "$TMUX" ]; then
		tmux rename-window "ssh"
		tmux set-option -g automatic-rename off
		tmux set-option -g allow-rename off
	fi

	command ssh "$@"

	if [ -n "$TMUX" ]; then
		tmux rename-window "zsh"
		tmux set-option -g automatic-rename on
		tmux set-option -g allow-rename on
	fi
}
