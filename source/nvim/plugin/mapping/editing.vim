scriptencoding utf-8

" Quick macro execution.
nnoremap Q @q

" Do not overwrite yank when deleting a character.
nnoremap x "_x

" Do not overwrite yank when pasting.
xnoremap <silent> <expr> p self#replace#replace()

" Use tab for indenting in visual mode.
xnoremap <Tab> >gv
xnoremap <S-Tab> <gv
xnoremap > <Nop>
xnoremap < <Nop>
nnoremap > >>
nnoremap < <<

" Paste from system clipboard.
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
xnoremap <Leader>p "+p

" Yank into system clipboard.
nnoremap <Leader>y "+y
nnoremap <Leader>Y "+Y
xnoremap <Leader>y "+y

" Yank till the end of the line.
nnoremap Y y$

" Insert space and line in normal mode.
nnoremap <A-h> i<Space><Esc>l
nnoremap <A-l> a<Space><Esc>h
nnoremap <A-j> :PreserveExecute call append(line(".") + 0, "")<CR>
nnoremap <A-k> :PreserveExecute call append(line(".") - 1, "")<CR>

" Move line up and down.
nnoremap <A-K> :move -2<CR>
nnoremap <A-J> :move +1<CR>

" Replace line from within insert mode.
inoremap <C-Del> <C-\><C-o>cc

" Toggle semicolon at the end of the current line.
nmap ; <Plug>(self-toggle-semicolon)

" Reindent the current file.
nnoremap == :PreserveNormal gg=G<CR>

" Simpified substitutions.
nnoremap s :%s//g<Left><Left>
xnoremap S *<Esc>:%s///g<Left><Left>

" Replace current word with the word last yanked.
nnoremap <silent> S :PreserveNormal "_diw"0P<CR>

" Sort using the '|' (pipe) character, see `map_bar`.
xnoremap <Bar> :sort i<CR>

" Select pasted text.
nnoremap <expr> gp '`['.strpart(getregtype(), 0, 1).'`]'

" Increment and decrement the number under the cursor.
nmap <Leader>+ <C-a>
nmap <Leader>- <C-x>

" Bubble lines in visual line mode, jump in character-wise visual mode.
xnoremap <expr> J mode() ==# 'V' ? ":move '>+1<Enter>gv=gv" : '5j'
xnoremap <expr> K mode() ==# 'V' ? ":move '<-2<Enter>gv=gv" : '5k'

" Erase bad whitespace.
nnoremap <silent> <Leader>w :EraseBadWhitespace<CR>

" Delete a surrounding.
nmap <Leader>sd <Plug>Dsurround
" Change a surrounding.
nmap <Leader>sc <Plug>Csurround
" Surround a text object.
nmap <Leader>so <Plug>Ysurround
" Surround a line.
nmap <Leader>sl <Plug>Yssurround
" Wrap the selection.
xmap <Leader>s <Plug>VSurround

" Apply codeAction on the selected region.
" Example: `<leader>lap` for current paragraph
xmap <leader>la <Plug>(coc-codeaction-selected)
nmap <leader>la <Plug>(coc-codeaction-selected)

" Apply codeAction to the current line.
nmap <leader>ll <Plug>(coc-codeaction)

" Apply AutoFix on the current line.
nmap <leader>lf <Plug>(coc-fix-current)

" Rename symbol.
nmap <leader>lr <Plug>(coc-rename)
