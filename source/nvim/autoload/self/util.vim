""
" Returns the number of buffers currently opened. The number includes only
" buffers with the option `buflisted` set.
""
function! self#util#number_of_buffers() abort
	return len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
endfunction
