local builtins = {
	'2html_plugin',
	'getscript',
	'getscriptPlugin',
	'gzip',
	'logiPat',
	'netrw',
	'netrwFileHandlers',
	'netrwSettings',
	'rrhelper',
	'ruby_provider',
	'shada_plugin',
	'spellfile_plugin',
	'tar',
	'tarPlugin',
	'tutor_mode_plugin',
	'vimball',
	'vimballPlugin',
	'zip',
	'zipPlugin',
}

for _, plugin in ipairs(builtins) do
	vim.g['loaded_' .. plugin] = 1
end
