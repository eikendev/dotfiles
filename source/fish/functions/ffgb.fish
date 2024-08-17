function ffgb -d "Interactive Git branch checkout using fzf"
	set select (git branch --sort=-authordate | fzf --query (commandline))

	if test -n "$select"
		set branch (string trim --left --chars='* ' "$select" | sed "s#remotes/[^/]*/##")
		git checkout "$branch"
	end

	commandline -f repaint
end
