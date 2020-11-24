# Display an RFC from local storage.
function rfc {
	if [ $# -ne 1 ]; then
		printf "Usage: $0 <id>\n" >&2
		return 1
	fi

	local id="$1"
	local directory="$HOME/document/rfc"
	local file="$directory/$id.txt"

	if ! [ -f "$file" ] ; then
		printf -v file "$directory/%04d.txt" "$id"

		if ! [ -f "$file" ] ; then
			printf "RFC not found.\n" >&2
			return 1
		fi
	fi

	#printf "Now showing file '$file'\n"
	command "${PAGER:-less}" "$file"
}
