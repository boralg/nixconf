{
  services.asusd = {
    enable = true;
    profileConfig = {
      text = builtins.readFile ./profile.ron;
    };
    auraConfigs = {
      default = {
        text = builtins.readFile ./aura.ron;
      };
    };
  };
}
