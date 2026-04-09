{ self }:
{
  user,
  homeModules ? [ ],
  ...
}:
{
  home-manager = {
    # Use the system-level nixpkgs and install packages to user profile
    useGlobalPkgs = true;
    useUserPackages = true;

    # Allow home modules to reference flake-root files by absolute path
    extraSpecialArgs = {
      flakeRoot = self;
    };

    users.${user} =
      { lib, ... }:
      {
        imports = homeModules;
        home.username = user;
        home.homeDirectory = lib.mkForce "/Users/${user}";
        home.stateVersion = "25.11";
      };
  };
}
