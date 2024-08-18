if status is-interactive
	eval (zellij setup --generate-auto-start fish | string collect)

	# Setup hooks for direnv.
	if command -v direnv > /dev/null
		eval (direnv hook fish)
	end

	zoxide init fish --cmd j | source

	starship init fish | source
end
