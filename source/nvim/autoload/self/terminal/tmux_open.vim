""
" Open the tmux toggle pane.
""
function! self#terminal#tmux_open#() abort
	" TODO: Find a way to assure the toggle pane activation.
	return self#terminal#tmux_toggle#()
endfunction
