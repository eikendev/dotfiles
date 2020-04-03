# Spawn a subshell for temporary usage.
function scratch {
	local directory

	directory=$(mktemp -d)

	printf "Spawing subshell in '$directory'.\n"

	(cd $directory; $SHELL)

	printf "%s\n" 'Removing scratch directory.'
	rm -r "$directory"
}
