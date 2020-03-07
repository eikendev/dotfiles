""
" Toggle the terminal window.
"
" nnoremap <silent> <C-z> :call self#terminal#toggle#()<Enter>
" tnoremap <silent> <C-z> <C-\><C-n>:call self#terminal#toggle#()<Enter>
""
function! self#terminal#toggle#() abort
	call floaterm#toggle()
endfunction
