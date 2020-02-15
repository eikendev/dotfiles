""
" Synchronize helper variable to toggle quickfix window or location list.
""
augroup SomeListToggle
	autocmd!
	autocmd BufWinEnter quickfix let g:somelist_is_open = bufnr('$')
	autocmd BufWinLeave * if exists('g:somelist_is_open') && expand('<abuf>') == g:somelist_is_open
	\	| unlet! g:somelist_is_open
	\	| endif
augroup END

""
" Toggle quickfix window or location list.
""
function! self#command#toggle_somelist#(list) abort
	if exists('g:somelist_is_open')
		cclose
		lclose
	else
		if a:list ==# 'quickfix'
			copen
		elseif a:list ==# 'location'
			lopen
		else
			echoerr 'Specified list is unknown.'
		endif
	endif
endfunction
