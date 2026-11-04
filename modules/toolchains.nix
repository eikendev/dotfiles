# Installs the Go and Rust toolchains once. Refreshed by `make update`.
{ config, lib, ... }:
let
  cfg = config.toolchains;
  scripts = "${config.dotfiles.link}/scripts";
in
{
  # Mirrored for the shell in source/fish/conf.d/00-environment.fish.
  options.toolchains = {
    cargoHome = lib.mkOption {
      type = lib.types.str;
      default = "${config.xdg.configHome}/cargo";
      description = "CARGO_HOME, binaries installed by cargo live in its bin/.";
    };

    goPath = lib.mkOption {
      type = lib.types.str;
      default = "${config.xdg.dataHome}/go";
      description = "GOPATH, binaries installed by go live in its bin/.";
    };

    rustupHome = lib.mkOption {
      type = lib.types.str;
      default = "${config.xdg.dataHome}/rustup";
      description = "RUSTUP_HOME.";
    };
  };

  config.home.activation.toolchains = config.lib.dotfiles.entryAfter [ "linkGeneration" ] ''
    export GOPATH="${cfg.goPath}"
    export CARGO_HOME="${cfg.cargoHome}"
    export RUSTUP_HOME="${cfg.rustupHome}"

    if [ ! -x "$HOME/bin/go" ]; then
      run "${scripts}/install-go"
    fi

    if [ ! -x "${cfg.cargoHome}/bin/rustup" ]; then
      run "${scripts}/install-rust"
    fi
  '';
}
