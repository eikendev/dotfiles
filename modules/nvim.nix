{ config, lib, ... }:
let
  spellDir = "${config.xdg.dataHome}/nvim/site/spell";
in
{
  # Built once, `make vim-mkspell` rebuilds. Needs system nvim and curl.
  home.activation.vimSpell = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    if [ ! -f "${spellDir}/en.utf-8.spl" ] || [ ! -f "${spellDir}/de.utf-8.spl" ]; then
      PATH="$PATH:/usr/bin" run "${config.dotfiles.link}/scripts/vim-mkspell"
    fi
  '';
}
