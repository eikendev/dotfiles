return {
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
}
