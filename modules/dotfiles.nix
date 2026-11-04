{ config, lib, ... }:
let
  name = ".dotfiles";
in
{
  options.dotfiles = {
    checkout = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/git/personal/dotfiles";
      description = "Path of the git checkout.";
    };

    link = lib.mkOption {
      type = lib.types.str;
      readOnly = true;
      default = "${config.home.homeDirectory}/${name}";
      description = "Stable path that points at the checkout.";
    };
  };

  config = {
    home.file.${name}.source = config.lib.file.mkOutOfStoreSymlink config.dotfiles.checkout;

    # Like lib.hm.dag.entryAfter, with the system tools on PATH. Activation
    # runs with a minimal PATH on purpose, the steps here call out to Fedora.
    lib.dotfiles.entryAfter =
      after: script:
      lib.hm.dag.entryAfter after ''
        (
          export PATH="$PATH:/usr/bin"
          ${script}
        )
      '';
  };
}
