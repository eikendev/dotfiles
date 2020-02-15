scriptencoding utf-8

let s:middot='·'
let s:raquo='»'
let s:small_l='ℓ'

""
" Defines the string to be displayed for closed folds.
""
function! self#settings#foldtext() abort
	let l:lines = '[' . (v:foldend - v:foldstart + 1) . ' lines]'
	let l:first = substitute(getline(v:foldstart), '\v *', '', '')
	let l:dashes = substitute(v:folddashes, '-', s:middot, 'g')

	return s:raquo . s:middot . s:middot . l:lines . l:dashes . l:first
endfunction
