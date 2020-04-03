# Replace string in all files of a directory.
function replace-string {
	if [ $# -ne 3 ]; then
		printf "Usage: $0 <pattern> <string_old> <string_new>\n" >&2
		return 1
	fi

	local pattern="$1"
	local string_old="$2"
	local string_new="$3"

	# NOTE: https://superuser.com/a/556006
	read "answer?Replace '$string_old' with '$string_new'? [y/N] "
	if [[ "$answer" =~ ^[Yy]$ ]]; then
		find . -type f -iname "$pattern" -exec sed -i "s#$string_old#$string_new#g" '{}' +;
	fi
}
