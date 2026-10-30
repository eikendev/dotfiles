-- Highlight trailing whitespace per window and offer a command to erase it.

local PATTERN = [[\s\+$]]
-- While typing, leave the whitespace right before the cursor alone.
local INSERT_PATTERN = [[\s\+\%#\@<!$]]

local ignored_filetypes = { lazy = true, TelescopePrompt = true }

local function set_highlight()
	vim.api.nvim_set_hl(0, 'BadWhitespace', { bg = 'red', ctermbg = 'red', default = true })
end

-- Whether a buffer wants the highlight: an explicit toggle wins, otherwise
-- modifiable buffers outside the ignored filetypes do.
local function wanted(buf)
	local forced = vim.b[buf].bad_whitespace_show

	if forced ~= nil then
		return forced
	end

	return vim.bo[buf].modifiable and not ignored_filetypes[vim.bo[buf].filetype]
end

local function clear(win)
	local id = vim.w[win].bad_whitespace_match

	if id ~= nil then
		pcall(vim.fn.matchdelete, id, win)
		vim.w[win].bad_whitespace_match = nil
	end
end

local function refresh(win, pattern)
	clear(win)

	if wanted(vim.api.nvim_win_get_buf(win)) then
		vim.w[win].bad_whitespace_match = vim.fn.matchadd('BadWhitespace', pattern or PATTERN, 10, -1, { window = win })
	end
end

local function refresh_buffer(buf)
	for _, win in ipairs(vim.fn.win_findbuf(buf)) do
		refresh(win)
	end
end

local function set_forced(show)
	local buf = vim.api.nvim_get_current_buf()

	vim.b[buf].bad_whitespace_show = show
	refresh_buffer(buf)
end

local group = vim.api.nvim_create_augroup('self_bad_whitespace', { clear = true })

vim.api.nvim_create_autocmd('ColorScheme', { group = group, callback = set_highlight })

vim.api.nvim_create_autocmd({ 'BufWinEnter', 'WinEnter', 'FileType' }, {
	group = group,
	callback = function(args) refresh_buffer(args.buf) end,
})

vim.api.nvim_create_autocmd('InsertEnter', {
	group = group,
	callback = function() refresh(vim.api.nvim_get_current_win(), INSERT_PATTERN) end,
})

vim.api.nvim_create_autocmd('InsertLeave', {
	group = group,
	callback = function() refresh(vim.api.nvim_get_current_win()) end,
})

set_highlight()

local command = vim.api.nvim_create_user_command

command('ShowBadWhitespace', function() set_forced(true) end, {})
command('HideBadWhitespace', function() set_forced(false) end, {})
command('ToggleBadWhitespace', function() set_forced(not wanted(vim.api.nvim_get_current_buf())) end, {})

command('EraseBadWhitespace', function(opts)
	local view = vim.fn.winsaveview()

	vim.cmd(('silent! keeppatterns %d,%ds/\\s\\+$//e'):format(opts.line1, opts.line2))
	vim.fn.winrestview(view)
end, { range = '%', desc = 'Remove trailing whitespace in the range' })
