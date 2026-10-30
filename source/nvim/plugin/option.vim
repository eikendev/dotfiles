scriptencoding utf-8

" Only options that differ from Neovim's defaults are set here.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GENERAL                                                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Do not show mode in command line as it's displayed by the status line already.
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

" Enable mouse in all modes.
set mouse=a

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BUFFERS AND LOADING                                                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Fold by syntax unless treesitter provides folds for the buffer.
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

set smartindent

set copyindent

set preserveindent

set softtabstop=0

set shiftwidth=4

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EDITING                                                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set g flag per default when substituting.
set gdefault

" Do not redraw while running macros (faster).
set lazyredraw

" Allow for free moving in block selection mode.
set virtualedit=block

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SEARCHING                                                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Generally, ignore case.
set ignorecase

" Do not ignore case if search pattern contains upper case characters.
set smartcase

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
set scrolloff=11

" Recursively search for tags file.
set tags=./tags;

" Automatically select first option during completion.
set completeopt+=noinsert

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" USER INTERFACE                                                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Get rid of annoying status messages.
set shortmess=aoOTWIcF

" Mapping delays in milliseconds.
set timeoutlen=800

" Key code delays in milliseconds.
set ttimeoutlen=10

" Always draw the sign column even there is no sign in it.
set signcolumn=yes

" Set character to indicate linebreak.
let &showbreak='↳ '

" Set vertical bar character.
set fillchars=vert:┃
" Set filling character.
set fillchars+=fold:·

" Enable even prettier folding.
set foldtext=v:lua.require'self.foldtext'.text()

" Hide conceal markers.
set conceallevel=2
set concealcursor=""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ROOT USER                                                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if exists('$SUDO_USER')
	set noswapfile
	set noundofile
	set shada=''
endif
