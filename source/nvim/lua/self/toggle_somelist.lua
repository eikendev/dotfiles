-- Toggle the quickfix window or the location list of the current window.

local run = require('self.util').run

local M = {}

local lists = {
	quickfix = {
		is_open = function() return vim.fn.getqflist({ winid = 1 }).winid ~= 0 end,
		open = 'copen',
		close = 'cclose',
	},
	location = {
		is_open = function() return vim.fn.getloclist(0, { winid = 1 }).winid ~= 0 end,
		open = 'lopen',
		close = 'lclose',
	},
}

function M.toggle(name)
	local list = lists[name]

	if list == nil then
		vim.notify('Unknown list: ' .. tostring(name), vim.log.levels.ERROR)
		return
	end

	-- :lopen fails with E776 when the window has no location list yet.
	run(list.is_open() and list.close or list.open)
end

return M
