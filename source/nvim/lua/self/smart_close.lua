-- Close the current buffer, quitting Neovim when it is the last listed one.

local run = require('self.util').run

local M = {}

local function listed_buffer_count()
	return #vim.fn.getbufinfo({ buflisted = 1 })
end

-- Whether :write stands a chance for this buffer.
local function is_writable(buf)
	return vim.bo[buf].buftype == '' and vim.api.nvim_buf_get_name(buf) ~= ''
end

-- Ask what to do with unsaved changes. Returns 'save', 'discard' or nil.
local function ask(buf)
	if is_writable(buf) then
		local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ':~:.')
		local choice = vim.fn.confirm(('Save changes to "%s"?'):format(name), '&Save\n&Discard\n&Cancel', 3, 'Question')

		return ({ 'save', 'discard' })[choice]
	end

	local choice = vim.fn.confirm('Buffer has unsaved changes but cannot be written. Discard them?', '&Discard\n&Cancel', 2, 'Question')

	return choice == 1 and 'discard' or nil
end

function M.close()
	local buf = vim.api.nvim_get_current_buf()
	local bo = vim.bo[buf]

	-- Unlisted buffers (help, quickfix, floats, plugin UIs) are never the only
	-- thing open, so drop them without ceremony.
	if not bo.buflisted then
		run('bdelete!')
		return
	end

	local discard = false

	if bo.modified then
		local answer = ask(buf)

		if answer == nil then
			return
		end

		if answer == 'save' and not run('write') then
			return
		end

		discard = answer == 'discard'
	end

	if listed_buffer_count() == 1 then
		-- Closes the window, or Neovim when this is the last one. Only this
		-- buffer's changes are dropped; other modified buffers still block.
		if discard then
			bo.modified = false
		end

		if not run('quit') and discard then
			bo.modified = true
		end

		return
	end

	if bo.buftype == 'terminal' then
		-- Wipe terminals so they do not linger as unlisted buffers.
		run('bwipeout!')
	else
		run(discard and 'bdelete!' or 'bdelete')
	end
end

return M
