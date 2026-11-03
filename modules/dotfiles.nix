{ config, lib, ... }:
let
  name = ".dotfiles";
in
{
  options.dotfiles = {
    checkout = lib.mkOption {
      type = lib.types.str;
      description = "Path of the git checkout.";
    };

    link = lib.mkOption {
      type = lib.types.str;
      readOnly = true;
      default = "${config.home.homeDirectory}/${name}";
      description = "Stable path that points at the checkout.";
    };
  };

  config.home.file.${name}.source = config.lib.file.mkOutOfStoreSymlink config.dotfiles.checkout;
}
