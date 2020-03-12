# Replace the name and the email of a Git author.
function git-replace-author {
	if [ $# -ne 3 ]; then
		echo "Usage: $0 <email_old> <name_new> <email_new>" >&2
		return 1
	fi

	local email_old="$1"
	local name_new="$2"
	local email_new="$3"

	# https://htmlpreview.github.io/?https://github.com/newren/git-filter-repo/blob/docs/html/git-filter-repo.html#CALLBACKS
	git filter-repo \
		--commit-callback "
			if commit.author_email == b'$email_old':
			    commit.author_name = b'$name_new'
			    commit.committer_name = b'$name_new'
			    commit.author_email = b'$email_new'
			    commit.committer_email = b'$email_new'
		" \
		--force
}
