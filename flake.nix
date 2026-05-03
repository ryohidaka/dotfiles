{
  description = "nix-darwin system flake";

  inputs = {
    # Nix package collection (unstable channel)
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # nix-darwin: macOS system configuration via Nix
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # home-manager: user environment configuration via Nix
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let
      # Load helper functions from lib/
      lib = import ./lib inputs;

      # Host definitions
      supportedSystems = [
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems =
        f:
        builtins.listToAttrs (
          map (system: {
            name = system;
            value = f system;
          }) supportedSystems
        );

      hosts = {
        intel = ./hosts/intel;
        ci-intel = ./hosts/ci-intel;
        ci-silicon = ./hosts/ci-silicon;
      };
    in
    {
      # Build a darwinConfiguration for each host
      darwinConfigurations = builtins.mapAttrs (name: hostPath: lib.mkDarwinSystem name hostPath) hosts;

      # Format: nix fmt
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.treefmt);
    };
}
