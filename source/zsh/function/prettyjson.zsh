# Prettify json file using python.
function prettyjson {
	local file="$1"

	if ! [ -f "$file" ] ; then
		echo "Usage: $0 <file>" >&2
		return 1
	fi

	if ! [ -x "$(command -v python3)" ]; then
		echo 'Python3 is not installed.' >&2
		return 1
	fi

	python3 -m json.tool "$file"
}
