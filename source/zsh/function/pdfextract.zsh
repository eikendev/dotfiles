# Extract a part of a pdf file.
function pdfextract {
	if [ $# -ne 4 ]; then
		echo "Usage: $0 <first_page> <last_page> <input_file> <output_file>" >&2
		return 1
	fi

	local first_page="$1"
	local last_page="$2"
	local output_file="$3"
	local input_file="$4"

	if ! [ -f "$input_file" ] ; then
		echo "Input file does not exist." >&2
		return 1
	fi

	gs -sDEVICE=pdfwrite \
		-dNOPAUSE \
		-dBATCH \
		-dQUIET \
		-dSAFER \
		-dFirstPage="$first_page" \
		-dLastPage="$last_page" \
		-sOutputFile="$output_file" \
		"$input_file"
}
