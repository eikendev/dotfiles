# Display the public IP address of the current host.
function getip {
	printf 'IPv4: '
	curl -s -4 -A '' 'https://ifconfig.co/ip' 2>/dev/null || echo - '-'

	printf 'IPv6: '
	curl -s -6 -A '' 'https://ifconfig.co/ip' 2>/dev/null || echo - '-'
}
