{ pkgs, hostPrivate, ... }:
let
  gitCfg = hostPrivate.git or { };
in
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
    settings.user.name = gitCfg.userName or "";
    settings.user.email = gitCfg.userEmail or "";
    ignores = [
      ".DS_Store"
      ".direnv"
    ];
  };
}
