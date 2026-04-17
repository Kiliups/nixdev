{ justTmuxSetup, ... }:
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
}
