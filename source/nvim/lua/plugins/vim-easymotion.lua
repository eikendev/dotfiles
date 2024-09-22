return {
	{
		'easymotion/vim-easymotion',
		init = function()
			vim.g.EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz0123456789'
			vim.g.EasyMotion_smartcase = 1
			vim.g.EasyMotion_verbose = 0
		end
	},
}
