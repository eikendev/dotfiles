# Set the working directory to the directory we left nnn in.
# See https://github.com/jarun/nnn/blob/master/misc/quitcd/quitcd.bash_zsh.
function nnn-cd {
	# Block nesting of nnn in subshells.
	if [ -n "$NNNLVL" ] && [ "${NNNLVL:-0}" -ge 1 ]; then
		printf "%s\n" 'nnn is already running!'
		return
	fi

	export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

	nnn "$@"

	if [ -f "$NNN_TMPFILE" ]; then
		. "$NNN_TMPFILE"
		rm -f "$NNN_TMPFILE" > /dev/null
	fi
}
