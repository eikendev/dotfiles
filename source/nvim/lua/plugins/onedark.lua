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
}
