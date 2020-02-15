# Show services corresponding to given port.
function services {
	if [ $# -ne 1 ]; then
		echo "Usage: $0 <port>" >&2
		return 1
	fi

	local port="$1"
	local services_file="/etc/services"

	grep " $port/" "$services_file"
}
