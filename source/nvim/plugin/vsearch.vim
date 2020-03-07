" See https://stackoverflow.com/a/6171215.
function! s:get_visual_selection() range
	" Save the current register and clipboard.
	let l:reg_save = getreg('"')
	let l:regtype_save = getregtype('"')
	let l:cb_save = &clipboard
	set clipboard&

	" Put the current visual selection in the " register.
	normal! ""gvy
	let l:selection = getreg('"')

	" Put the saved registers and clipboards back.
	call setreg('"', l:reg_save, l:regtype_save)
	let &clipboard = l:cb_save

	" Escape regex characters.
	let l:selection = escape(l:selection, '^$.*\/~[]')

	" Escape the line endings.
	let l:selection = substitute(l:selection, '\n', '\\n', 'g')

	return l:selection
endfunction

" Search for all occurences of the current selection.
vnoremap * <Esc>/<C-R>=<SID>get_visual_selection()<CR><CR>N
