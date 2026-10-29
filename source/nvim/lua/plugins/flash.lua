return {
	{
		'folke/flash.nvim',
		opts = {
			-- Lowercase letters and digits only, matching the former EasyMotion keys
			labels = 'abcdefghijklmnopqrstuvwxyz0123456789',
			label = {
				uppercase = false,
			},
			modes = {
				-- Label f/F/t/T targets, but leave ; and , alone since ; toggles semicolons
				char = {
					keys = { 'f', 'F', 't', 'T' },
					jump_labels = true,
				},
			},
		},
	},
}
