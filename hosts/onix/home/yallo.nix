{ pkgs, ... }:
{
  home.username = "yallo";
  home.homeDirectory = "/home/yallo";

  imports = [
    ../../../modules/desktops/plasma/home
    ../../../modules/programs/zsh/home.nix
    ../../../modules/programs/vscode/home.nix
  ];

  home.stateVersion = "23.05";

  programs.git = {
    enable = true;

    userName = "thinnerthinker";
    userEmail = "thinnrthinkr@gmail.com";
  };
}
