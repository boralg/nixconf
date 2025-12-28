{ pkgs, ... }:
{
  home.username = "bora";
  home.homeDirectory = "/home/bora";

  imports = [
    ../../../modules/desktops/plasma/home
    ../../../modules/desktops/plasma/home/thinkpad-mouse.nix
    ../../../modules/programs/zsh/home.nix
    ../../../modules/programs/vscode/home.nix
  ];

  home.stateVersion = "25.05";

  programs.git = {
    enable = true;

    settings.user = {
      name = "boralg";
      email = "thinnrthinkr@gmail.com";
    };
  };
}
