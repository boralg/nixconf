{
  xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };

  desktopManager.plasma6.enable = true;

  displayManager.sddm.enable = true;
  displayManager.sddm.wayland.enable = true;
  displayManager.defaultSession = "plasma";

  libinput.enable = true;

  asusd = {
    enable = true;
    profileConfig = builtins.readFile ./asusd/profile.ron;
    auraConfig = builtins.readFile ./asusd/aura.ron;
  };

  tor = {
    enable = true;
    client.enable = true;
  };

  openssh.enable = true;
  pcscd.enable = true;
}
