{
  # Intel Mac
  platform = "x86_64-darwin";
  user = "ryohidaka";

  # Host-specific nix-darwin modules
  darwinModules = [
    ./homebrew.nix
  ];

  # Host-specific home-manager modules
  homeModules = [ ];
}
