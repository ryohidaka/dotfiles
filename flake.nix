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
  };

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let
      # Load helper functions from lib/
      lib = import ./lib inputs;

      # Host definitions
      hosts = { };
    in
    {
      # Build a darwinConfiguration for each host
      darwinConfigurations = builtins.mapAttrs (
        name: hostPath: lib.mkDarwinSystem name (import hostPath)
      ) hosts;
    };
}
