{
  imports = [
    ./hardware-configuration.nix
    ../../modules/programs/zsh
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

  environment.etc = {
    nixos = {
      source = "/home/yallo/nixconf";
    };
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
  zsh.enable = true;

  programs.steam = {
    enable = false;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  services.tor = {
    enable = true;
    client.enable = true;
  };

  programs.direnv.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
