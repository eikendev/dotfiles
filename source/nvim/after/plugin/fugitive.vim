" Do not keep closed fugitive buffers.
augroup after_fugitive
	autocmd!
	autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END
