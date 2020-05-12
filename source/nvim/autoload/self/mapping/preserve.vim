""
" Execute a command without changing cursor position.
" See https://vi.stackexchange.com/a/10700.
""
function! self#mapping#preserve#execute(command) abort
	try
		let l:win_view = winsaveview()
		let l:old_query = getreg('/', 1)
		execute 'keepjumps ' . a:command
	finally
		call winrestview(l:win_view)
		call setreg('/', l:old_query)
	endtry
endfunction

""
" Perform a command in normal mode without changing cursor position.
""
function! self#mapping#preserve#normal(command) abort
	let l:command = 'normal! ' . a:command
	call self#mapping#preserve#execute(l:command)
endfunction
