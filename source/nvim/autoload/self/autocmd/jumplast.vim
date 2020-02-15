""
" Jump to last known position and center buffer around cursor.
"
" autocmd BufReadPost *? call self#autocmd#jumplast#()
""
function! self#autocmd#jumplast#() abort
	if empty(&buftype) && index(['diff', 'gitcommit'], &filetype) == -1
		if line("'\"") >= 1 && line("'\"") <= line('$')
			execute 'normal! g`"zz'
		endif
	endif
endfunction
