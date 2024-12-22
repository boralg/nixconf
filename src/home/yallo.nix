{ pkgs, ... }:
{
  home.username = "yallo";
  home.homeDirectory = "/home/yallo";

  imports = [
    ./rofi.nix
  ];

  home.stateVersion = "23.05";

  programs.git = {
    enable = true;

    userName = "thinnerthinker";
    userEmail = "thinnrthinkr@gmail.com";
  };
}
