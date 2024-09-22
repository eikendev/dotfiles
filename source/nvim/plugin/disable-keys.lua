local keymap = vim.api.nvim_set_keymap

-- Disable arrow key movement
local opts = { noremap = true, silent = true }
keymap('n', '<Up>', '', opts)
keymap('i', '<Up>', '<ESC>', opts)
keymap('n', '<Down>', '', opts)
keymap('i', '<Down>', '<ESC>', opts)
keymap('n', '<Left>', '', opts)
keymap('i', '<Left>', '<ESC>', opts)
keymap('n', '<Right>', '', opts)
keymap('i', '<Right>', '<ESC>', opts)

-- Disable F1 key
-- keymap('n', '<F1>', '<nop>', opts)  -- Overwritten in telescope.lua
keymap('i', '<F1>', '<nop>', opts)
