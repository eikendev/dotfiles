# Generate a passphrase from a list of words.
function genphrase {
	if [ $# -ne 2 ]; then
		printf "Usage: $0 <file> <count>\n" >&2
		return 1
	fi

	local file="$1"
	local count="$2"

	if ! [ -f "$file" ] ; then
		printf "File does not exist.\n" >&2
		return 1
	fi

	phrase="$(shuf --random-source=/dev/urandom --repeat --head-count="$count" "$file" | tr '\n' '-')"

	# Remove trailing whitespace.
	phrase="${phrase%%-}"

	printf "$phrase\n"
}
