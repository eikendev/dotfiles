# Start a Docker container and attach.
function ffda() {
	local cid

	cid=$(sudo docker ps -a | sed 1d | fzf -1 -q "$1" | awk '{print $1}')
	[ -n "$cid" ] && sudo docker start "$cid" && sudo docker attach "$cid"
}

# Start a Docker container.
function ffds() {
	local cid

	cid=$(sudo docker ps -a | sed 1d | fzf -q "$1" | awk '{print $1}')
	[ -n "$cid" ] && sudo docker start "$cid"
}

# Stop (halt) a Docker container.
function ffdh() {
	local cid

	cid=$(sudo docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')
	[ -n "$cid" ] && sudo docker stop "$cid"
}

# Remove a docker container.
function ffdr() {
	local cid

	cid=$(sudo docker ps -a | sed 1d | fzf -q "$1" | awk '{print $1}')
	[ -n "$cid" ] && sudo docker rm "$cid"
}
