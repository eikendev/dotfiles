""
" Toggle hex edit mode.
""
function! self#command#toggle_hex_edit#() abort
	if !executable('xxd')
		echo 'xxd is not installed.'
		return v:false
	endif

	if exists('g:hexmode') && g:hexmode == 1
		let g:hexmode=0
		%!xxd -r
	else
		let g:hexmode=1
		%!xxd
	endif
endfunction
