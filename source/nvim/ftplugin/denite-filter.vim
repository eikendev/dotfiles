let w:airline_disabled = 1

setlocal statusline=
setlocal noshowmode
setlocal noruler

inoremap <silent><buffer><expr> <A-CR> denite#do_map('do_action')
nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')

inoremap <silent><buffer> <A-j> <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
nnoremap <silent><buffer> <A-j> <C-w>p:call cursor(line('.')+1,0)<CR><C-w>p
inoremap <silent><buffer> <A-k> <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
nnoremap <silent><buffer> <A-k> <C-w>p:call cursor(line('.')-1,0)<CR><C-w>p
