# Set the working directory to the directory we left ranger in.
function ranger-cd {
	local file

	file="$(mktemp -t tmp.XXXXXX)"
	/usr/bin/ranger --choosedir="$file" "${@:-$(pwd)}"

	test -f "$file" &&
	if [ "$(cat -- "$file")" != "$(echo -n `pwd`)" ]; then
		cd -- "$(cat "$file")"
	fi

	rm -f -- "$file"
}
