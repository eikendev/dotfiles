scriptencoding utf-8

" Use <CR> to confirm completion, `<C-g>u` means break undo chain at current position.
if has('patch8.1.1068')
	" Use `complete_info` if (Neo)Vim supports it.
	inoremap <expr> <CR> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
	imap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use <A-CR> to toggle completion.
inoremap <silent><expr> <A-CR> pumvisible() ? "\<C-x>" : coc#refresh()

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <Tab>
\	pumvisible() ? "\<C-n>" :
\	coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
\	"\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"
