function svgminimize -d "Minimize the file size of an SVG image using Scour."
	if test (count $argv) -ne 1
		printf "Usage: svgminimize <input_file>\n" >&2
		return 1
	end

	set input_file $argv[1]

	if not test -f "$input_file"
		printf "%s\n" 'Input file does not exist.' >&2
		return 1
	end

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
end
