{ flakeRoot, ... }:
{
  programs.starship = {
    enable = true;

    # Initialized manually in zsh initContent to ensure correct load order
    enableZshIntegration = false;

    settings = builtins.fromTOML (builtins.readFile "${flakeRoot}/config/starship/starship.toml");
  };
}
