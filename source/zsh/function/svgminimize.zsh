# Minimize the file size of an SVG image.
function svgminimize {
	if [ $# -ne 1 ]; then
		echo "Usage: $0 <file>" >&2
		return 1
	fi

	local file="$1"

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
		"$file"
}
