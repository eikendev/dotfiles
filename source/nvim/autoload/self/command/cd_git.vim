""
" Change the working directory to git root if available.
""
function! self#command#cd_git#(silent) abort
	let l:git_dir = finddir('.git', ';')

	if l:git_dir !=# ''
		silent execute 'cd' fnameescape(l:git_dir)
		silent execute 'cd ../'

		let l:pwd = getcwd()
		let l:message = 'Found git root: ' . l:pwd
	else
		let l:message = 'Could not find git root.'
	endif

	if !a:silent
		echo l:message
	endif
endfunction
