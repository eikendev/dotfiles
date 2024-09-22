return {
	{
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
		opts = {
			disable_filetype = { "TelescopePrompt", "spectre_panel" },
			ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
			enable_afterquote = false,  -- allows bracket pairs to be automatically added after a quote
			enable_check_bracket_line = true,  -- ensures that opening and closing brackets are inserted on the same line
			enable_bracket_in_quote = true, -- allows bracket pairs to be auto-completed inside quotes
		},
	}
}
