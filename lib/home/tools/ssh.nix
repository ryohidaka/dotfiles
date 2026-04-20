{ hostPrivate, lib, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      # Apply shared settings to all hosts
      "*".addKeysToAgent = "yes";
    }
    // lib.mapAttrs (
      _: cfg:
      {
        hostname = cfg.hostname;
        identityFile = cfg.identityFile;
      }
      // lib.optionalAttrs (cfg ? user) { user = cfg.user; }
    ) (hostPrivate.ssh or { });
  };
}
