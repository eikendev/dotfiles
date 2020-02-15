""
" Write the buffer if possible.
""
function! self#command#try_write#() abort
	let l:idx = index(['help','nofile','nowrite','quickfix','terminal'], &buftype)
	if l:idx != -1 || &readonly
		return
	endif

	if &modified && filewritable(@%) == 1
		write
	endif
endfunction
