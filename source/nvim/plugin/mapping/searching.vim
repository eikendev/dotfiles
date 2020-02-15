scriptencoding utf-8

" Do not jump when searching for word.
nnoremap <silent> * m`:keepjumps normal! *``<CR>

" Enable jumping back after a search.
nnoremap <silent> n :keepjumps normal! n<CR>

" Use space as easymotion prefix.
map <Space> <Plug>(easymotion-prefix)

" Multi-input search in easymotion.
nmap <Leader><Space> <Plug>(easymotion-sn)
xmap <Leader><Space> <Plug>(easymotion-sn)

" Add Denite mappings.
nnoremap <silent> <F1> :TryWrite<CR>:Denite help -start-filter<CR>
nnoremap <silent> <Leader><Leader> :TryWrite<CR>:Denite buffer<CR>
nnoremap <silent> <Leader>d, :TryWrite<CR>:call self#mapping#searching#grep(v:false, 'TODO')<CR>
nnoremap <silent> <Leader>dc :TryWrite<CR>:Denite command -start-filter<CR>
nnoremap <silent> <Leader>dd :TryWrite<CR>:call self#mapping#searching#grep(v:false, '')<CR>
nnoremap <silent> <Leader>df :TryWrite<CR>:call self#mapping#searching#file(v:false)<CR>
nnoremap <silent> <Leader>dF :TryWrite<CR>:call self#mapping#searching#file(v:true)<CR>
nnoremap <silent> <Leader>dh :TryWrite<CR>:Denite command_history<CR>
nnoremap <silent> <Leader>dj :TryWrite<CR>:Denite jump<CR>
nnoremap <silent> <Leader>dk :TryWrite<CR>:Denite mark<CR>
nnoremap <silent> <Leader>dm :TryWrite<CR>:Denite man -start-filter<CR>
nnoremap <silent> <Leader>do :TryWrite<CR>:Denite outline -auto-action=highlight<CR>
nnoremap <silent> <Leader>dr :TryWrite<CR>:Denite register<CR>
nnoremap <silent> <Leader>ds :TryWrite<CR>:Denite spell<CR>
nnoremap <silent> <Leader>dt :TryWrite<CR>:call self#mapping#searching#tag(v:false, v:true)<CR>
nnoremap <silent> <Leader>dT :TryWrite<CR>:call self#mapping#searching#tag(v:true, v:true)<CR>
nnoremap <silent> <Leader>dw :TryWrite<CR>:call self#mapping#searching#grep(v:true, '')<CR>

" Search documentation for related files.
nnoremap <Leader>K :Dasht<Space>
nnoremap <silent> <Leader>k :call Dasht([expand('<cword>'), expand('<cWORD>')])<Return>
vnoremap <silent> <Leader>k y:<C-U>call Dasht(getreg(0))<Return>
