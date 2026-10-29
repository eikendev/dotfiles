local set = vim.keymap.set

-- Requires are deferred into the callbacks so the mappings exist even before gitsigns loads.

-- Manage hunks.
set('n', '<Leader>hh', function() require('gitsigns').preview_hunk() end, { desc = 'Preview the hunk under the cursor' })
set('n', '<Leader>hs', function() require('gitsigns').stage_hunk() end, { desc = 'Stage the hunk under the cursor' })
set('x', '<Leader>hs', function()
	require('gitsigns').stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
end, { desc = 'Stage the selected lines' })
set('n', '<Leader>hu', function() require('gitsigns').reset_hunk() end, { desc = 'Revert the hunk under the cursor' })

-- Move to next or previous hunk, wrapping around the buffer.
set('n', '[h', function() require('gitsigns').nav_hunk('prev', { wrap = true }) end, { desc = 'Jump to the previous hunk' })
set('n', ']h', function() require('gitsigns').nav_hunk('next', { wrap = true }) end, { desc = 'Jump to the next hunk' })

-- Hunk text objects.
set({ 'o', 'x' }, 'ih', function() require('gitsigns').select_hunk() end, { desc = 'Select the hunk under the cursor' })
set({ 'o', 'x' }, 'ah', function() require('gitsigns').select_hunk() end, { desc = 'Select the hunk under the cursor' })
