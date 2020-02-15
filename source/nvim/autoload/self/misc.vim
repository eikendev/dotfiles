""
" Bufdo command that restores the current buffer and alternate buffer.
""
function! self#misc#buffer_do(command)
	let l:cur_buffer = bufnr('%')
	let l:cur_alt_buffer = bufnr('#')

	silent execute 'bufdo ' . a:command

	if l:cur_alt_buffer != -1
		silent execute 'buffer ' . l:cur_alt_buffer
	endif

	if l:cur_buffer != -1
		silent execute 'buffer ' . l:cur_buffer
	endif
endfunction

""
" Toggle char at the end of the line.
""
function! self#misc#toggle_end_char(char) abort
	let l:old = getline('.')

	if l:old =~ a:char . '$'
		let l:new = substitute(l:old, '\v'.a:char.'$', '', '')
	else
		let l:new = l:old . a:char
	endif

	call setline('.', l:new)
endfunction
