{ pkgs, ... }:
{
  home.username = "yallo";
  home.homeDirectory = "/home/yallo";

  imports = [
    ../../../modules/desktops/plasma/home
    ../../../modules/desktops/plasma/home/asus-mouse.nix
    ../../../modules/programs/zsh/home.nix
    ../../../modules/programs/vscode/home.nix
  ];

  home.stateVersion = "23.05";

  programs.git = {
    enable = true;

    settings.user = {
      name = "thinnerthinker";
      email = "thinnrthinkr@gmail.com";
    };
  };
}
