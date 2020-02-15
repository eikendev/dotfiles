# Check against the database of Have I Been Pwned.
function haveibeenpwned {
	if [ $# -ne 0 ]; then
		printf "Usage: $0\n" >&2
		return 1
	fi

	printf 'Enter the password: '
	local keyword
	read -s keyword
	printf "\n"

	local range=$(printf "$keyword" | sha1sum | cut -b 1-5)
	local response=$(curl -s -S "https://api.pwnedpasswords.com/range/$range" | grep -i $(printf "$keyword" | sha1sum | cut -b 6-40))

	if [ -z "$response" ]; then
		printf '%s\n' 'This password was not leaked before.'
	else
		printf '%s\n' 'This password is not safe.'
	fi
}
