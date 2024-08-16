function ffgb -d "Interactive Git branch checkout using fzf"
	set -l select (git branch --sort=-authordate | fzf --query (commandline))

	if test -n "$select"
		set -l branch (string trim --left --chars='* ' "$select" | sed "s#remotes/[^/]*/##")
		git checkout "$branch"
	end

	commandline -f repaint
end
