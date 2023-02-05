# https://stackoverflow.com/a/18077919

PATH+=:"$HOME/bin"
PATH+=:"$HOME/.local/bin"
PATH+=:"$HOME/.nimble/bin"
PATH+=:"$GOPATH/bin"
PATH+=:"$DOTFILES/bin"

# Prepend so that rustup works properly.
path=("$CARGO_HOME/bin" $path)

# Deduplicate entries in $PATH.
typeset -U PATH

export PATH
