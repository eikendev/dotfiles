scriptencoding utf-8

" Do not jump when searching for word.
nnoremap <silent> * m`:keepjumps normal! *``<CR>

" Enable jumping back after a search.
nnoremap <silent> n :keepjumps normal! n<CR>

" Jump to the tag under the cursor.
nnoremap <silent> <Leader>jt <C-]>

" Use space as easymotion prefix.
map <Space> <Plug>(easymotion-prefix)

" Multi-input search in easymotion.
nmap <Leader><Space> <Plug>(easymotion-sn)
xmap <Leader><Space> <Plug>(easymotion-sn)
