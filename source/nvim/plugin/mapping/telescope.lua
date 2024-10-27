local set = vim.keymap.set

local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local utils = require('telescope.utils')

set('i', '<M-j>', function()
  local prompt_bufnr = vim.api.nvim_get_current_buf()
  actions.move_selection_next(prompt_bufnr)
end, { desc = 'Move selection down in Telescope' })

set('i', '<M-k>', function()
  local prompt_bufnr = vim.api.nvim_get_current_buf()
  actions.move_selection_previous(prompt_bufnr)
end, { desc = 'Move selection up in Telescope' })

set('n', '<f1>', builtin.help_tags, { desc = 'Lists available help tags' })
set('n', '<leader><leader>', builtin.buffers, { desc = 'Lists open buffers in current neovim instance' })
set('n', '<leader>dc', builtin.commands, { desc = 'Lists available plugin/user commands and runs them' })
set('n', '<leader>dh', builtin.command_history, { desc = 'Lists commands that were executed recently' })
set('n', '<leader>dj', builtin.jumplist, { desc = 'Lists Jump List entries' })
set('n', '<leader>dm', builtin.man_pages, { desc = 'Lists manpage entries, opens them in a help window' })
set('n', '<leader>dM', builtin.marks, { desc = 'Lists vim marks and their value' })
set('n', '<leader>dr', builtin.registers, { desc = 'Lists vim registers, pastes the contents of the register' })
set('n', '<leader>ds', builtin.spell_suggest, { desc = 'Lists spelling suggestions for the current word under the cursor' })

set('n', '<leader>df', function()
	local is_git_repo = utils.get_os_command_output({ 'git', 'rev-parse', '--is-inside-work-tree' })[1] == 'true'

	if is_git_repo then
		builtin.git_files()
	else
		builtin.find_files()
	end
end, { desc = 'Lists files or git files if inside a git repository' })

set('n', '<leader>dd', function()
	local git_dir = vim.fn.system('git -C ' .. vim.fn.expand('%:p:h') .. ' rev-parse --show-toplevel')

	-- Check if we're actually inside a Git repository (successful command)
	if vim.v.shell_error == 0 then
		git_dir = vim.fn.trim(git_dir)
		builtin.live_grep({ cwd = git_dir })
	else
		builtin.live_grep()
	end
end, { desc = 'Git-aware live search or fallback to current directory' })

set('x', '<leader>dd', function()
	local git_dir = vim.fn.system('git -C ' .. vim.fn.expand('%:p:h') .. ' rev-parse --show-toplevel')

	-- Check if we're actually inside a Git repository (successful command)
	if vim.v.shell_error == 0 then
		git_dir = vim.fn.trim(git_dir)
		builtin.grep_string({ cwd = git_dir })
	else
		builtin.grep_string()
	end
end, { desc = 'Git-aware search for the selected string, or fallback to current directory' })
