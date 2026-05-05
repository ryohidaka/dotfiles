{ ... }:
let
  globalTools = {
    node = "latest";
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
