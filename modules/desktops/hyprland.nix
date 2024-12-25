{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.hyprland;
in
{
  options.hyprland = {
    enable = lib.mkEnableOption "Hyprland";
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland.enable = true;

    environment.systemPackages = [
      pkgs.kitty
    ];
  };
}
