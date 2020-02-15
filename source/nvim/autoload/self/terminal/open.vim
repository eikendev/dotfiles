""
" Open the terminal window.
""
function! self#terminal#open#() abort
	" If the toggle terminal is not active, toggle.
	if &buftype != 'terminal'
		call self#terminal#toggle#()
	endif

	" If called from within the terminal in normal mode, reset to insert mode.
	startinsert
endfunction
