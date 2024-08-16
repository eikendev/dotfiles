function ffm -d "Search and open a manual page interactively with fzf"
	man -k . | fzf -1 -0 -m --height=22 | awk '{print $1}' | xargs -r man
end
