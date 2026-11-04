# Installs the Go and Rust toolchains once. Refreshed by `make update`.
{ config, ... }:
let
  scripts = "${config.dotfiles.link}/scripts";
  cargoHome = "${config.xdg.configHome}/cargo";
in
{
  home.activation.toolchains = config.lib.dotfiles.entryAfter [ "linkGeneration" ] ''
    export GOPATH="${config.xdg.dataHome}/go"
    export CARGO_HOME="${cargoHome}"
    export RUSTUP_HOME="${config.xdg.dataHome}/rustup"

    if [ ! -x "$HOME/bin/go" ]; then
      run "${scripts}/install-go"
    fi

    if [ ! -x "${cargoHome}/bin/rustup" ]; then
      run "${scripts}/install-rust"
    fi
  '';
}
