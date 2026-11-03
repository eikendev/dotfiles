scriptencoding utf-8

" Fix mapping for ctrl+spacebar.
map <Nul> <C-Space>
map! <Nul> <C-Space>

" Quick command execution.
nnoremap ! :!

" Do not change position when existing insert mode.
inoremap <silent> <Esc> <Esc>:keepjumps normal! `^<CR>

" Terminal escape using double <Esc>.
tnoremap <Esc><Esc> <C-\><C-n>
