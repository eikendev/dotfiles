# Links from the home directory into source/. Every link goes through
# ~/.dotfiles so that the checkout can move without touching this file.
{ config, lib, ... }:
let
  link = path: {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/source/${path}";
  };

  # Entries linked as a whole under ~/.config. Apps may write into them, and
  # git shows what they changed or created.
  configEntries = [
    "bat"
    "ddcutil"
    "fish"
    "gdb"
    "git"
    "htop"
    "lazygit"
    "MangoHud"
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

  # Apps that fill their config directory with state. Only the tracked files
  # are linked, the directory itself stays outside the repository.
  configFiles = [
    "cargo/config.toml"
    "Code/User/keybindings.json"
    "Code/User/settings.json"
    "Code/User/tasks.json"
    "systemd/user/tbunread.service"
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
