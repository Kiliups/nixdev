{ justTmuxSetup, pkgs, ... }:
{
  imports =
    if justTmuxSetup then
      [
        ../moduls/tmux.nix
        ../moduls/tools.nix
        ../moduls/lazy.nix
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

  programs.zsh.initContent = ''
    hms() {
      if [ -z "''${1:-}" ]; then
        echo "Usage: hms <flake_ref>"
        return 1
      fi

      local flake_ref="$1"
      shift

      nix run nixpkgs#home-manager -- switch --flake "$flake_ref" --impure -b backup 
    }
  '';
}
