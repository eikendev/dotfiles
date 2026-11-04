# Fetches gef, sourced by source/gdb/gdbinit.
{ config, ... }:
{
  home.activation.gef = config.lib.dotfiles.entryAfter [ "writeBoundary" ] ''
    run curl -q -s -S -L --create-dirs \
      -o "${config.xdg.dataHome}/gef/init.py" \
      'https://raw.githubusercontent.com/hugsy/gef/main/gef.py'
  '';
}
