if !has('autocmd')
	finish
endif

" Toggle relative numbers in insert/normal mode.
augroup togglenumbers
	autocmd!
	autocmd InsertEnter,BufLeave,WinLeave,FocusLost * if &number | setlocal norelativenumber | endif
	autocmd InsertLeave,BufEnter,WinEnter,FocusGained * if &number | setlocal relativenumber | endif
augroup end

" Default to insert mode in terminal buffer.
augroup terminalsettings
	autocmd!
	if has('nvim')
		" Set filetype so that denite can filter out terminals.
		autocmd TermOpen * setlocal filetype=terminal
		autocmd TermOpen * setlocal nonumber
		autocmd TermOpen * setlocal signcolumn=no
		autocmd TermOpen * startinsert
		autocmd BufWinEnter term://* startinsert
	endif
augroup end

" Jump to last known position.
augroup jumplast
	autocmd!
	autocmd BufRead ?* call self#autocmd#jumplast#()
augroup end

" Always open help page in full window.
augroup onlywindow
	autocmd!
	let g:onlywindow_fts = [
	\	'help',
	\	'man',
	\]
	autocmd FileType * if index(g:onlywindow_fts, expand("<amatch>")) >= 0 | only | endif
augroup end

" Highlight the hovered symbol and its references when holding the cursor.
augroup hoverhighlight
	autocmd!
	autocmd CursorHold * silent call CocActionAsync('highlight')
augroup end
