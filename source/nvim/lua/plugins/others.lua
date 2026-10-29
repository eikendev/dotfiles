return {
	{ 'tpope/vim-eunuch' },

	{ 'tpope/vim-repeat' },

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
}
