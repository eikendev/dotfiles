# Fish scans $XDG_DATA_DIRS for vendor dirs before conf.d runs, so the Nix
# profile is registered by hand.
set -l nix_fish_share "$XDG_STATE_HOME/nix/profile/share/fish"

if test -d "$nix_fish_share"
	set -a fish_function_path "$nix_fish_share/vendor_functions.d"
	set -a fish_complete_path "$nix_fish_share/vendor_completions.d"

	for file in "$nix_fish_share"/vendor_conf.d/*.fish
		source "$file"
	end
end
