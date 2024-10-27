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
						['<M-j>'] = false,  -- Disable as it is later remapped for moving selection down
						['<M-k>'] = false,  -- Disable as it is later remapped for moving selection up
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
		},
	},
}
