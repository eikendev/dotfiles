# Replace the name and the email of a Git author.
function git-replace-author {
	if [ $# -ne 3 ]; then
		echo "Usage: $0 <email_old> <name_new> <email_new>" >&2
		return 1
	fi

	local email_old="$1"
	local name_new="$2"
	local email_new="$3"

	git filter-branch --env-filter '
		if [ "$GIT_AUTHOR_EMAIL" = "'$email_old'" ]; then
			GIT_AUTHOR_NAME="'$name_new'";
			GIT_AUTHOR_EMAIL="'$email_new'";
			GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME";
			GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL;
		fi' -- --all
}
