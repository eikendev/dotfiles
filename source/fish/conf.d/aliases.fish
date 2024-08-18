# Ask before overwriting files.
alias mv='mv --interactive --verbose'
alias cp='cp --interactive --verbose'
alias ln='ln --interactive --verbose'

# Use nvim if available.
if test -x (command -v nvim)
    alias vim='nvim'
end

# Do not load any configuration.
alias vimx='vim -u NONE'

# Only print matching lines with ripgrep.
alias rgp='rg --no-filename --no-line-number --no-heading --color never'

# Use lsd if available.
if test -x (command -v lsd)
    alias ls='lsd -A -l --group-dirs first --date relative --icon never'
    alias lse='lsd -A -l --group-dirs first --date date --icon never'
else
    alias ls='ls -a -l -h --color --group-directories-first'
end

# Display size of files and folders under current directory.
alias duc='du --max-depth=1 --si'

# Display all disk usage statistics with si units and fs types.
alias dfa='df --all --si --print-type'

# Truncate file completely.
alias trunc='truncate --size=0'

# Use a Taskfile.
alias task='go-task'

# Color IP addresses for better readability.
alias ip='ip -color'

# Do not show copyright information of GDB.
alias gdb='gdb -quiet'

# Do not load any configuration.
alias gdbx='gdb -n'

# Do not save history of units.
alias units='units --history /dev/null'

# Invoke a hackenv machine.
alias kali='hackenv --type=kali'
alias parrot='hackenv --type=parrot'

# Do not track subsequent commands.
alias incognito='set -e fish_history'

# Do not check authenticity when using SSH.
alias unsafessh='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
