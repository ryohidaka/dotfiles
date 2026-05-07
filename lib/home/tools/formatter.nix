{ pkgs, ... }:
{
  home.packages = with pkgs; [
    oxfmt # Markdown / YAML formatter
    nixfmt-rfc-style # Nix formatter
    treefmt # Multi-formatter runner
    stylua # Lua formatter
    taplo # TOML formatter
  ];
}
