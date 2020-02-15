""
" Switch between source and header.
""
function! self#mapping#navigation#switch_source_header(source, header) abort
	let l:name = expand("%:r")

	if (expand("%:e") == a:source)
		let l:extension = a:header
	else
		let l:extension = a:source
	endif

	let l:alternate = l:name . '.' . l:extension
	execute 'e ' . l:alternate
endfunction
