local set = vim.keymap.set
local modes = { 'n', 'x', 'o' }

-- Requires are deferred into the callbacks so flash only loads on first use.

-- Jump to a pattern typed interactively, labels appear as matches narrow down.
set(modes, '<Leader><Space>', function() require('flash').jump() end, { desc = 'Jump to a typed pattern' })

-- Label every match of a fixed pattern immediately, in one direction only.
local function jump_to(pattern, forward)
	return function()
		require('flash').jump({
			pattern = pattern,
			search = {
				mode = 'search',
				max_length = 0,
				forward = forward,
				wrap = false,
				multi_window = false,
			},
			label = { before = true, after = false },
		})
	end
end

-- Jump to the start of a word.
set(modes, '<Space>w', jump_to([[\<\k]], true), { desc = 'Jump to a word start after the cursor' })
set(modes, '<Space>b', jump_to([[\<\k]], false), { desc = 'Jump to a word start before the cursor' })

-- Jump to the start of a line.
set(modes, '<Space>j', jump_to([[^]], true), { desc = 'Jump to a line below the cursor' })
set(modes, '<Space>k', jump_to([[^]], false), { desc = 'Jump to a line above the cursor' })
