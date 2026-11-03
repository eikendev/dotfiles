{ config, ... }:
let
  # Identity comes from the environment so that it never lands in git. The
  # Makefile passes --impure. The fallbacks only serve evaluation in CI.
  envOr =
    name: fallback:
    let
      value = builtins.getEnv name;
    in
    if value == "" then fallback else value;

  username = envOr "USER" "nobody";
  homeDirectory = envOr "HOME" "/home/${username}";

  # Path of this checkout, passed by the Makefile. Every link into the
  # repository resolves through ~/.dotfiles so that the checkout can move.
  dotfilesDir = envOr "DOTFILES_DIR" "${homeDirectory}/.dotfiles";
in
{
  home = {
    inherit username homeDirectory;
    stateVersion = "26.05";

    file.".dotfiles".source = config.lib.file.mkOutOfStoreSymlink dotfilesDir;
  };

  programs.home-manager.enable = true;

  # Fedora provides man. Home Manager enables its own man-db by default, which
  # would shadow the system one and miss /usr/share/man.
  programs.man.enable = false;

  news.display = "silent";

  # `make init` enables use-xdg-base-directories in /etc/nix/nix.conf, so the
  # profile lives in $XDG_STATE_HOME/nix/profile. Home Manager does not manage
  # nix.conf here, it only needs to know.
  nix.assumeXdg = true;
}
