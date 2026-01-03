{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  time.timeZone = "Europe/Bucharest";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  # TODO: make this host specific
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [
    3000
    4663 # homeboard
    8000
    8080
  ];

  services.xserver.enable = true;
  hardware.graphics.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  security.rtkit.enable = true;
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
    # enableSSHSupport = true;
  };

  programs.ssh.startAgent = true;

  services.openssh.enable = true;
  services.pcscd.enable = true;
}
