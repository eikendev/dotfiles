# Fetches gef once, sourced by source/gdb/gdbinit. Refreshed by `make update`.
{ config, ... }:
{
  home.activation.gef = config.lib.dotfiles.entryAfter [ "linkGeneration" ] ''
    if [ ! -f "${config.xdg.dataHome}/gef/init.py" ]; then
      run "${config.dotfiles.link}/scripts/install-gef"
    fi
  '';
}
