local M = {}

-- Append `char` to the current line, or remove it when already there.
-- `repeat_plug` names the <Plug> mapping vim-repeat replays on `.`.
function M.toggle(char, repeat_plug)
	local line = vim.api.nvim_get_current_line()

	if vim.endswith(line, char) then
		line = line:sub(1, -#char - 1)
	else
		line = line .. char
	end

	vim.api.nvim_set_current_line(line)

	if repeat_plug ~= nil then
		pcall(vim.fn['repeat#set'], vim.keycode(repeat_plug))
	end
end

return M
