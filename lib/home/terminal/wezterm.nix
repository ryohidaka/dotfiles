{ flakeRoot, ... }:
{
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = builtins.readFile "${flakeRoot}/config/wezterm/wezterm.lua";
  };
}
