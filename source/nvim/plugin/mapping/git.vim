" Manage hunks using gitgutter.
nmap <Leader>hh <Plug>(GitGutterPreviewHunk)
nmap <Leader>hs <Plug>(GitGutterStageHunk)
nmap <Leader>hu <Plug>(GitGutterUndoHunk)

" Move to next or previous hunk.
nmap <silent> [h :call GitPrevHunkWrap()<CR>
nmap <silent> ]h :call GitNextHunkWrap()<CR>

" Fugitive mappings.
nnoremap <silent> <Leader>ga :Gwrite<CR>
nnoremap <silent> <Leader>gb :Gblame<CR>
nnoremap <silent> <Leader>gc :Gc<CR>
nnoremap <silent> <Leader>gd :Gdiff<CR>
nnoremap <silent> <Leader>gD :Git! diff<CR>
nnoremap <silent> <Leader>gl :silent! Glog -32 -- %<CR>
nnoremap <silent> <Leader>gh :silent! Glog -32 --follow -p -- %<CR>
nnoremap <silent> <Leader>gp :Gpull<CR>
nnoremap <silent> <Leader>gP :Gpush<CR>
nnoremap <silent> <Leader>gr :Gread<CR>
nnoremap <silent> <Leader>gs :Gstatus<CR>
nnoremap <silent> <Leader>gw :Gwrite<CR>
