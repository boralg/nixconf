{
  imports = [
    ./hardware-configuration.nix
    ../../modules/programs/zsh
    ../../modules/desktops/plasma
    ./pkgs.nix
  ];

  users.users.bora = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = [ ];
  };

  environment.etc = {
    nixos = {
      source = "/home/bora/nixconf";
    };
  };

  home-manager.users.bora =
    { ... }:
    {
      imports = [ ./home/bora.nix ];
    };

  networking.hostName = "dark";

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  plasma.enable = true;
  zsh.enable = true;

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
  system.stateVersion = "25.05"; # Did you read the comment?
}
