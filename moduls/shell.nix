{
  pkgs,
  email,
  name,
  ...
}:
{
  home.sessionVariables = {
    TERMINAL = "ghostty";
  };

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        ls = "eza -lh --group-directories-first --icons=auto";
      };
      initContent = ''
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
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [ "--cmd cd" ];
    };

    git = {
      enable = true;
      settings = {
        user.name = name;
        user.email = email;
        init.defaultBranch = "main";
      };
    };
  };

  home.packages = with pkgs; [
    ghostty-bin

    btop
    fastfetch
    ripgrep
    eza
    fd
  ];

  xdg.configFile."ghostty/config.ghostty".text = ''
    font-family = "JetBrains Mono"
    theme = "Catppuccin Macchiato"
    confirm-close-surface = false
  '';
}
