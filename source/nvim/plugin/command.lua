local command = vim.api.nvim_create_user_command

command('VimEdit', 'edit $MYVIMRC', {})
command('VimSource', 'source $MYVIMRC', {})

command('CdGit', function() require('self.cd_git').run() end, { bar = true })
command('CdFile', 'cd %:p:h', {})

command('ToggleQuickfixList', function() require('self.toggle_somelist').toggle('quickfix') end, { bar = true })
command('ToggleLocationList', function() require('self.toggle_somelist').toggle('location') end, { bar = true })

command('ToggleConceallevel', function() require('self.toggle_conceallevel').toggle() end, { bar = true })

command('SmartClose', function() require('self.smart_close').close() end, { bar = true })

-- Toggle semicolon at the end of the line, repeatable with `.` through vim-repeat.
command('ToggleSemicolon', function()
	require('self.toggle_end_char').toggle(';', '<Plug>(self-toggle-semicolon)')
end, { bar = true })
vim.keymap.set('n', '<Plug>(self-toggle-semicolon)', '<Cmd>ToggleSemicolon<CR>', { silent = true })

command('PreserveNormal', function(opts) require('self.preserve').normal(opts.args) end, { nargs = 1 })
command('PreserveExecute', function(opts) require('self.preserve').execute(opts.args) end, { nargs = 1 })
