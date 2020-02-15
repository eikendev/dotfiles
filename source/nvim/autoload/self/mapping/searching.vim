""
" Search a pattern using grep.
""
function! self#mapping#searching#grep(populated, pattern) abort
	let l:is_git = finddir('.git', ';')

	if a:populated
		let l:command = 'DeniteCursorWord'
		let l:argument = '-immediately-1'
	else
		let l:command = 'Denite'
		let l:argument = ''
	endif

	if l:is_git !=# ''
		let l:source = 'grep/git:::' . a:pattern
		execute l:command . ' ' . l:source . ' -auto-action=highlight ' . l:argument . ' -path='
	else
		let l:source = 'grep:::' . a:pattern
		execute l:command . ' ' . l:source . ' -auto-action=highlight' . l:argument
	endif
endfunction

""
" Search a file.
""
function! self#mapping#searching#file(cd_project) abort
	let l:command = 'Denite'
	let l:is_git = finddir('.git', ';')

	if l:is_git !=# ''
		let l:source = 'file/rec/git'

		if a:cd_project
			call self#command#cd_git#(v:true)
		else
			let l:command = 'DeniteProjectDir'
		endif
	else
		let l:source = 'file/rec'
	endif

	execute l:command . ' ' . l:source . ' -start-filter'
endfunction

""
" Search a tag.
""
function! self#mapping#searching#tag(populated, cd_project) abort
	if a:populated
		let l:command = 'DeniteCursorWord'
		let l:argument = '-immediately-1'
	else
		let l:command = 'Denite'
		let l:argument = '-start-filter'
	endif

	if a:cd_project
		call self#command#cd_git#(v:true)
	endif

	execute l:command . ' tag ' . l:argument
endfunction
