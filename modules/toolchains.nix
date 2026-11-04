# Installs and updates the Go and Rust toolchains.
{ config, ... }:
let
  scripts = "${config.dotfiles.link}/scripts";
in
{
  home.activation.toolchains = config.lib.dotfiles.entryAfter [ "linkGeneration" ] ''
    export GOPATH="${config.xdg.dataHome}/go"
    export CARGO_HOME="${config.xdg.configHome}/cargo"
    export RUSTUP_HOME="${config.xdg.dataHome}/rustup"

    # ~/bin first so the Go linked there wins over the system one.
    PATH="$HOME/bin:$PATH" run "${scripts}/install-go"
    run "${scripts}/install-rust"
  '';
}
