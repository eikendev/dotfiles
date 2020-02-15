let g:dasht_filetype_docsets = {}

" When in Elixir, also search Erlang.
let g:dasht_filetype_docsets['elixir'] = ['erlang']

" When in C++, also search C, Boost, and OpenGL.
let g:dasht_filetype_docsets['cpp'] = ['^c$', 'boost', 'OpenGL']

" When in Python, also search NumPy, SciPy, and Pandas.
let g:dasht_filetype_docsets['python'] = ['(num|sci)py', 'pandas']

" When in HTML, also search CSS, JavaScript, Bootstrap, and jQuery.
let g:dasht_filetype_docsets['html'] = ['css', 'js', 'bootstrap']
