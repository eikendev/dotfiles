""
" Toggle conceallevel.
""
function! self#command#toggle_conceallevel#() abort
	if &conceallevel == 0
		setlocal conceallevel=2
	else
		setlocal conceallevel=0
	endif

	setlocal conceallevel?
endfunction
