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
