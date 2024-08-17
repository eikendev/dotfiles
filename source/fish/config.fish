if status is-interactive
	if type -q tmux
		if not test -n "$TMUX"
			exec tmux
		end
	end

	# Setup hooks for direnv.
	if command -v direnv > /dev/null
		eval (direnv hook fish)
	end

	starship init fish | source
end
