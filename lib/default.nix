inputs:
let
  inherit (inputs) self;
  nixDarwin = inputs."nix-darwin";
  homeManager = inputs."home-manager";

  # Home-manager modules shared across all hosts
  baseHomeModules = [ ];

  # Merge host config with private values and resolved fields
  mkHostConfig =
    hostDir:
    let
      hostCfg = import hostDir;
    in
    hostCfg
    // {
      homeModules = baseHomeModules ++ (hostCfg.homeModules or [ ]);
    };
in
{
  mkDarwinSystem =
    _: hostDir:
    let
      cfg = mkHostConfig hostDir;
    in
    nixDarwin.lib.darwinSystem {
      modules = [
        # Core system settings (platform, user, nix options)
        (import ./darwin/system.nix cfg)

        # home-manager integration for user environment
        homeManager.darwinModules.home-manager
        (import ./darwin/home-manager.nix { inherit self; } cfg)
      ]
      ++ (cfg.darwinModules or [ ]);
    };
}
