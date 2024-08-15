function fish_user_key_bindings
	fish_vi_key_bindings
	bind -M insert \ce edit_command_buffer
	bind -M insert \el accept-autosuggestion
	bind -M insert \e\r 'commandline -f accept-autosuggestion execute'
	bind -M insert \ej history-search-forward
	bind -M insert \ek history-search-backward
end
