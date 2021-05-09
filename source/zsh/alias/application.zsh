# Ask before overwriting files.
alias mv='mv --interactive --verbose'
alias cp='cp --interactive --verbose'
alias ln='ln --interactive --verbose'

# Make other aliases available to sudo commands.
# https://askubuntu.com/a/22043
#alias sudo='sudo '

# Use nvim if available.
if [ -x "$(command -v nvim)" ]; then
	alias vim='nvim'
	alias v='vim'
fi

# Quickly display file contents.
alias b='bat'

# Do not load any configuration.
alias vimx='vim -u NONE'

# Only print matching lines with ripgrep.
alias rgp='rg --no-filename --no-line-number --no-heading --color never '

# Use lsd if available.
if [ -x "$(command -v lsd)" ]; then
	alias ls='lsd -A -l --group-dirs first --date relative --icon never'
	alias lse='lsd -A -l --group-dirs first --date date --icon never'
else
	alias ls='ls -a -l -h --color --group-directories-first'
fi

# Display size of files and folders under current directory.
alias du='du --max-depth=1 --si'

# Display all disk usage statistics with si units and fs types.
alias df='df --all --si --print-type'

# Truncate file completely.
alias trunc='truncate --size=0'

# Improve UI of network latency.
alias ping='prettyping'

# Color IP addresses for better readability.
alias ip='ip -color'

# Do not show copyright information of GDB.
alias gdb='gdb -quiet'

# Do not load any configuration.
alias gdbx='gdb -n'

# Quick translations.
alias tende='trans -s en -t de -v'
alias tdeen='trans -s de -t en -v'

# Do not save history of units.
alias units='units --history /dev/null'

# YouTube downloading for audio and video.
alias ytdla="youtube-dl --ignore-errors --format 'bestaudio' --extract-audio --audio-format 'mp3' --audio-quality 3 --output '%(title)s.%(ext)s'"
alias ytdlv="youtube-dl --ignore-errors --format 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' --output '%(title)s.%(ext)s'"

# Quick access to a Python interpreter.
alias py='python3'

# Start tmux in debug mode.
alias tmux-debug='tmux -Ltest kill-server; tmux -vv -Ltest -f/dev/null new'

# Shortcuts for common Make targets.
alias Mb='make build'
alias Mc='make clean'
alias Mi='make install'
alias Mr='make remove'

alias diff2='git diff --no-index --color-words'
