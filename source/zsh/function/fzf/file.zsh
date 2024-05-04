# Open files.
function fff {
	local files

	files=($(fd "$1" --type f --no-ignore --hidden --follow --exclude '.git/' | fzf --query="$1" --height=22 -m -0))
	[[ -n "$files" ]] && ${EDITOR:-vi} "${files[@]}"
}

# Open a file with particular content.
# https://news.ycombinator.com/item?id=38474106
function ffg {
	local result
	local file
	local line

	if [ ! "$#" -gt 0 ]; then
		echo "Usage: $0 <pattern>" >&2
		return 1;
	fi

	result=$(rg --smart-case --color=always --line-number --no-heading "$@" |
		fzf --ansi \
		--color 'hl:-1:underline,hl+:-1:underline:reverse' \
		--delimiter ':' \
		--preview "bat --color=always {1} --highlight-line {2}" \
		--preview-window 'border-left,+{2}+3/3,~3')
	file=${result%%:*}
	line=${result#*:}
	line=${line%%:*}

	if [[ -n "$file" ]]; then
		$EDITOR +"${line}" "$file"
	fi
}

# Open files with a todo in them.
function fft() {
	ffg 'TODO' '-w'
}

