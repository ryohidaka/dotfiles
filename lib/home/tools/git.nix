{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lefthook # Git Hooks
  ];
}
