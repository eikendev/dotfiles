# Refreshes the page cache on every switch. Needs tealdeer from cargo.
{ config, lib, ... }:
{
  home.activation.tldrUpdate = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    PATH="$PATH:${config.xdg.configHome}/cargo/bin" run tldr --update
  '';
}
