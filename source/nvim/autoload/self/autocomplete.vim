""
" Handle candidate expansion on autocompletion.
""
function! self#autocomplete#expand() abort
	if v:completed_item == {}
		return
	endif

	let l:expandable = neosnippet#expandable()

	if l:expandable
		call feedkeys("\<Plug>(neosnippet_expand)")
	endif
endfunction

function! self#autocomplete#jump_forwards() abort
	if pumvisible()
		return "\<C-n>"
	elseif neosnippet#jumpable()
		call feedkeys("\<Plug>(neosnippet_jump)")
		return ''
	else
		return "\<TAB>"
	endif
endfunction

function! self#autocomplete#jump_backwards() abort
	if pumvisible()
		return "\<C-p>"
	else
		return "\<S-TAB>"
	endif
endfunction

function! self#autocomplete#guess_racer_binary() abort
	if executable('racer')
		let l:guess = systemlist('which racer')[0]
	else
		let l:guess = ''
	endif

	return l:guess
endfunction

function! self#autocomplete#guess_rust_source_path() abort
	if executable('rustc')
		let l:rustc_root = systemlist('rustc --print sysroot')[0]
		let l:rustc_src_dir = l:rustc_root . '/lib/rustlib/src/rust/src'

		if isdirectory(l:rustc_src_dir)
			let l:guess = l:rustc_src_dir
		endif
	else
		let l:guess = ''
	endif

	return l:guess
endfunction
