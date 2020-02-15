# Replace trailing whitespace in all files of a directory.
function remove-whitespace {
	if [ $# -ne 1 ]; then
		echo "Usage: $0 <pattern>" >&2
		return 1
	fi

	local pattern="$1"
	find . -type f -iname "$pattern" -exec sed -i 's/[[:space:]]*$//' '{}' +;
}
