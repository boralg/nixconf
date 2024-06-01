{ config, pkgs, lib, inputs, ... }:
let
  bashpkgs = import ./src/bashpkgs.nix {
    inherit pkgs lib;
    path = ./src/bashpkgs;
  };
  shovel = import ./src/pypkgs/shovel/default.nix { inherit pkgs; };
  purr = import ./src/pypkgs/purr/default.nix { inherit pkgs; };
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
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

  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  users.users.yallo = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = [ ];
  };

  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    elisa
    okular
    khelpcenter
  ];

  environment.systemPackages = [ shovel purr ] ++ bashpkgs ++ (import ./src/pkgs.nix pkgs inputs);

  services = import ./src/services.nix;

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
    enableSSHSupport = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  hardware.nvidia = import ./src/nvidia.nix config;

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
