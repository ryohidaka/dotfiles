{ ... }:
let
  globalTools = { };
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
