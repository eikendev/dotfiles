function fff -d "Search files with fd, select with fzf, and open in the editor."
    set files (fd $argv[1] --type f --no-ignore --hidden --follow --exclude '.git/' | fzf --query="$argv[1]" --height=22 -m -0)

    if test (count $files) -gt 0
        $EDITOR $files
    end
end
