{
  description = "Personal configuration files, applied with Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Optional private overlay. The default is a tracked no-op flake. The
    # Makefile replaces it with --override-input when a private directory is
    # configured, see README.
    private.url = "path:./private-empty";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      private,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations.default = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          private.homeModules.default
        ];
      };

      # Expose the pinned Home Manager CLI so `nix run .#home-manager` always
      # matches the version the configuration was written against.
      packages.${system}.home-manager = home-manager.packages.${system}.default;

      formatter.${system} = pkgs.nixfmt-tree;
    };
}
