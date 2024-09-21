-- Set default colorscheme to koehler
-- This may be overridden later after loading plugins
vim.cmd.colorscheme('koehler')

-- Enable filetype detection, plugin, and indent
-- https://vi.stackexchange.com/a/10125
vim.cmd('filetype plugin indent on')

-- Enable syntax highlighting
vim.cmd('syntax on')

-- Set background color only in non-GUI modes
if vim.fn.has('autocmd') == 1 and vim.fn.has('gui') == 0 then
	local white = { gui = '#ABB2BF', cterm = '145', cterm16 = '7' }

	-- Create an augroup for the color scheme
	vim.api.nvim_create_augroup('init_scheme', { clear = true })

	-- Create an autocommand to set highlight for 'Normal' when ColorScheme is set
	vim.api.nvim_create_autocmd('ColorScheme', {
		group = 'init_scheme',
		pattern = '*',
		callback = function()
			vim.api.nvim_set_hl(0, 'Normal', { fg = white.gui })
		end,
	})
end

-- Define leader keys
-- Must be set before loading any plugins
local g = vim.g
g.mapleader = ','
g.maplocalleader = ','

-- Initialize plugins
require("config.lazy")
