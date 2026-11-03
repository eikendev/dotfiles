{ config, pkgs, ... }:
let
  # Identity from the environment, the Makefile passes --impure. Fallbacks
  # are for CI.
  envOr =
    name: fallback:
    let
      value = builtins.getEnv name;
    in
    if value == "" then fallback else value;

  username = envOr "USER" "nobody";
  homeDirectory = envOr "HOME" "/home/${username}";

  # Checkout path from the Makefile. All links resolve through ~/.dotfiles.
  dotfilesDir = envOr "DOTFILES_DIR" "${homeDirectory}/.dotfiles";
in
{
  imports = [
    ./modules/files.nix
    ./modules/nvim.nix
    ./modules/services.nix
  ];

  home = {
    inherit username homeDirectory;
    stateVersion = "26.05";

    file.".dotfiles".source = config.lib.file.mkOutOfStoreSymlink dotfilesDir;

    # Only packages from nixpkgs, everything else comes from DNF.
    packages = with pkgs; [
      # Loaded by source/fish/conf.d/nix.fish.
      fishPlugins.autopair
      fishPlugins.fzf-fish

      fira-code
      monaspace
      source-code-pro
      nerd-fonts.symbols-only
      noto-fonts-color-emoji
    ];
  };

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

  # Fedora provides man, the Nix man-db would miss /usr/share/man.
  programs.man.enable = false;

  news.display = "silent";

  # use-xdg-base-directories is set in /etc/nix/nix.conf by `make init`.
  nix.assumeXdg = true;
}
