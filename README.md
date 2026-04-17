# nixdev

Opinionated Home Manager flake for setting up a macOS development environment with a
consistent shell, editor, terminal, and tmux workflow.

## What It Configures

This flake currently manages:

- `zsh` with `fzf`, `zoxide`, `git identity`, and a few agent aliases
- `ghostty` terminal configuration
- `tmux` plus custom helper commands for AI-assisted pane layouts
- `neovim` with the bundled `config/nvim` LazyVim setup
- `starship` prompt
- `vscode` settings and extensions
- a small set of desktop apps and CLI tools (spotify, obsidian, google chrome)

The generated Home Manager configurations come from `config/local.nix`. Each entry in
`homes` becomes a flake output under `homeConfigurations.<username>`.

## Requirements

- macOS
- Apple Silicon (`aarch64-darwin`)
- Nix with flakes enabled

## Quick Start

### 1. Install Nix and enable flakes

```sh
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)
mkdir -p ~/.config/nix
echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf
```

### 2. Clone this repo

```sh
git clone <repo-url> nixdev
cd nixdev
```

### 3. Create your local config

`config/local.nix` is ignored by git so you can keep machine-specific values there.

```sh
cp PROJECT_DIR/config/example.nix PROJECT_DIR/config/local.nix
```

Edit `config/local.nix` and set your real values:

```nix
{
  homes = [
    {
      username = "your.username";
      name = "Your Name";
      email = "you@example.com";
      justTmuxSetup = false;
    }
  ];
}
```

If you only want the tmux tooling on a machine, set `justTmuxSetup = true`.

### 4. Apply the Home Manager config

Run the switch command with the username from `config/local.nix`:

```sh
nix run nixpkgs#home-manager -- switch --flake .#your.username --impure -b backup
```

The `-b backup` flag asks Home Manager to keep backups of replaced files.

### 5. Finish tmux plugin installation

After the first switch:

```sh
tmux
```

**Then press `Ctrl-b` followed by `Shift-I` to install TPM-managed plugins.**

## Common Workflows

### Rebuild after changes

```sh
nix run nixpkgs#home-manager -- switch --flake .#your.username --impure -b backup
# after first setup
hms PROJECT_DIR#your.username
# update packages
cd PROJECT_DIR
nix flake update
hms PROJECT_DIR#your.username
```

## Tmux Helpers

The tmux module installs a few helper commands for multi-pane development setups:

- `tdl <ai> [second_ai]`: open an editor pane plus one or two AI panes in the current project
- `tdlm <ai> [second_ai]`: open the same layout across each subdirectory in the current folder
- `tsl <pane_count> <command>`: run the same command in a tiled swarm of panes
- `tml <ai> [ai...]`: create one pane per command and tile them

Useful aliases included in the shell config:

- `cc` -> `claude`
- `cx` -> `codex`
- `ccli` -> `cursor-agent`
- `opc` -> `opencode`

Example:

```sh
tmux
tdl cx ccli
```

## Tmux navigation

- Shift + Arrow: navigate between windows
- Option + Arrow: navigate between panes

## Resources

- Tmux helpers based on: [omarchy/default/bash/fns/tmux in basecamp/omarchy](https://github.com/basecamp/omarchy/blob/dev/default/bash/fns/tmux)
- Tmux cheatsheet: [Tmux Cheat Sheet & Quick Reference | Session, window, pane and more](https://tmuxcheatsheet.com/)
- LazyVim: [🚀 Getting Started | LazyVim](https://www.lazyvim.org/)
- [LazyVim Cheatsheet](./LAZYVIM_CHEATSHEET.md)

## Project Layout

- `flake.nix`: flake entrypoint and Home Manager output generation
- `config/example.nix`: sample machine/profile definition
- `moduls/`: Home Manager modules for shell, tmux, Neovim, Starship, VS Code, and tools
- `config/nvim/`: bundled Neovim configuration
