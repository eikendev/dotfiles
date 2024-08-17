function git-replace-author -d "Replace the name and email of a Git author in the repository."
    if test (count $argv) -ne 3
        printf "Usage: git-replace-author <email_old> <name_new> <email_new>\n" >&2
        return 1
    end

    set email_old $argv[1]
    set name_new $argv[2]
    set email_new $argv[3]

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
end
