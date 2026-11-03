function getip -d 'Display the public IPv4 and IPv6 address of the current host'
	for version in 4 6
		set -l address (curl -s -$version 'https://ifconfig.co/ip' 2>/dev/null)
		test -n "$address"; or set address '-'
		printf 'IPv%s: %s\n' $version $address
	end
end
