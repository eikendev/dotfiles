# https://stackoverflow.com/a/18077919

PATH+=:"$HOME/.local/bin"
PATH+=:"$GOPATH/bin"
PATH+=:"$DOTFILES/bin"
PATH+=:"$DOTFILES/vendor/dasht/bin"
PATH+=:"$DOTFILES/vendor/thunderbird-unread/bin"

# Prepend so that rustup works properly.
path=("$CARGO_HOME/bin" $path)

# Deduplicate entries in $PATH.
typeset -U PATH

export PATH
