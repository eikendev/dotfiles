# Checkout a Git branch, sorted by most recent commit.
function ffgb() {
	local branches
	local branch

	branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
	branch=$(echo "$branches" | fzf -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
	git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# Checkout a Git commit.
function ffgc() {
	local commits
	local commit

	commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
	commit=$(echo "$commits" | fzf --tac +s +m -e) &&
	git checkout $(echo "$commit" | sed "s/ .*//")
}
