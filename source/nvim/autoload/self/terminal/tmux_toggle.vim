""
" Toggle the tmux toggle pane.
""
function! self#terminal#tmux_toggle#() abort
	if !has('nvim')
		return v:false
	endif

	if !executable('tmux')
		return v:false
	endif

	if len($TMUX) > 0
		let l:cmd = "tmux display-message -p '#{window_panes}'"
		let l:window_panes = system(l:cmd)

		if str2nr(l:window_panes) > 1
			let l:cmd = "tmux display-message -p '#{window_zoomed_flag}'"
			let l:window_zoomed_flag = system(l:cmd)

			if str2nr(l:window_zoomed_flag) == 1
				let l:cmd = 'tmux resize -Z'
				call system(l:cmd)

				let l:cmd = 'tmux last-pane'
				call system(l:cmd)
			else
				let l:cmd = 'tmux last-pane'
				call system(l:cmd)

				let l:cmd = 'tmux resize -Z'
				call system(l:cmd)
			endif
		else
			let l:cmd = "tmux split-window -v -p 30 -c '#{pane_current_path}'"
			call system(l:cmd)
		endif
	else
		return v:false
	endif

	return v:true
endfunction
