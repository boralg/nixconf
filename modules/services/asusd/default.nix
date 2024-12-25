{
  services.asusd = {
    enable = true;
    profileConfig = builtins.readFile ./profile.ron;
    auraConfig = builtins.readFile ./aura.ron;
  };
}
