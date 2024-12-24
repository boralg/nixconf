{
  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

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
  };
}
