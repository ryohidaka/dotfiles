inputs:
let
  inherit (inputs) self;
  nixDarwin = inputs."nix-darwin";
  homeManager = inputs."home-manager";
  nixHomebrew = inputs."nix-homebrew";

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
        (import ./darwin/system.nix { inherit self; } hostCfg)

        # home-manager integration for user environment
        homeManager.darwinModules.home-manager
        (import ./darwin/home-manager.nix { inherit self; } (
          hostCfg
          // {
            homeModules = baseHomeModules ++ (hostCfg.homeModules or [ ]);
          }
        ))

        # Homebrew integration
        nixHomebrew.darwinModules.nix-homebrew
        (import ./darwin/homebrew.nix hostCfg)
      ];
    };
}
