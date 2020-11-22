# Convert a PDF to a minimal SVG.
function pdf2svg {
	if [ $# -ne 1 ]; then
		printf "Usage: $0 <input_file>\n" >&2
		return 1
	fi

	local input_file="$1"

	if ! [ -f "$input_file" ] ; then
		printf "%s\n" 'Input file does not exist.' >&2
		return 1
	fi

	local directory
	directory=$(mktemp -d)

	local plainsvg
	plainsvg="$directory/out.svg"

	inkscape \
		--export-plain-svg \
		--export-filename "$plainsvg" \
		"$input_file"

	svgminimize "$plainsvg"

	rm -rf "$directory"
}
