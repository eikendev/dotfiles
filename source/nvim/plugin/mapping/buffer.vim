scriptencoding utf-8

" Switch back to the last buffer.
nnoremap <silent> # :e #<CR>

" Quickly navigate through buffers.
nnoremap <silent> <Tab> :bn<CR>
nnoremap <silent> <S-Tab> :bp<CR>

" Quickly save in normal mode.
nnoremap <CR> :w<CR>
nnoremap <A-CR> :wq<CR>

" Reload all buffers.
nnoremap <silent> <F5> :ReloadAllBuffers<CR>

" Close a buffer, quit for last buffer.
nnoremap <silent> <BS> :SmartClose<CR>

" Prevent one from closing when coming from command mode.
cnoremap <expr> <BS> len(getcmdline()) == 0 ? "" : "\<BS>"
"cnoremap <expr> <Space> (getcmdtype() == ':' && len(getcmdline()) == 0) ? "\<BS>" : "\<Space>"

" Enable or disable spell checking.
nnoremap <silent> <Leader>S :setlocal spell!<CR>

" Enable or disable number.
nnoremap <silent> <Leader>n :setlocal number!<CR>:setlocal relativenumber!<CR>

" Enable or disable concealing.
nnoremap <silent> <Leader>C :ToggleConceallevel<CR>

" Disable search highlighting.
nnoremap <silent> <ESC> :noh<CR><ESC>

" Open fold with l in normal mode.
nnoremap <expr> l foldclosed(line('.')) != -1 ? 'zo0' : 'l'

" Window transformations.
nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Left> :vertical resize +2<CR>
nnoremap <C-Right> :vertical resize -2<CR>

" Exchange hunks in diff view in visual mode.
xnoremap <Leader>dp :diffput<CR>
xnoremap <Leader>dg :diffget<CR>

" Update diff in diffmode.
nnoremap du :diffupdate<CR>
