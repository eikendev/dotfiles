scriptencoding utf-8

" Switch between windows.
noremap <silent> <C-j> :TmuxNavigateDown<CR>
noremap <silent> <C-k> :TmuxNavigateUp<CR>
noremap <silent> <C-h> :TmuxNavigateLeft<CR>
noremap <silent> <C-l> :TmuxNavigateRight<CR>
inoremap <C-j> <Esc>:TmuxNavigateDown<CR>
inoremap <C-k> <Esc>:TmuxNavigateUp<CR>
inoremap <C-h> <Esc>:TmuxNavigateLeft<CR>
inoremap <C-l> <Esc>:TmuxNavigateRight<CR>

" Jump to start and end of the line.
noremap H 0
noremap L $

" Enable easier jumping to marks.
nnoremap ´ `
nnoremap ´´ ``

" Navigation in vim command line.
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-j> <Home>
cnoremap <C-k> <End>
cnoremap <C-d> <C-w>

" Navigate the quickfix window.
nnoremap <silent> <Leader>qq :ToggleQuickfixList<CR>
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]Q :clast<CR>
nnoremap <silent> [Q :cfirst<CR>

" Navigate the location window.
nnoremap <silent> <Leader>ll :ToggleLocationList<CR>
nnoremap <silent> ]l :lnext<CR>
nnoremap <silent> [l :lprevious<CR>
nnoremap <silent> ]L :llast<CR>
nnoremap <silent> [L :lfirst<CR>
