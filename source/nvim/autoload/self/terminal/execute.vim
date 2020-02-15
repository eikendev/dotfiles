""
" Execute a given command in inside the toggle terminal buffer.
"
" @param {string} command Command to run.
""
function! self#terminal#execute#(command) abort
	" Open a terminal window.
	call self#terminal#open#()

	" Clear the command line and issue the specified command.
	call feedkeys("\<C-U>")
	call feedkeys(a:command)
	call feedkeys("\<CR>")
endfunction
