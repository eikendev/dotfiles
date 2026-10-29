-- Enable treesitter highlighting and folding per buffer, installing the parser
-- on first use. Buffers without an available parser keep regex highlighting
-- and syntax folding.

local function attach(buf, lang)
	if not vim.api.nvim_buf_is_valid(buf) then
		return
	end

	if not pcall(vim.treesitter.start, buf, lang) then
		return
	end

	-- vim.wo only accepts buffer 0, meaning the buffer shown in that window.
	for _, win in ipairs(vim.fn.win_findbuf(buf)) do
		vim.wo[win][0].foldmethod = 'expr'
		vim.wo[win][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
	end
end

vim.api.nvim_create_augroup('treesitter_attach', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
	group = 'treesitter_attach',
	pattern = '*',
	callback = function(args)
		local buf = args.buf
		local lang = vim.treesitter.language.get_lang(args.match)

		if lang == nil then
			return
		end

		-- Parser already present, either bundled with Neovim or installed earlier.
		if vim.treesitter.language.add(lang) then
			attach(buf, lang)
			return
		end

		local ok, ts = pcall(require, 'nvim-treesitter')
		if not ok or not vim.tbl_contains(ts.get_available(), lang) then
			return
		end

		ts.install({ lang }):await(function(err)
			if err == nil then
				vim.schedule(function() attach(buf, lang) end)
			end
		end)
	end,
})
