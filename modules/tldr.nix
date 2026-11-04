# Refreshes the page cache for tldr.
{ config, ... }:
{
  home.activation.tldrUpdate = config.lib.dotfiles.entryAfter [ "writeBoundary" ] ''
    PATH="$PATH:${config.xdg.configHome}/cargo/bin" run tldr --update
  '';
}
