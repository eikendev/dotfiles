scriptencoding utf-8

call plug#begin('~/.local/share/nvim/plugged')

	" Enable help files for vim-plug.
	Plug 'junegunn/vim-plug'
		let g:plug_window = 'enew'

	" Interface "
	"""""""""""""

	Plug 'joshdick/onedark.vim'
		" Enable italic fonts.
		let g:onedark_terminal_italics = 1

	"Plug 'voldikss/vim-floaterm'

	Plug 'Yggdroot/indentLine'
		let g:indentLine_char = "┆"
		let g:indentLine_fileTypeExclude = [
		\	'denite',
		\	'denite-filter',
		\	'markdown',
		\	'vim-plug',
		\]

	" Movement "
	""""""""""""

	Plug 'tpope/vim-repeat'

	Plug 'kana/vim-textobj-user'

	Plug 'kana/vim-textobj-line'

	Plug 'eikendev/vim-textobj-names'

	Plug 'easymotion/vim-easymotion'
		let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz0123456789'
		let g:EasyMotion_smartcase = 1
		let g:EasyMotion_verbose = 0

	" Navigation "
	""""""""""""""

	Plug 'christoomey/vim-tmux-navigator'
		let g:tmux_navigator_no_mappings = 1
		let g:tmux_navigator_disable_when_zoomed = 1

	" Statusbar "
	"""""""""""""

	Plug 'vim-airline/vim-airline'
		let g:airline_symbols_ascii = 1
		let g:airline_exclude_preview = 1
		let g:airline_section_z = '%{self#util#number_of_buffers()}B %3p%% %5l/%L %2c'
		let g:airline#extensions#ale#enabled = 1
		let g:airline#extensions#whitespace#mixed_indent_algo = 2
		let g:airline#extensions#whitespace#symbol = '!'
		let g:airline#extensions#whitespace#checks = ['indent', 'trailing', 'mixed-indent-file']
		let g:airline#extensions#whitespace#mixed_indent_format = 'mixed[%s]'
		let g:airline#extensions#whitespace#mixed_indent_file_format = 'mixed[%s]'

	" Git "
	"""""""

	Plug 'tpope/vim-fugitive'

	Plug 'airblade/vim-gitgutter'
		let g:gitgutter_map_keys = 0
		let g:gitgutter_max_sign = 256
		let g:gitgutter_sign_added = '●'
		let g:gitgutter_sign_modified = '●'
		let g:gitgutter_sign_removed = '●'
		let g:gitgutter_sign_removed_first_line = '▔'
		let g:gitgutter_sign_modified_removed = '▁'

	" File operations "
	"""""""""""""""""""

	Plug 'tpope/vim-eunuch'

	" Transformation "
	""""""""""""""""""

	Plug 'scrooloose/nerdcommenter'
		let g:NERDAltDelims_c = 1

	Plug 'tpope/vim-surround'
		let g:surround_no_mappings = 1

	Plug 'junegunn/vim-easy-align'

	" Autocompletion "
	""""""""""""""""""

	" TODO Try out LucHermitte/lh-brackets.
	Plug 'cohama/lexima.vim'
		let g:lexima_no_default_rules = 1
		let g:lexima_map_escape = ''
		let g:lexima_enable_endwise_rules = 0

	" Linting "
	"""""""""""

	"Plug 'dense-analysis/ale'
	"	let g:ale_sign_column_always = 1
	"	let g:ale_linters_explicit = 1
	"	let g:ale_sign_error = '✘'
	"	let g:ale_sign_warning = '▲'
	"	let g:ale_echo_msg_error_str = 'E'
	"	let g:ale_echo_msg_warning_str = 'W'
	"	let g:ale_echo_msg_info_str = 'I'
	"	let g:ale_set_highlights = 0
	"	let g:ale_maximum_file_size = 1000000
	"	let g:ale_linters = {
	"	\	'c': ['clang', 'gcc', 'flawfinder'],
	"	\	'cpp': ['clang', 'gcc', 'flawfinder'],
	"	\	'go': ['golint'],
	"	\	'haskell': ['ghc', 'hlint'],
	"	\	'python': ['flake8', 'mypy'],
	"	\	'rust': ['cargo', 'rls'],
	"	\	'sh': ['shellcheck'],
	"	\	'tex': ['lacheck'],
	"	\	'vim': ['vint'],
	"	\}
	"	let g:ale_python_flake8_options = '--ignore=E501'

	" Searching "
	"""""""""""""

	Plug 'Shougo/denite.nvim'

	Plug 'eikendev/denite-fzf'

	Plug 'eikendev/denite-man'

	" Programming "
	"""""""""""""""

	Plug 'editorconfig/editorconfig-vim'

	Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
		let g:vim_markdown_folding_disabled = 1
		let g:vim_markdown_math = 1
		let g:vim_markdown_toml_frontmatter = 1

call plug#end()
