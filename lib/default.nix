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

  # Load optional private config from host directory
  loadPrivate =
    hostDir:
    if builtins.pathExists "${toString hostDir}/private.nix" then
      import "${toString hostDir}/private.nix"
    else
      { };
in
{
  # Build a nix-darwin system configuration from a host definition
  mkDarwinSystem =
    _: hostDir:
    let
      hostCfg = import hostDir;
      private = loadPrivate hostDir;
      cfg = hostCfg // {
        inherit private;
        networking = private.networking or { };
        homeModules = baseHomeModules ++ (hostCfg.homeModules or [ ]);
      };
    in
    nixDarwin.lib.darwinSystem {
      modules = [
        # Core system settings (platform, user, nix options)
        (import ./darwin/system.nix cfg)

        # home-manager integration for user environment
        homeManager.darwinModules.home-manager
        (import ./darwin/home-manager.nix { inherit self; } cfg)

        # Homebrew integration
        nixHomebrew.darwinModules.nix-homebrew
        (import ./darwin/homebrew.nix cfg)
        sopsNix.darwinModules.sops
      ]
      ++ (cfg.darwinModules or [ ]);
    };
}
