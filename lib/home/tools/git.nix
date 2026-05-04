{
  pkgs,
  lib,
  hostPrivate,
  ...
}:
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
    settings = {
      user = {
        name = gitCfg.userName or "";
        email = gitCfg.userEmail or "";
      };
    };
    signing = lib.optionalAttrs (hostPrivate ? gpg && hostPrivate.gpg ? signingKey) {
      key = hostPrivate.gpg.signingKey;
      signByDefault = true;
    };
    ignores = [
      ".DS_Store"
      ".direnv"
    ];
  };
}
