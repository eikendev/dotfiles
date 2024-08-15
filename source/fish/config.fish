if status is-interactive
	if type -q tmux
		if not test -n "$TMUX"
			exec tmux
		end
	end
end
