{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./src/pkgs.nix
    ./src/services.nix
    ./src/nvidia.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [ "apm=power_off" "acpi=force" "reboot=acpi" ];
  };


  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking = {
    hostName = "onix";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Bucharest";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  users.users.yallo = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = [ ];
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    okular
    khelpcenter
  ];

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
    enableSSHSupport = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.direnv.enable = true;

  hardware.graphics.enable = true;

  security.rtkit.enable = true;
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
