{
  description = "Personal configuration files, applied with Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Optional private overlay, overridden by the Makefile. See README.
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

      # Pinned Home Manager CLI for `nix run .#home-manager`.
      packages.${system}.home-manager = home-manager.packages.${system}.default;

      formatter.${system} = pkgs.nixfmt-tree;
    };
}
