{ justTmuxSetup, pkgs, ... }:
{
  imports =
    if justTmuxSetup then
      [
        ../moduls/tmux.nix
      ]
    else
      [
        ../moduls/tools.nix
        ../moduls/shell.nix
        ../moduls/tmux.nix
        ../moduls/programs.nix
        ../moduls/lazy.nix
        ../moduls/starship.nix
        ../moduls/vscode.nix
      ];
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    targets.vscode.enable = false;
  };
}
