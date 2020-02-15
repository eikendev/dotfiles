# Open files.
function fff {
	local files

	files=($(fd "$1" --type f --no-ignore --hidden --follow --exclude '.git/' | fzf --query="$1" --height=22 -m -0))
	[[ -n "$files" ]] && ${EDITOR:-vi} "${files[@]}"
}

# Open files with particular content.
function ffg() {
	local files

	if [ ! "$#" -gt 0 ]; then
		echo "Usage: $0 <pattern> [mode]" >&2
		return 1;
	fi

	files=($(rg --files-with-matches --no-messages --smart-case $2 "$1" | fzf -m -0 --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --smart-case --pretty --context 10 $1 || rg --smart-case --pretty --context 10 $1 {}"))
	[[ -n "$files" ]] && ${EDITOR:-vi} "${files[@]}"
}

# Open files with a todo in them.
function fft() {
	ffg 'TODO' '-w'
}
