PATH+=:$HOME/.local/bin
PATH+=:$HOME/bin/dot
PATH+=:$CARGO_HOME/bin
PATH+=:$GOPATH/bin
PATH+=:$DOTFILES/vendor/dasht/bin
PATH+=:$DOTFILES/vendor/turs/target/release

# Deduplicate entries in $PATH.
typeset -U PATH

export PATH
