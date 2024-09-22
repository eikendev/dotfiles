return {
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
