{
  xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
    
    displayManager.defaultSession = "plasma";
    desktopManager.plasma5.enable = true;

    libinput.enable = true;

    videoDrivers = [ "nvidia" ];
  };

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
