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
      hosts = {
        personal = import ./hosts/personal;
        ci-intel = import ./hosts/ci-intel;
        ci-silicon = import ./hosts/ci-silicon;
      };
    in
    {
      # Build a darwinConfiguration for each host
      darwinConfigurations = builtins.mapAttrs lib.mkDarwinSystem hosts;

      # Format: nix fmt
      formatter.x86_64-darwin = nixpkgs.legacyPackages.x86_64-darwin.treefmt;
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.treefmt;
    };
}
