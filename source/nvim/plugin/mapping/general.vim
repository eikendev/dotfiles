scriptencoding utf-8

" Fix mapping for ctrl+spacebar.
map <Nul> <C-Space>
map! <Nul> <C-Space>

" Quick command execution.
nnoremap ! :!

" Enter command mode with space (now reserved for easymotion).
"nnoremap <Space> :

" Do not change position when existing insert mode.
inoremap <Esc> <Esc>`^

" Toggle between insert and normal mode.
nnoremap <A-Space> i
imap <A-Space> <Esc>

" Terminal escape using double <Esc>.
tnoremap <Esc><Esc> <C-\><C-n>
