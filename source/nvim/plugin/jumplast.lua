-- Return to the last known cursor position when a file is read, and center it.

vim.api.nvim_create_augroup('jumplast', { clear = true })

vim.api.nvim_create_autocmd('BufReadPost', {
	group = 'jumplast',
	pattern = '?*',
	callback = function(args)
		local bo = vim.bo[args.buf]

		if bo.buftype ~= '' or bo.filetype == 'diff' or bo.filetype == 'gitcommit' then
			return
		end

		local line = vim.api.nvim_buf_get_mark(args.buf, '"')[1]

		if line >= 1 and line <= vim.api.nvim_buf_line_count(args.buf) then
			vim.cmd([[normal! g`"zz]])
		end
	end,
})
