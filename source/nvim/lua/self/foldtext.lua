-- Text shown on a closed fold: »··[12 lines]····first line of the fold.

local M = {}

function M.text()
	local first = vim.fn.getline(vim.v.foldstart):gsub('^%s+', '')
	local count = vim.v.foldend - vim.v.foldstart + 1
	local dashes = vim.v.folddashes:gsub('-', '·')

	return ('»··[%d lines]%s%s'):format(count, dashes, first)
end

return M
