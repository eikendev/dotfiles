# Display a stopwatch. See [0].
# [0] https://superuser.com/a/611582
function stopwatch {
	local startdate days

	startdate="$(date +%s)"

	while true; do
		days="$(( $(($(date +%s) - startdate)) / 86400 ))"
		echo -ne "\r$days day(s) and $(date -u --date @$((`date +%s` - $startdate)) +%H:%M:%S)"
		sleep 0.1
	done
}
