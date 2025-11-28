{ pkgs, ... }:
{
  home.username = "bora";
  home.homeDirectory = "/home/bora";

  imports = [
    ../../../modules/desktops/plasma/home
    ../../../modules/programs/zsh/home.nix
    ../../../modules/programs/vscode/home.nix
  ];

  home.stateVersion = "25.05";

  programs.git = {
    enable = true;

    userName = "thinnerthinker";
    userEmail = "thinnrthinkr@gmail.com";
  };
}
