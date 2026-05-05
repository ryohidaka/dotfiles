inputs:
let
  inherit (inputs) self;
  nixDarwin = inputs."nix-darwin";
  homeManager = inputs."home-manager";
  nixHomebrew = inputs."nix-homebrew";
  sopsNix = inputs."sops-nix";

  # Home-manager modules shared across all hosts
  baseHomeModules = [
    ./home/editor
    ./home/shell
    ./home/terminal
    ./home/tools
  ];

  # Conditionally include Homebrew modules based on host config
  mkHomebrewModules =
    cfg:
    if cfg.enableHomebrew or false then
      [
        nixHomebrew.darwinModules.nix-homebrew
        (import ./darwin/homebrew.nix cfg)
      ]
    else
      [ ];

  # Load optional private config from host directory
  loadPrivate =
    hostDir:
    if builtins.pathExists "${toString hostDir}/private.nix" then
      import "${toString hostDir}/private.nix"
    else
      { };

  # Merge host config with private values and resolved fields
  mkHostConfig =
    hostDir:
    let
      hostCfg = import hostDir;
      private = loadPrivate hostDir;
    in
    hostCfg
    // {
      inherit private;
      networking = private.networking or { };
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

        sopsNix.darwinModules.sops
      ]
      ++ (mkHomebrewModules cfg)
      ++ (cfg.darwinModules or [ ]);
    };
}
