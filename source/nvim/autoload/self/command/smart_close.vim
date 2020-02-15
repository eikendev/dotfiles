""
" Close the buffer, quit if only one buffer is left.
""
function! self#command#smart_close#() abort
	" Usually, there are other buffers if the active one is not listed.
	if !&buflisted
		bdelete!
		return v:true
	endif

	" If the file is modified, we prompt for saving it.
	if &modified
		echohl Question
		call inputsave()

		try
			let l:answer = input('File was modified. Save and quit? (y/N): ')
		finally
			redraw!
			call inputrestore()
			echohl None
		endtry

		if l:answer !=? 'y'
			return v:false
		else
			write
		endif
	endif

	if self#util#number_of_buffers() == 1
		quit
	else
		let l:buffer_name = bufname('%')

		if (l:buffer_name =~# 'term://')
			bwipeout!
		else
			bdelete
		endif
	endif
endfunction
