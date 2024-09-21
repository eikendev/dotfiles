" Manage hunks using gitgutter.
nmap <Leader>hh <Plug>(GitGutterPreviewHunk)
nmap <Leader>hs <Plug>(GitGutterStageHunk)
nmap <Leader>hu <Plug>(GitGutterUndoHunk)

" Move to next or previous hunk.
nmap <silent> [h :call GitPrevHunkWrap()<CR>
nmap <silent> ]h :call GitNextHunkWrap()<CR>
