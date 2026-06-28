local set = vim.keymap.set

-- Requires are deferred into the callbacks so Telescope only loads on first use.
-- Selection movement (<M-j>/<M-k>) lives in the picker-local mappings in
-- lua/plugins/telescope.lua, not here, so it only fires inside a picker.

set('n', '<f1>', function() require('telescope.builtin').help_tags() end, { desc = 'Lists available help tags' })
set('n', '<leader><leader>', function() require('telescope.builtin').buffers() end, { desc = 'Lists open buffers in current neovim instance' })
set('n', '<leader>dc', function() require('telescope.builtin').commands() end, { desc = 'Lists available plugin/user commands and runs them' })
set('n', '<leader>dh', function() require('telescope.builtin').command_history() end, { desc = 'Lists commands that were executed recently' })
set('n', '<leader>dj', function() require('telescope.builtin').jumplist() end, { desc = 'Lists Jump List entries' })
set('n', '<leader>dm', function() require('telescope.builtin').man_pages() end, { desc = 'Lists manpage entries, opens them in a help window' })
set('n', '<leader>dM', function() require('telescope.builtin').marks() end, { desc = 'Lists vim marks and their value' })
set('n', '<leader>dr', function() require('telescope.builtin').registers() end, { desc = 'Lists vim registers, pastes the contents of the register' })
set('n', '<leader>ds', function() require('telescope.builtin').spell_suggest() end, { desc = 'Lists spelling suggestions for the current word under the cursor' })

set('n', '<leader>df', function()
	local utils = require('telescope.utils')
	local builtin = require('telescope.builtin')

	local is_git_repo = utils.get_os_command_output({ 'git', 'rev-parse', '--is-inside-work-tree' })[1] == 'true'

	if is_git_repo then
		builtin.git_files()
	else
		builtin.find_files()
	end
end, { desc = 'Lists files or git files if inside a git repository' })

-- Run a grep picker scoped to the git root, falling back to the current directory.
local function git_grep(picker)
	local utils = require('telescope.utils')
	local result, ret = utils.get_os_command_output({
		'git', '-C', vim.fn.expand('%:p:h'), 'rev-parse', '--show-toplevel',
	})

	if ret == 0 and result[1] ~= nil and result[1] ~= '' then
		picker({ cwd = result[1] })
	else
		picker()
	end
end

set('n', '<leader>dd', function()
	git_grep(require('telescope.builtin').live_grep)
end, { desc = 'Git-aware live search or fallback to current directory' })

set('x', '<leader>dd', function()
	git_grep(require('telescope.builtin').grep_string)
end, { desc = 'Git-aware search for the selected string, or fallback to current directory' })
