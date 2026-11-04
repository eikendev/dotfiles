{ config, ... }:
let
  spellDir = "${config.xdg.dataHome}/nvim/site/spell";
in
{
  home.activation = {
    # Applies lazy-lock.json like switch applies flake.lock: only when the lock
    # changed, since restore fetches every remote. Treesitter parsers follow
    # the pinned nvim-treesitter.
    vimPlugins = config.lib.dotfiles.entryAfter [ "linkGeneration" ] ''
      lock="${config.dotfiles.link}/source/nvim/lazy-lock.json"
      applied="${config.xdg.stateHome}/dotfiles/lazy-lock.json"

      if ! cmp -s "$lock" "$applied"; then
        run nvim --headless '+Lazy! restore' "+lua require('nvim-treesitter').update():wait(300000)" +qa
        run install -D "$lock" "$applied"
      fi
    '';

    # Built once, refreshed by `make update`.
    vimSpell = config.lib.dotfiles.entryAfter [ "linkGeneration" ] ''
      if [ ! -f "${spellDir}/en.utf-8.spl" ] || [ ! -f "${spellDir}/de.utf-8.spl" ]; then
        run "${config.dotfiles.link}/scripts/vim-mkspell"
      fi
    '';
  };
}
