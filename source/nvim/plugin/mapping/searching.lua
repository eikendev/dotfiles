local set = vim.keymap.set

-- Do not jump when searching for the word under the cursor.
set('n', '*', 'm`:keepjumps normal! *``<CR>', { silent = true })

-- Enable jumping back after a search.
set('n', 'n', ':keepjumps normal! n<CR>', { silent = true })

-- Jump to the tag under the cursor.
set('n', '<Leader>jt', '<C-]>', { silent = true })

-- Search for the selection literally, staying on it instead of jumping to
-- the next match like the built-in |v_star-default| does.
set('x', '*', function()
	local chunks = vim.fn.getregion(vim.fn.getpos('.'), vim.fn.getpos('v'), { type = vim.fn.mode() })
	local escaped = vim.tbl_map(function(chunk) return vim.fn.escape(chunk, [[\]]) end, chunks)
	local pattern = [[\V]] .. table.concat(escaped, [[\n]])

	vim.fn.setreg('/', pattern)
	vim.fn.histadd('/', pattern)
	vim.v.searchforward = 1
	vim.v.hlsearch = 1

	return '<Esc>`<'
end, { expr = true, desc = 'Search for the selection without jumping' })
