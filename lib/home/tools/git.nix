{ pkgs, hostPrivate, ... }:
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
    settings.user.name = hostPrivate.git.userName;
    settings.user.email = hostPrivate.git.userEmail;
    ignores = [
      ".DS_Store"
      ".direnv"
    ];
  };
}
