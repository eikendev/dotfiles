set -g fish_greeting
set -g fish_color_command blue

# Zellij settings
set -gx ZELLIJ_AUTO_EXIT true

# Interactive-only behavior
if status is-interactive
	fish_vi_key_bindings

	# Show the vi mode at the cursor.
	set -g fish_cursor_default block
	set -g fish_cursor_insert line
	set -g fish_cursor_replace_one underscore
	set -g fish_cursor_visual block

	if test -n "$TERM"; and tty >/dev/null 2>&1
		if type -q starship
			starship init fish | source
		end

		if type -q jj
			jj util completion fish | source
		end

		if type -q zellij
			eval (zellij setup --generate-auto-start fish | string collect)
		end
	end
end
