# Convert a PDF to a document that appears scanned.
# https://gist.github.com/andyrbell/25c8632e15d17c83a54602f6acde2724
function pdf2scan {
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
	directory="$(mktemp -d)"

	convert -density 300 "$input_file" -alpha remove -rotate 0.19 -attenuate 0.15 +noise Multiplicative +repage -monochrome -compress group4 -resize 50% "$directory/tmp.jpg"

	convert "$directory/tmp.jpg" -resize 200% -attenuate 0.35 +noise Laplacian -density 300 -sharpen 0x2.5 "$input_file.scan.pdf"

	rm -rf "$directory"
}
