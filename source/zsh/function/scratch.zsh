# Spawn a subshell for temporary usage.
function scratch {
	local directory

	directory=$(mktemp -d)

	echo "Spawing subshell in '$directory'."

	(cd $directory; $SHELL)

	echo 'Removing scratch directory.'
	rm -r "$directory"
}
