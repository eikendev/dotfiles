return {
	{
		'joshdick/onedark.vim',
		init = function()
			vim.g.onedark_terminal_italics = 1
		end,
		config = function()
			vim.cmd.colorscheme('onedark')
		end
	},

	{ 'tpope/vim-repeat' },

	{ 'kana/vim-textobj-user' },

	{
		'kana/vim-textobj-line',
		dependencies = {
			'kana/vim-textobj-user',
		},
	},

	{
		'eikendev/vim-textobj-names',
		dependencies = {
			'kana/vim-textobj-user',
		},
	},

	{
		'easymotion/vim-easymotion',
		init = function()
			vim.g.EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz0123456789'
			vim.g.EasyMotion_smartcase = 1
			vim.g.EasyMotion_verbose = 0
		end
	},

	{
		'christoomey/vim-tmux-navigator',
		init = function()
			vim.g.tmux_navigator_no_mappings = 1
			vim.g.tmux_navigator_disable_when_zoomed = 1
		end
	},

	{
		'vim-airline/vim-airline',
		init = function()
			vim.g.airline_symbols_ascii = 1
			vim.g.airline_exclude_preview = 1
			vim.g.airline_section_z = '%{self#util#number_of_buffers()}B %3p%% %5l/%L %2c'
		end
	},

	{
		'airblade/vim-gitgutter',
		init = function()
			vim.g.gitgutter_map_keys = 0
			vim.g.gitgutter_max_sign = 256
			vim.g.gitgutter_sign_added = '●'
			vim.g.gitgutter_sign_modified = '●'
			vim.g.gitgutter_sign_removed = '●'
			vim.g.gitgutter_sign_removed_first_line = '▔'
			vim.g.gitgutter_sign_modified_removed = '▁'
		end
	},

	{ 'tpope/vim-eunuch' },

	{
		'scrooloose/nerdcommenter',
		init = function()
			vim.g.NERDAltDelims_c = 1
		end
	},

	{
		'tpope/vim-surround',
		init = function()
			vim.g.surround_no_mappings = 1
		end
	},

	{ 'junegunn/vim-easy-align' },

	{
		'cohama/lexima.vim',
		init = function()
			vim.g.lexima_no_default_rules = 1
			vim.g.lexima_map_escape = ''
			vim.g.lexima_enable_endwise_rules = 0
		end
	},

	{ 'Shougo/denite.nvim' },

	{ 'eikendev/denite-fzf' },

	{ 'eikendev/denite-man' },

	{ 'editorconfig/editorconfig-vim' },

	{
		'preservim/vim-markdown',
		ft = 'markdown',
		init = function()
			vim.g.vim_markdown_folding_disabled = 1
			vim.g.vim_markdown_math = 1
			vim.g.vim_markdown_toml_frontmatter = 1
		end
	},
}
