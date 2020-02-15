" https://github.com/cohama/lexima.vim/issues/65
call lexima#set_default_rules()
call lexima#insmode#map_hook('before', '<CR>', '')

" Do not automatically pair when the cursor is in front of a normal character.
call lexima#add_rule({'char': '(', 'at': '\%#\w', 'priority': 1000})
call lexima#add_rule({'char': '(', 'at': '\%#\W', 'except': ' \%#\W', 'priority': 1000})
call lexima#add_rule({'char': '[', 'at': '\%#\w', 'priority': 1000})
call lexima#add_rule({'char': '[', 'at': '\%#\W', 'except': ' \%#\W', 'priority': 1000})
call lexima#add_rule({'char': '{', 'at': '\%#\w', 'priority': 1000})
call lexima#add_rule({'char': '{', 'at': '\%#\W', 'except': ' \%#\W', 'priority': 1000})
call lexima#add_rule({'char': '"', 'at': '\%#\w', 'priority': 1000})
call lexima#add_rule({'char': '"', 'at': '\%#\W', 'except': ' \%#\W', 'priority': 1000})
call lexima#add_rule({'char': "'", 'at': '\%#\w', 'priority': 1000})
call lexima#add_rule({'char': "'", 'at': '\%#\W', 'except': ' \%#\W', 'priority': 1000})
