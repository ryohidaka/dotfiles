{ ... }:
{
  programs.zsh = {
    enable = true;
    sessionVariables = {
      EDITOR = "vi";
      LANG = "en_US.UTF-8";
    };
  };
}
