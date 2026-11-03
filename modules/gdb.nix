# Fetches gef, sourced by source/gdb/gdbinit.
{ config, lib, ... }:
{
  home.activation.gef = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    PATH="$PATH:/usr/bin" run curl -q -s -S -L --create-dirs \
      -o "${config.xdg.dataHome}/gef/init.py" \
      'https://raw.githubusercontent.com/hugsy/gef/main/gef.py'
  '';
}
