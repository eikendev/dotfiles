# Change the working directory downwards.
function ffd {
	local dir

	dir=($(fd "$1" --type d --no-ignore --hidden --follow --exclude '.git/' | fzf --query="$1" +m -0 --height=22))
	cd "$dir"
}

# Change the working directory upwards.
function ffu() {
	local declare directories=()
	local dir

	get_parent_directories() {
		if [[ -d "${1}" ]]; then
			directories+=("$1")
		else
			return
		fi

		if [[ "${1}" == '/' ]]; then
			for _dir in "${directories[@]}"; do echo $_dir; done
		else
			get_parent_directories $(dirname "$1")
		fi
	}

	dir=$(get_parent_directories $(realpath "${1:-$PWD}") | fzf +m --height=22) &&
	cd "$dir"
}

# Kill processes.
function ffk() {
	local pid

	if [ "$UID" != "0" ]; then
		pid=$(ps -f -u $UID | sed 1d | fzf -m --height=22 | awk '{print $2}')
	else
		pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
	fi

	if [ "x$pid" != "x" ]; then
		echo $pid | xargs kill -${1:-9}
	fi
}

# Open a manual page.
function ffm() {
	man -k . | fzf -1 -0 -m --height=22 | awk '{print $1}' | xargs -r man
}

# Repeat command history.
function ffh() {
	print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac --height=22 | sed -r 's/ *[0-9]*\*? *//' | sed -r 's/\\/\\\\/g')
}
