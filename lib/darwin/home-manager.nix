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
      flakeRoot = self.outPath;
    };

    users.${user} =
      { pkgs, lib, ... }:
      {
        imports = homeModules;
        home.username = user;
        home.homeDirectory = lib.mkForce "/Users/${user}";
        home.stateVersion = "25.11";

        home.packages = with pkgs; [
          treefmt # Multi-formatter runner
          nixfmt-rfc-style # Nix formatter
          lefthook # Git Hooks
          stylua # Lua formatter
        ];
      };
  };
}
