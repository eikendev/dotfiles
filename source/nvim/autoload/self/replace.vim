" NOTE Inspired by https://github.com/LucHermitte/lh-misc/

function! self#replace#restore()
	if &clipboard == 'unnamed'
		let @* = s:restore_reg
	elseif &clipboard == 'unnamedplus'
		let @+ = s:restore_reg
	else
		let @" = s:restore_reg
	endif

	return ''
endfunction

function! self#replace#replace()
	let s:restore_reg = @"

	return "p@=self#replace#restore()\<CR>"
endfunction
