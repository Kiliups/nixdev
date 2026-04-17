{pkgs, ... }:
{
  home.packages = with pkgs; [
    obsidian
    spotify
    google-chrome
  ];
}