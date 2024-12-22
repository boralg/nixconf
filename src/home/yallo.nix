{ pkgs, ... }:
{
  home.username = "yallo";
  home.homeDirectory = "/home/yallo";

  modules = [
    ./home/rofi.nix
  ];

  home.stateVersion = "23.05";

  programs.git = {
    enable = true;

    userName = "thinnerthinker";
    userEmail = "thinnrthinkr@gmail.com";
  };
}
