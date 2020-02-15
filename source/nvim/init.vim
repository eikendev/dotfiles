scriptencoding utf-8

" Use true-color mode.
if (has('termguicolors'))
	set termguicolors
endif

" Do only set background color in GUI mode.
if (has('autocmd') && !has('gui'))
	let s:white = { 'gui': '#ABB2BF', 'cterm': '145', 'cterm16' : '7' }

	augroup init_scheme
		autocmd!
		autocmd ColorScheme * silent! call onedark#set_highlight('Normal', { 'fg': s:white })
	augroup END
endif

" Disable unused built-in functionality.
runtime! startup/disable.vim

" Define global variables.
runtime! startup/variable.vim

" Initialize plugins.
runtime! startup/plugin.vim

filetype plugin indent on
syntax on

try
	colorscheme onedark
catch /^Vim\%((\a\+)\)\=:E185/
	colorscheme koehler
endtry
