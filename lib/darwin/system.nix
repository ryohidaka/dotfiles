{
  platform,
  user,
  networking ? { },
  ...
}:
{
  # Target platform architecture (e.g. x86_64-darwin, aarch64-darwin)
  nixpkgs.hostPlatform = platform;

  # nix-darwin state version — do not change after initial setup
  system.stateVersion = 6;

  # Primary user for nix-darwin management
  system.primaryUser = user;

  # Disable nix managed by nix-darwin (e.g. when using Determinate Nix)
  nix.enable = false;

  # Networking settings
  inherit networking;
}
