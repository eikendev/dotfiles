# Refreshes the page cache for tldr.
{ config, lib, ... }:
{
  home.activation.tldrUpdate = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    PATH="$PATH:${config.xdg.configHome}/cargo/bin" run tldr --update
  '';
}
