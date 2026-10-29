scriptencoding utf-8

" Use <CR> to confirm completion, `<C-g>u` means break undo chain at current position.
inoremap <expr> <CR> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use <A-CR> to toggle completion.
inoremap <silent><expr> <A-CR> pumvisible() ? "\<C-e>" : "\<C-n>"

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <Tab>
\	pumvisible() ? "\<C-n>" :
\	"\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"
