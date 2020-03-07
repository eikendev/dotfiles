scriptencoding utf-8

" Master the terminal.
tnoremap <silent> <Leader>tt <C-\><C-n>:TerminalToggle<CR>
nnoremap <silent> <Leader>tt :TerminalToggle<CR>
nnoremap <silent> <Leader>tm :TerminalExecute make<CR>
nnoremap <silent> <Leader>tx :TerminalExecute make run<CR>

" Make it possible to use tmux from within vim.
nnoremap <silent> T :TmuxToggle<CR>
nnoremap <silent> M :TmuxExecute make<CR>
nnoremap <silent> X :TmuxExecute make run<CR>

" Vimtex key mappings.
nnoremap <silent> <Leader>vr :w<CR>:VimtexCompileSS<CR>
nnoremap <silent> <Leader>vt :<C-u>Denite -no-empty vimtex<CR>

" Linter movement and action triggering.
nmap <Leader>af <Plug>(ale_fix)
nmap <Leader>ag <Plug>(ale_go_to_definition)
nmap <Leader>al <Plug>(ale_lint)
nmap <Leader>ad <Plug>(ale_detail)
nmap ]a <Plug>(ale_next_wrap)
nmap [a <Plug>(ale_previous_wrap)
