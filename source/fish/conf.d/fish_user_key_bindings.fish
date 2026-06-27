function fish_user_key_bindings
	# Enable Ctrl+e to open the command line in an editor.
	bind -M insert \ce edit_command_buffer

	# Enable Alt+l to accept the command suggestion.
	bind -M insert \el accept-autosuggestion

	# Enable Alt+Enter to accept and run the command suggestion.
	bind -M insert \e\r 'commandline -f accept-autosuggestion execute'

	# Enable j/k to navigate the command history.
	bind -M insert \ej history-search-forward
	bind -M insert \ek history-search-backward

	# Disable up/down arrow keys.
	bind -M insert \e\[A true
	bind -M insert \e\[B true

	# Replace the default ctrl-alt-* chords with an Alt+f leader.
	if type -q fzf_configure_bindings
		fzf_configure_bindings \
			--directory=alt-f,d \
			--git_log=alt-f,l \
			--git_status=alt-f,s \
			--history=ctrl-r \
			--processes=alt-f,p \
			--variables=alt-f,v
	end
end
