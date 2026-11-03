# Links into source/ of the checkout, see dotfiles.nix.
{ config, lib, ... }:
let
  link = path: {
    source = config.lib.file.mkOutOfStoreSymlink "${config.dotfiles.link}/source/${path}";
  };

  # Linked as a whole, git shows what apps write into them.
  configEntries = [
    "bat"
    "ddcutil"
    "fish"
    "gdb"
    "git"
    "htop"
    "lazygit"
    "nvim"
    "pip"
    "python"
    "radare2"
    "ripgrep"
    "sqlite3"
    "starship.toml"
    "wezterm"
    "wget"
    "yazi"
    "yt-dlp"
    "zed"
    "zellij"
  ];

  # Apps that fill their config dir with state, only tracked files are linked.
  configFiles = [
    "cargo/config.toml"
    "Code/User/keybindings.json"
    "Code/User/settings.json"
    "Code/User/tasks.json"
  ];

  # Files at fixed locations outside ~/.config.
  homeFiles = {
    ".bash_profile" = "bash_profile";
    ".bashrc" = "bashrc";
    ".claude/settings.json" = "claude/settings.json";
    ".gnupg/gpg.conf" = "gpg/gpg.conf";
    ".gnupg/gpg-agent.conf" = "gpg/gpg-agent.conf";
  };
in
{
  xdg.configFile = lib.genAttrs (configEntries ++ configFiles) link;
  home.file = lib.mapAttrs (_: link) homeFiles;
}
