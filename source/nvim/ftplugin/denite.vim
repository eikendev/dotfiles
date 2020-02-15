let w:airline_disabled = 1

setlocal statusline=
setlocal noshowmode
setlocal noruler

nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
nnoremap <silent><buffer><expr> q denite#do_map('quit')
nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
