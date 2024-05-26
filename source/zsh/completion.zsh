# Enable autocompletion.
autoload -Uz compinit && compinit

# Used because Fedora ships task with binary name 'go-task'.
compdef _task go-task

# Autocomplete hidden files.
_comp_options+=(globdots)

# Show colored autocompletion menu.
zmodload zsh/complist
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle -e ':completion:*:approximate:*' max-errors 'reply=$((($#PREFIX+$#SUFFIX)/3))'

# When new programs are installed, update without reloading.
zstyle ':completion:*' rehash true

# Change completion behaviour.
# - case-insensitive
# - accept abbreviations after . or _ or - (ie. f.b -> foo.bar)
# - substring complete (ie. bar -> foobar)
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Instead of only listing possibilities, select the first match immediately.
#setopt MENU_COMPLETE
