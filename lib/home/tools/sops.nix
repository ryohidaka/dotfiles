{ pkgs, ... }:
{
  home.packages = with pkgs; [
    sops # Secrets management
  ];
}
