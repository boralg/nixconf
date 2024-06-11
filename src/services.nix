{
  xserver = {
    enable = true;
    desktopManager.plasma5.enable = true;
    videoDrivers = [ "nvidia" ];
  };

  displayManager.sddm.enable = true;
  displayManager.sddm.wayland.enable = true;
  displayManager.defaultSession = "plasma";
  libinput.enable = true;

  asusd = {
    enable = true;
    auraConfig = builtins.readFile ./aura.ron;
  };

  tor = {
    enable = true;
    client.enable = true;
  };

  openssh = {
    enable = true;
  };

  pcscd = {
    enable = true;
  };
}
