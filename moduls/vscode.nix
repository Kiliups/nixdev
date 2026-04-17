{
  pkgs,
  lib,
  config,
  ...
}:
let
  vsCodeSettings = {
    # theme
    "catppuccin.accentColor" = "lavender";
    "workbench.colorTheme" = "Catppuccin Macchiato";
    "workbench.iconTheme" = "catppuccin-macchiato";

    # editor general
    "editor.semanticHighlighting.enabled" = true;
    "editor.lineNumbers" = "relative";
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
    "editor.formatOnSave" = true;
    "editor.formatOnPaste" = true;
    "editor.codeActionsOnSave" = {
      "source.organizeImports" = "explicit";
    };
    "editor.fontFamily" = "JetBrainsMono Nerd Font";
    "files.autoSave" = "afterDelay";

    # astro
    "[astro]" = {
      "editor.defaultFormatter" = "astro-build.astro-vscode";
      "editor.formatOnSave" = true;
    };
    "prettier.documentSelectors" = [ "**/*.astro" ];

    # json
    "[json]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "editor.formatOnSave" = true;
      "editor.wordWrap" = "bounded";
      "editor.wordWrapColumn" = 100;
    };
    "[jsonc]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "editor.formatOnSave" = true;
    };

    # nix
    "[nix]" = {
      "editor.defaultFormatter" = "jnoortheen.nix-ide";
      "editor.formatOnSave" = true;
    };
    "nix.enableLanguageServer" = true;
    "nix.serverPath" = "nixd";
    "nix.formatterPath" = "nixfmt";

    # markdown
    "[markdown]" = {
      "editor.wordWrap" = "bounded";
      "editor.wordWrapColumn" = 100;
    };
  };
in
{
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      # general/editor
      esbenp.prettier-vscode
      ms-vscode-remote.remote-ssh
      vscodevim.vim

      # typescript/svelte
      svelte.svelte-vscode

      # astro
      astro-build.astro-vscode

      # nix
      jnoortheen.nix-ide

      # todo
      gruntfuggly.todo-tree
    ];
  };

  # This allows VS Code to edit it, while rebuild overwrites with defaults.
  home.activation.writeVscodeSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "${config.home.homeDirectory}/Library/Application Support/Code/User"
    cat > "${config.home.homeDirectory}/Library/Application Support/Code/User/settings.json" << 'EOF'
    ${builtins.toJSON vsCodeSettings}
    EOF
  '';
}
