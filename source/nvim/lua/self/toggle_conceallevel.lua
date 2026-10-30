local M = {}

function M.toggle()
	vim.wo.conceallevel = vim.wo.conceallevel == 0 and 2 or 0
	vim.cmd('setlocal conceallevel?')
end

return M
