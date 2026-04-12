{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lefthook # Git Hooks
  ];

  programs.lazygit = {
    enable = true;
    enableZshIntegration = true;
  };

}
