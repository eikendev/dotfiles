{ pkgs, ... }:
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
in
{
  imports = [
    ./modules/dotfiles.nix
    ./modules/files.nix
    ./modules/gdb.nix
    ./modules/nvim.nix
    ./modules/services.nix
    ./modules/toolchains.nix
  ];

  home = {
    inherit username homeDirectory;
    stateVersion = "26.05";

    packages = with pkgs; [
      # Loaded by source/fish/conf.d/nix.fish.
      fishPlugins.autopair
      fishPlugins.fzf-fish

      monaspace
      source-code-pro
      nerd-fonts.symbols-only
      noto-fonts-color-emoji
    ];
  };

  # Checkout path from the Makefile.
  dotfiles.checkout = envOr "DOTFILES_DIR" "${homeDirectory}/.dotfiles";

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

  # Fedora provides man, the Nix man-db would miss /usr/share/man.
  programs.man.enable = false;

  news.display = "silent";

  # use-xdg-base-directories is set in /etc/nix/nix.conf by `make init`.
  nix.assumeXdg = true;
}
