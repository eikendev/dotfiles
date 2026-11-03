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
      self,
      nixpkgs,
      home-manager,
      private,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      check =
        name: tool: command:
        pkgs.runCommand "check-${name}" { nativeBuildInputs = [ tool ]; } ''
          ${command} ${self}
          touch "$out"
        '';
    in
    {
      # Run with `nix flake check`.
      checks.${system} = {
        format = check "format" pkgs.nixfmt "nixfmt --check";
        statix = check "statix" pkgs.statix "statix check";
        deadnix = check "deadnix" pkgs.deadnix "deadnix --fail";
        home = self.homeConfigurations.default.activationPackage;
      };

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
