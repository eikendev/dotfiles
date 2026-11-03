{ config, lib, ... }:
let
  spellDir = "${config.xdg.dataHome}/nvim/site/spell";
in
{
  # Build the spell files once. The script downloads dictionaries and needs
  # nvim and curl from the system, which the activation PATH does not include.
  # `make vim-mkspell` rebuilds them on demand.
  home.activation.vimSpell = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -f "${spellDir}/en.utf-8.spl" ] || [ ! -f "${spellDir}/de.utf-8.spl" ]; then
      PATH="$PATH:/usr/bin" run "$HOME/.dotfiles/scripts/vim-mkspell"
    fi
  '';
}
