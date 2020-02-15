augroup after_vim_bad_whitespace
	autocmd!
	autocmd FileType denite :HideBadWhitespace
	autocmd FileType denite-filter :HideBadWhitespace
	autocmd FileType vim-plug :HideBadWhitespace
augroup END
