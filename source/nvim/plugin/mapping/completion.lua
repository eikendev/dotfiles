local set = vim.keymap.set

-- Confirm the selected completion, otherwise break the undo chain and let
-- nvim-autopairs handle the newline. Its own <CR> mapping is disabled in
-- lua/plugins/nvim-autopairs.lua, so the two do not compete.
set('i', '<CR>', function()
	if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
		return vim.keycode('<C-y>')
	end

	return vim.keycode('<C-g>u') .. require('nvim-autopairs').autopairs_cr()
end, { expr = true, replace_keycodes = false })

-- Toggle the completion menu.
set('i', '<A-CR>', function()
	return vim.fn.pumvisible() == 1 and '<C-e>' or '<C-n>'
end, { expr = true })

-- Navigate the completion menu with Tab.
set('i', '<Tab>', function()
	return vim.fn.pumvisible() == 1 and '<C-n>' or '<Tab>'
end, { expr = true })

set('i', '<S-Tab>', function()
	return vim.fn.pumvisible() == 1 and '<C-p>' or '<C-h>'
end, { expr = true })
