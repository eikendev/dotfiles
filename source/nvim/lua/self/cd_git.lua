-- Change the working directory to the git root of the current file.

local M = {}

function M.run(opts)
	opts = opts or {}

	local source = vim.api.nvim_buf_get_name(0)

	if source == '' then
		source = vim.uv.cwd()
	end

	local root = vim.fs.root(source, '.git')

	if root == nil then
		if not opts.silent then
			vim.notify('Could not find git root.', vim.log.levels.WARN)
		end

		return
	end

	vim.cmd.cd(root)

	if not opts.silent then
		vim.notify('Found git root: ' .. root)
	end
end

return M
