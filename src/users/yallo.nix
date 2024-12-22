{ pkgs, ... }:
let
  secret = import ./yallo.secret.nix;
in
{
  home.username = "yallo";
  home.homeDirectory = "/home/yallo";

  home.stateVersion = "23.05";

  programs.git = {
    enable = true;

    userName = "thinnerthinker";
    userEmail = "thinnrthinkr@gmail.com";
  };
}
