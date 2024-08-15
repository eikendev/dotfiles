function scratch
    set -l directory (mktemp -d)

    printf "Spawning subshell in '$directory'.\n" >&2

    cd $directory; $SHELL

    printf "%s\n" 'Removing scratch directory.' >&2
    rm -rf "$directory"
end
