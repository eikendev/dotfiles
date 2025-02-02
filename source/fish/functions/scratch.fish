function scratch -d "Create a temporary directory, open a subshell in it, and remove the directory upon exit."
    set directory (mktemp -d)

    printf "Spawning subshell in '$directory'.\n" >&2

    env fish_history='' $SHELL -C "cd $directory"

    printf "%s\n" 'Removing scratch directory.' >&2
    rm -rf "$directory"
end
