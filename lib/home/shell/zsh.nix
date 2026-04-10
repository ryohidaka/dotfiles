{ pkgs, ... }:
let
  zshPlugins = [
    {
      name = "zsh-autosuggestions";
      src = pkgs.zsh-autosuggestions;
      file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
    }
    {
      name = "zsh-completions";
      src = pkgs.zsh-completions;
      file = "share/zsh-completions/zsh-completions.plugin.zsh";
    }
  ];
in
{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
    };
    sessionVariables = {
      EDITOR = "vi";
      LANG = "en_US.UTF-8";
    };
    plugins = zshPlugins;
  };
}
