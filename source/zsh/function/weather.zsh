# Display the weather at a specific location.
function weather {
	local location="$1"

	curl -s -A "curl" "https://wttr.in/${location:-Zurich}?m0&lang=en"
}
