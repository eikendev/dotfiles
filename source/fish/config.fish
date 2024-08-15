if status is-interactive
	set -g fish_key_bindings fish_user_key_bindings

	if type -q tmux
		if not test -n "$TMUX"
			exec tmux -f "$XDG_CONFIG_HOME/tmux/config"
		end
	end
end
