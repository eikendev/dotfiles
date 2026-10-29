return {
	{
		'kylechui/nvim-surround',
		init = function()
			-- Mappings are defined in plugin/mapping/editing.vim.
			vim.g.nvim_surround_no_mappings = true
		end,
		opts = {
			-- Keep the cursor on the same character instead of jumping to the start
			move_cursor = 'sticky',
		},
	},
}
