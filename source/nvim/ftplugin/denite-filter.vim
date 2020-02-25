let w:airline_disabled = 1

setlocal statusline=
setlocal noshowmode
setlocal noruler

call deoplete#custom#buffer_option('auto_complete', v:false)

imap <buffer> <CR> <Plug>(denite_filter_quit)
nmap <buffer> <BS> <Plug>(denite_filter_quit)

inoremap <silent><buffer><expr> <A-CR> denite#do_map('do_action')
nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')

inoremap <silent><buffer> <A-j> <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
inoremap <silent><buffer> <A-k> <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA

" TODO Find out why this autocommand doesn't work.
augroup autoclosefilter
	autocmd! * <buffer>
	"autocmd BufLeave <buffer> exec feedkeys("\<Plug>(denite_filter_quit)")
augroup end
