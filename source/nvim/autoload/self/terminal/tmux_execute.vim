""
" Execute a given command in inside a tmux toggle pane.
"
" @param {string} command Command to run.
""
function! self#terminal#tmux_execute#(command) abort
	if !self#terminal#tmux_open#()
		return v:false
	endif

	" Wait for tmux to get ready.
	sleep 200m

	let l:cmd = "tmux display-message -p '#{pane_current_command}'"
	let l:pane_current_command = system(l:cmd)

	if l:pane_current_command ==# "zsh\n" || l:pane_current_command ==# "bash\n"
		let l:cmd = 'tmux send-keys C-u'
		call system(l:cmd)

		let l:cmd = printf("tmux send-keys -l '%s'", a:command)
		let l:window_panes = system(l:cmd)

		let l:cmd = 'tmux send-keys Enter'
		call system(l:cmd)
	else
		echohl WarningMsg
		echo 'Command not executed: pane is not running a shell.'
		echohl None

		return v:false
	endif
endfunction
