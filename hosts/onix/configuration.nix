{
  imports = [
    ./hardware-configuration.nix
    ../../modules/desktops/plasma
    ./pkgs.nix
    ./nvidia.nix
    ../../modules/services/asusd
    ../../modules/services/asus-key-lights-on-wake.nix
    ../../modules/programs/foliate.nix
  ];

  users.users.yallo = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = [ ];
  };

  home-manager.users.yallo =
    { ... }:
    {
      imports = [ ./home/yallo.nix ];
    };

  boot.kernelParams = [
    "apm=power_off"
    "acpi=force"
    "reboot=acpi"
  ];

  networking.hostName = "onix";

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  plasma.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  services.tor = {
    enable = true;
    client.enable = true;
  };

  programs.direnv.enable = true;
}
