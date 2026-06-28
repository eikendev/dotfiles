return {
	{
		'nvim-telescope/telescope.nvim',
		cmd = 'Telescope',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-tree/nvim-web-devicons'
		},
		opts = function()
			local actions = require('telescope.actions')

			return {
			defaults = {
				mappings = {
					i = {
						['<C-h>'] = false,  -- Multiplexer navigation rather than showing help
						['<C-k>'] = false,  -- Multiplexer navigation rather than scrolling preview window
						['<C-u>'] = false,  -- Clear the prompt rather than scroll the previewer
						['<M-j>'] = actions.move_selection_next,      -- Move selection down
						['<M-k>'] = actions.move_selection_previous,  -- Move selection up
						['<Up>'] = false,
						['<Down>'] = false,
						['<Left>'] = false,
						['<Right>'] = false,
					},
					n = {
						['<Up>'] = false,
						['<Down>'] = false,
						['<Left>'] = false,
						['<Right>'] = false,
					},
				},
				preview = {
					filesize_limit = 10,  -- The maximum file size in MB attempted to be previewed
				},
				vimgrep_arguments = {
					'rg',
					'--color=never',
					'--no-heading',
					'--with-filename',
					'--line-number',
					'--column',
					'--smart-case',
					'--hidden',
					'--ignore',
					'--trim',
				},
			},
			pickers = {
				find_files = {
					find_command = {
						'fd',
						'--type',
						'f',
						'--strip-cwd-prefix',
					},
				},
			},
		}
		end,
	},
}
