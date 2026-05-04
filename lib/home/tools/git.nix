{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lefthook # Git Hooks
  ];

  programs.lazygit = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    ignores = [
      ".DS_Store"
      ".direnv"
    ];
  };
}
