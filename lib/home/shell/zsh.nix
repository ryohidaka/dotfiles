{ pkgs, config, ... }:
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
    {
      name = "zsh-syntax-highlighting";
      src = pkgs.zsh-syntax-highlighting;
      file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
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
      SOPS_AGE_KEY_FILE = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    };
    plugins = zshPlugins;
    initContent = ''
      # Initialize Starship prompt
      eval "$(starship init zsh)"
    '';
  };
}
