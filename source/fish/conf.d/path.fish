fish_add_path "$HOME/bin"
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.nimble/bin"
fish_add_path "$GOPATH/bin"
fish_add_path "$DOTFILES/source/bin"
fish_add_path "$CARGO_HOME/bin"
# Appended so system binaries win.
fish_add_path --append "$XDG_STATE_HOME/nix/profile/bin"
