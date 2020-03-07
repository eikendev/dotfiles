let g:floaterm_position = 'center'
let g:floaterm_borderchars = ['', '', '', '', '', '', '', '']

function s:update_floatterm_size()
	let g:floaterm_height = &lines * 3 / 4
	let g:floaterm_width = &columns * 3 / 4
endfunction

" Adjust once on startup.
call <SID>update_floatterm_size()

" Adjust when the window is resized.
if has('autocmd')
	augroup floattermoptions
		autocmd!
		autocmd VimResized * call <SID>update_floatterm_size()
	augroup end
endif
