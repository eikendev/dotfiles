function ffgb -d "Interactive Git branch checkout using fzf"
	# Local and remote branches by their local name, newest first. Switching
	# to a remote-only one creates its tracking branch.
	set -l format '%(if:equals=refs/remotes)%(refname:rstrip=-2)%(then)%(refname:lstrip=3)%(else)%(refname:lstrip=2)%(end)'
	set -l branch (git for-each-ref --sort=-authordate --format=$format refs/heads refs/remotes \
		| string match -v HEAD \
		| awk '!seen[$0]++' \
		| fzf --query (commandline))

	if test -n "$branch"
		git switch "$branch"
	end

	commandline -f repaint
end
