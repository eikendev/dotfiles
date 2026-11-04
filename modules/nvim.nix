{ config, ... }:
let
  spellDir = "${config.xdg.dataHome}/nvim/site/spell";
in
{
  home.activation = {
    # Installs the plugins pinned in lazy-lock.json, bumped by `make update`.
    # Treesitter parsers follow the pinned nvim-treesitter.
    vimPlugins = config.lib.dotfiles.entryAfter [ "linkGeneration" ] ''
      run nvim --headless '+Lazy! restore' "+lua require('nvim-treesitter').update():wait(300000)" +qa
    '';

    # Built once, refreshed by `make update`.
    vimSpell = config.lib.dotfiles.entryAfter [ "linkGeneration" ] ''
      if [ ! -f "${spellDir}/en.utf-8.spl" ] || [ ! -f "${spellDir}/de.utf-8.spl" ]; then
        run "${config.dotfiles.link}/scripts/vim-mkspell"
      fi
    '';
  };
}
