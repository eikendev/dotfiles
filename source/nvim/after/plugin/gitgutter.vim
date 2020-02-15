" SEE https://github.com/airblade/vim-gitgutter/issues/260

function! GitPrevHunkWrap() abort
	let line = line('.')
	silent GitGutterPrevHunk

	if line('.') == line
		normal G
		silent GitGutterPrevHunk
	endif
endfunction

function! GitNextHunkWrap() abort
	let line = line('.')
	silent GitGutterNextHunk

	if line('.') == line
		normal 1G
		silent GitGutterNextHunk
	endif
endfunction
