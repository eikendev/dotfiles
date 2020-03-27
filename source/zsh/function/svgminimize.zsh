# Minimize the file size of an SVG image.
function svgminimize {
	if [ $# -ne 1 ]; then
		echo "Usage: $0 <input_file>" >&2
		return 1
	fi

	local input_file="$1"

	if ! [ -f "$input_file" ] ; then
		echo "Input file does not exist." >&2
		return 1
	fi

	scour \
		--set-precision=5 \
		--create-groups \
		--strip-xml-prolog \
		--remove-descriptive-elements \
		--enable-comment-stripping \
		--disable-embed-rasters \
		--enable-viewboxing \
		--indent=none \
		--no-line-breaks \
		--enable-id-stripping \
		--shorten-ids \
		"$input_file"
}
