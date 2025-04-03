{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.plasma;
in
{
  options.plasma = {
    enable = lib.mkEnableOption "Plasma 6";
  };

  config = lib.mkIf cfg.enable {
    services = {
      desktopManager.plasma6.enable = true;

      displayManager.sddm.enable = true;
      displayManager.sddm.wayland.enable = true;
      displayManager.defaultSession = "plasma";
    };

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      elisa
      khelpcenter
    ];
  };
}
