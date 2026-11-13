{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./modules/dotfiles.nix
    ./modules/files.nix
    ./modules/gdb.nix
    ./modules/nvim.nix
    ./modules/openshell.nix
    ./modules/services.nix
    ./modules/toolchains.nix
  ];

  home = {
    # Placeholders that keep the evaluation pure, the private overlay sets the
    # real identity. See README.
    username = lib.mkDefault "nobody";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";

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

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

  # Fedora provides man, the Nix man-db would miss /usr/share/man.
  programs.man.enable = false;

  news.display = "silent";

  # use-xdg-base-directories is set in /etc/nix/nix.conf by `make init`.
  nix.assumeXdg = true;
}
