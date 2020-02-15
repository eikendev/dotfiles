# Dump a binary file to hex.
function dumptohex {
	local file="$1"

	if ! [ -f "$file" ] ; then
		echo "Usage: $0 <file>" >&2
		return 1
	fi

	for i in $(objdump -d "$file" -M intel | grep "^ " | cut -f2); do
		echo -n '\\x'$i
	done
}
