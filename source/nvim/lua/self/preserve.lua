-- Run commands without moving the cursor, the view or the search pattern.

local run = require('self.util').run

local M = {}

function M.execute(command)
	local view = vim.fn.winsaveview()
	local search = vim.fn.getreg('/', 1)

	run('keepjumps ' .. command)

	vim.fn.winrestview(view)
	vim.fn.setreg('/', search)
end

function M.normal(command)
	M.execute('normal! ' .. command)
end

return M
