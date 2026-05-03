{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nixfmt-rfc-style # Nix formatter
    treefmt # Multi-formatter runner
  ];
}
