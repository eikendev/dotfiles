# Print packages installed by user.
# This requires dnf-leaves to be installed.
function userinstalled {
	local hist
	local leaves

	hist=`sudo dnf history userinstalled | sort`
	leaves=`dnf leaves | sort`

	comm -12 <(echo "$hist") <(echo "$leaves") | awk -F '-[0-9]' '{print $1}'
}
