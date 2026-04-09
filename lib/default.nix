inputs:
let
  inherit (inputs) self;
  nixDarwin = inputs."nix-darwin";
in
{
  # Build a nix-darwin system configuration from a host definition
  mkDarwinSystem =
    _: hostCfg:
    nixDarwin.lib.darwinSystem {
      modules = [
        # Core system settings (platform, user, nix options)
        (import ./modules/system.nix { inherit self; } hostCfg)
      ];
    };
}
