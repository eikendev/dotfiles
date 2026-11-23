function claude-as -d "Run Claude Code with the given profile, or list the profiles"
	set -l root "$XDG_CONFIG_HOME/claude"

	if test (count $argv) -eq 0
		# Skips a shared skills link next to the profiles.
		for directory in $root/*/
			test -L (string trim -r -c / $directory); or path basename $directory
		end
		return
	end

	set -l profile $argv[1]
	set -e argv[1]

	# Rejects flags like -h, which would otherwise become a profile.
	if not string match -qr '^[A-Za-z0-9][A-Za-z0-9_-]*$' -- "$profile"
		printf "Usage: claude-as [<profile> [<args>...]]\n" >&2
		return 1
	end

	set -l directory "$root/$profile"

	# A link like the shared skills would point the config dir elsewhere.
	if test -L "$directory"
		printf "Profile '%s' is a link, not a profile.\n" "$profile" >&2
		return 1
	end

	# Profiles share the settings.json linked by modules/files.nix, and the
	# skills if something else links them next to it.
	if not test -d "$directory"
		printf "Creating profile '%s'.\n" "$profile" >&2
		mkdir -p "$directory"; or return 1
		ln -s ../settings.json "$directory/settings.json"; or return 1
		if test -e "$root/skills"
			ln -s ../skills "$directory/skills"; or return 1
		end
	end

	# Exported credentials would override the login of the profile.
	env -u ANTHROPIC_API_KEY -u CLAUDE_CODE_OAUTH_TOKEN CLAUDE_CONFIG_DIR="$directory" claude $argv
end
