inputs:
let
  inherit (inputs) self;
  nixDarwin = inputs."nix-darwin";
  homeManager = inputs."home-manager";

  # Home-manager modules shared across all hosts
  baseHomeModules = [ ];
in
{
  # Build a nix-darwin system configuration from a host definition
  mkDarwinSystem =
    _: hostCfg:
    nixDarwin.lib.darwinSystem {
      modules = [
        # Core system settings (platform, user, nix options)
        (import ./modules/system.nix { inherit self; } hostCfg)
        homeManager.darwinModules.home-manager
        (import ./modules/home-manager.nix { inherit self; } (
          hostCfg
          // {
            homeModules = baseHomeModules ++ (hostCfg.homeModules or [ ]);
          }
        ))
      ];
    };
}
