function getip -d 'Display the public IPv4 and IPv6 address of the current host'
	set ipv4 (curl -s -4 'https://ifconfig.co/ip' ^/dev/null)
	printf 'IPv4: %s\n' (test -n "$ipv4"; and printf "$ipv4"; or printf '-')

	set ipv6 (curl -s -6 'https://ifconfig.co/ip' ^/dev/null)
	printf 'IPv6: %s\n' (test -n "$ipv6"; and printf "$ipv6"; or printf '-')
end
