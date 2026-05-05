{ pkgs, flakeRoot, ... }:
{
  home.packages = with pkgs; [ neovim ];
  # Manage LazyVim config files via home-manager
  xdg.configFile."nvim" = {
    source = "${flakeRoot}/config/nvim";
    recursive = true;
  };
}
