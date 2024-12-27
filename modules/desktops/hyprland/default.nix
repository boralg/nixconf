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
    services.displayManager.sddm.enable = true;

    environment.systemPackages = with pkgs; [
      kitty
    ];
  };
}
