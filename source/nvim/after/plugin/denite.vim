call denite#custom#option('_', {
\	'auto_resize': v:true,
\	'empty': v:false,
\	'filter_updatetime': 75,
\	'max_dynamic_update_candidates': 50000,
\	'mode': 'normal',
\	'reversed': v:true,
\	'smartcase': v:true,
\	'split': 'floating',
\	'statusline': v:false,
\ })

function s:update_denite_size()
	call denite#custom#option('_', {
	\	'winheight': &lines * 3 / 4,
	\	'winwidth': &columns * 3 / 4,
	\	'winrow': (&lines - 3) / 8,
	\	'wincol': &columns / 8,
	\ })
endfunction

" Adjust once on startup.
call <SID>update_denite_size()

" Adjust when the window is resized.
if has('autocmd')
	augroup deniteoptions
		autocmd!
		autocmd VimResized * call <SID>update_denite_size()
	augroup end
endif

" Allow more candidates to be filtered.
call denite#custom#source('_', 'max_candidates', 50000)

" Use a custom matcher.
call denite#custom#source('_', 'matchers', ['matcher/cpsm'])

" Do not show terminals and help in buffer list.
call denite#custom#var('buffer', 'exclude_filetypes', ['denite','terminal','help'])

" Denite source that uses the git-ls-files command.
call denite#custom#alias('source', 'file/rec/git', 'file/rec')
call denite#custom#var('file/rec/git', 'command', ['git', 'ls-files', '--exclude-standard', '--recurse-submodules', ':/'])

if executable('rg')
	" Use ripgrep if available.
	call denite#custom#var('grep', 'command', ['rg'])
	call denite#custom#var('grep', 'default_opts', ['--vimgrep', '--no-heading'])
	call denite#custom#var('grep', 'recursive_opts', [])
	call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
	call denite#custom#var('grep', 'separator', ['--'])
	call denite#custom#var('grep', 'final_opts', [])
else
	" Do not process binary files (-I) when using grep.
	call denite#custom#var('grep', 'default_opts', ['-i', '-n', '-I'])
endif

" Denite source that uses the git-grep command.
call denite#custom#alias('source', 'grep/git', 'grep')
call denite#custom#var('grep/git', 'command', ['git', '--no-pager', 'grep', '--no-index', '--exclude-standard'])
call denite#custom#var('grep/git', 'recursive_opts', [])

" Grep the whole git repository no matter where the current buffer is located.
call denite#custom#var('grep/git', 'final_opts', [':/'])
