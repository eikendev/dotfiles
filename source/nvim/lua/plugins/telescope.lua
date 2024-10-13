return {
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-tree/nvim-web-devicons'
		},
		opts = {
			defaults = {
				mappings = {
					i = {
						['<C-h>'] = false,  -- Multiplexer navigation rather than showing help
						['<C-k>'] = false,  -- Multiplexer navigation rather than scrolling preview window
						['<C-u>'] = false,  -- Clear the prompt rather than scroll the previewer
						['<M-j>'] = require('telescope.actions').move_selection_next,  -- Alt+j to move down
						['<M-k>'] = require('telescope.actions').move_selection_previous,  -- Alt+k to move up
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
		},
	},
}