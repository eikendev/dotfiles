local M = {}

-- Reduce "...: Vim(write):E45: ..." or "...: Vim:E492: ..." from pcall to
-- the bare Vim message.
local function clean_error(err)
	err = tostring(err)

	return err:match('Vim%b():%s*(.*)$') or err:match('Vim:%s*(.*)$') or err
end

-- Run an Ex command, reporting failure as a warning instead of raising.
function M.run(cmd)
	local ok, err = pcall(vim.cmd, cmd)

	if not ok then
		vim.notify(clean_error(err), vim.log.levels.WARN)
	end

	return ok
end

return M
