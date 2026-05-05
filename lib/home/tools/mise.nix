{ ... }:
let
  globalTools = {
    node = "latest";
    "npm:pnpm" = "latest";
  };
in
{
  programs.mise = {
    enable = true;
    enableZshIntegration = true;
    globalConfig = {
      tools = globalTools;
    };
  };
}
