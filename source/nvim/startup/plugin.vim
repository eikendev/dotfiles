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

	"Plug 'jeetsukumaran/vim-markology'
	"	let g:markology_include = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
	"	let g:markology_ignore_type = 'hmpqr'
	"	let g:markology_textlower = "\t"
	"	let g:markology_textupper = "\t"
	"	let g:markology_textother = "\t"

	Plug 'voldikss/vim-floaterm'

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

	Plug 'kana/vim-textobj-entire'

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

	Plug 'lambdalisue/suda.vim'

	" Transformation "
	""""""""""""""""""

	Plug 'bitc/vim-bad-whitespace'

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

	Plug 'neoclide/coc.nvim', {'branch': 'release'}
		let g:coc_snippet_next = '<Tab>'
		let g:coc_global_extensions = [
		\	'coc-emoji',
		\	'coc-java',
		\	'coc-python',
		\	'coc-rls',
		\	'coc-snippets',
		\	'coc-tabnine',
		\	'coc-tag',
		\	'coc-vimtex',
		\]

	Plug 'honza/vim-snippets'

	" Linting "
	"""""""""""

	Plug 'dense-analysis/ale'
		let g:ale_sign_column_always = 1
		let g:ale_linters_explicit = 1
		let g:ale_sign_error = '✘'
		let g:ale_sign_warning = '▲'
		let g:ale_echo_msg_error_str = 'E'
		let g:ale_echo_msg_warning_str = 'W'
		let g:ale_echo_msg_info_str = 'I'
		let g:ale_set_highlights = 0
		let g:ale_maximum_file_size = 1000000
		let g:ale_linters = {
		\	'c': ['clang', 'gcc', 'flawfinder'],
		\	'cpp': ['clang', 'gcc', 'flawfinder'],
		\	'go': ['golint'],
		\	'haskell': ['ghc', 'hlint'],
		\	'python': ['flake8', 'mypy'],
		\	'rust': ['cargo'],
		\	'sh': ['shellcheck'],
		\	'tex': ['lacheck'],
		\	'vim': ['vint'],
		\}
		let g:ale_python_flake8_options = '--ignore=E501'

	" Searching "
	"""""""""""""

	Plug 'Shougo/denite.nvim'

	Plug 'eikendev/denite-fzf'

	Plug 'eikendev/denite-man'

	" Use vim-native features, e.g. macros instead!
	"Plug 'terryma/vim-multiple-cursors'
	"	let g:multi_cursor_use_default_mapping = 0
	"	let g:multi_cursor_start_word_key = '<C-n>'
	"	let g:multi_cursor_select_all_word_key = '<Leader>A'
	"	let g:multi_cursor_next_key = '<C-n>'
	"	let g:multi_cursor_prev_key = '<C-p>'
	"	let g:multi_cursor_skip_key = '<C-x>'
	"	let g:multi_cursor_quit_key = '<Esc>'

	" Programming "
	"""""""""""""""

	Plug 'editorconfig/editorconfig-vim'

	Plug 'justinmk/vim-syntax-extra'

	Plug 'sunaku/vim-dasht'

	Plug 'lervag/vimtex'
		let g:vimtex_complete_enabled = 1
		let g:vimtex_view_general_viewer = 'okular'
		let g:vimtex_view_general_options = '--unique @pdf\#src:@line@tex'
		let g:vimtex_view_general_options_latexmk = '--unique'
		let g:vimtex_text_obj_enabled = 0
		let g:vimtex_quickfix_latexlog = {
		\	'fix_paths' : 0,
		\	'overfull' : 0,
		\	'underfull' : 0
		\}
		let g:vimtex_compiler_latexmk = {
		\	'background' : 1,
		\	'continuous' : 0,
		\	'callback' : 0
		\}

	Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }

	Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
		let g:vim_markdown_folding_disabled = 1

	Plug 'othree/html5.vim'

	Plug 'pangloss/vim-javascript'

	Plug 'elzr/vim-json', { 'for': 'json' }
call plug#end()
