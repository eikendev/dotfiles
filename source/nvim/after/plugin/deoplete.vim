" Wait a bit longer until showing completion menu.
call deoplete#custom#option('auto_complete_delay', 400)

call deoplete#custom#option('camel_case', v:true)
call deoplete#custom#option('refresh_always', v:true)
call deoplete#custom#option('auto_refresh_delay', 20)

" Disable candidates in comments and strings.
call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])

" Remove currently typed words from completion menu.
call deoplete#custom#source('around', 'matchers', ['matcher_fuzzy', 'matcher_length'])
call deoplete#custom#source('buffer', 'matchers', ['matcher_fuzzy', 'matcher_length'])

" Snippet source has high priority in ranking.
call deoplete#custom#source('neosnippet', 'rank', 1000)

" Some snippets are only one character long.
call deoplete#custom#source('neosnippet', 'min_pattern_length', 1)

" Set filetypes for emoji source.
call deoplete#custom#source('emoji', 'filetypes', ['mail', 'markdown', 'text'])
