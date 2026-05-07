{
  user,
  homebrew ? { },
  ...
}:
{
  nix-homebrew = {
    # Install Homebrew under the default prefix
    enable = true;

    # User owning the Homebrew installation
    user = user;

    # Migrate existing Homebrew installation
    autoMigrate = true;
  };

  homebrew = {
    enable = true;

    # Remove formulae and casks not listed here on rebuild
    onActivation.cleanup = "zap";

    taps = homebrew.taps or [ ];
    brews = homebrew.brews or [ ];
    casks =
      homebrew.casks or [
        "google-chrome"
      ];
  };
}
