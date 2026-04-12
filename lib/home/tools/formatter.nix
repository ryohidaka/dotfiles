{ pkgs, ... }:
{
  home.packages = with pkgs; [
    treefmt # Multi-formatter runner
    nixfmt-rfc-style # Nix formatter
    stylua # Lua formatter
    taplo # TOML formatter
    oxfmt # JS / Markdown / YAML formatter
  ];
}
