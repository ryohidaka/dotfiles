{ ... }:
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
  };
}
