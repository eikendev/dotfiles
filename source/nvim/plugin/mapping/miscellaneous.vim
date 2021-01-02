scriptencoding utf-8

" Make it possible to use tmux from within vim.
nnoremap <silent> T :TmuxToggle<CR>
nnoremap <silent> M :TmuxExecute make<CR>
nnoremap <silent> X :TmuxExecute make run<CR>

" Linter movement and action triggering.
nmap <Leader>af <Plug>(ale_fix)
nmap <Leader>ag <Plug>(ale_go_to_definition)
nmap <Leader>al <Plug>(ale_lint)
nmap <Leader>ad <Plug>(ale_detail)
nmap ]a <Plug>(ale_next_wrap)
nmap [a <Plug>(ale_previous_wrap)
