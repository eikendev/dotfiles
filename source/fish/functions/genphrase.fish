function genphrase -d 'Generate a passphrase from a list of words.'
    if test (count $argv) -ne 2
        printf 'Usage: %s <file> <count>\n' (status function) >&2
        return 1
    end

    set file $argv[1]
    set count $argv[2]

    if not test -f $file
        printf 'File does not exist.\n' >&2
        return 1
    end

    set phrase (shuf --random-source=/dev/urandom --repeat --head-count=$count $file | tr '\n' '-')

    set phrase (string trim -r -c '-' $phrase)

    printf '%s\n' $phrase
end
