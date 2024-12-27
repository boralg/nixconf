{ pkgs, ... }:
{
  home.username = "yallo";
  home.homeDirectory = "/home/yallo";

  imports =
    [
      ../../../modules/desktops/plasma/home.nix
      ../../../modules/desktops/hyprland/home.nix
    ];

  home.stateVersion = "23.05";

  programs.git = {
    enable = true;

    userName = "thinnerthinker";
    userEmail = "thinnrthinkr@gmail.com";
  };
}
