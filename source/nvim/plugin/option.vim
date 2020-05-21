scriptencoding utf-8

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GENERAL                                                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Do not show mode in command line as it's displayed by airline already.
set noshowmode

" Disable displaying key presses at the right bottom.
set noshowcmd

" Do not show line numbers.
set nonumber
set norelativenumber

" Spell checking language is English by default.
set spelllang=en

" Always report how many lines changed.
set report=0

" Enable mouse.
set mouse=a

" Prevent the cursor from changing the current column when jumping.
set nostartofline

" Do not make backups for files.
" Required by coc.nvim.
set nobackup
set nowritebackup

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BUFFERS AND LOADING                                                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set the default encoding.
set encoding=utf-8

" Do not unload buffers.
" Required by coc.nvim.
set hidden

" Read changed file automatically if no changes were made inside vim.
set autoread

" Fold by syntax.
set foldmethod=syntax

" Do not fold initially.
set nofoldenable

" Break long lines at whole words.
set linebreak

" Jump to the first open window that contains the specified buffer.
set switchbuf=useopen

" Enable persistent file history.
set undofile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TABS AND SPACES                                                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Length of a tab character.
set tabstop=4

" Do not replace tab by spaces.
set noexpandtab

set autoindent

set smartindent

set copyindent

set preserveindent

set softtabstop=0

set shiftwidth=4

set smarttab

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EDITING                                                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Never insert two spaces when joining lines.
set nojoinspaces

" Set g flag per default when substituting.
set gdefault

" Do not redraw while running macros (faster).
set lazyredraw

" Show live substitution results as one types.
set inccommand=nosplit

" Allow for free moving in block selection mode.
set virtualedit=block

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SEARCHING                                                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Generally, ignore case.
set ignorecase

" Do not ignore case if search pattern contains upper case characters.
set smartcase

" Show pattern matches while typing.
set incsearch

" Add HTML brackets to pair matching.
set matchpairs+=<:>

" Ignore files matching the following patterns.
set wildignore+=.git,.svn,*.o,*.out,*.obj,*.class
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.tgz
set wildignore+=*.swp,*~

" Ignore case when completing in command menu.
set wildignorecase

" List of directories which will be searched when using related features.
set path=.,**

" Suffixes that get lower priority when doing tab completion.
set suffixes=.bak,~,.swp,.o,.aux,.log,.bbl,.blg,.brf,.out,.toc,.pdf

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISCELLANEOUS                                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Center cursor.
" We cannot increase this further, since otherwise GitGutterPreviewHunk will
" throw an error.
set scrolloff=11

" Recursively search for tags file.
set tags=./tags;

" Hide docstring window popup during completion.
set completeopt-=preview

" Automatically select first option during completion.
set completeopt+=noinsert

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" USER INTERFACE                                                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Get rid of annoying status messages.
set shortmess=aoOTWIcF

" Do not pass messages to |ins-completion-menu|.
" Required by coc.nvim.
set shortmess+=c

" If this many milliseconds nothing is typed CursorHold event will trigger.
set updatetime=300

" Mapping delays in milliseconds.
set timeoutlen=800

" Key code delays in milliseconds.
set ttimeoutlen=10

" Always draw the sign column even there is no sign in it.
set signcolumn=yes

" Set character to indicate linebreak.
if has('linebreak')
	let &showbreak='↳ '
endif

" Pretty folding.
if has('folding')
	if has('windows')
		" Set vertical bar character.
		set fillchars=vert:┃
		" Set filling character.
		set fillchars+=fold:·
	endif

	" Enable even prettier folding.
	set foldtext=self#settings#foldtext()
endif

" Hide conceal markers for neocomplete.
if has('conceal')
	set conceallevel=2
	set concealcursor=""
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ROOT USER                                                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if exists('$SUDO_USER')
	set noswapfile
	set noundofile
	set shada=''
endif
