function replace-string -d "Replace a string in all files matching a pattern in the current directory."
    if test (count $argv) -ne 3
        printf "Usage: replace-string <pattern> <string_old> <string_new>\n" >&2
        return 1
    end

    set -l pattern $argv[1]
    set -l string_old $argv[2]
    set -l string_new $argv[3]

    # Ask for confirmation
    printf "Replace '%s' with '%s'? [y/N]\n" "$string_old" "$string_new"
    read -l answer

    if test "$answer" = "y" -o "$answer" = "Y"
        find . -type f -iname "$pattern" -exec sed -i "s#$string_old#$string_new#g" {} +
    end
end
