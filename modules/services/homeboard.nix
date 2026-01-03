{
  pkgs,
  ...
}:
{
  systemd.user.services.homeboard = {
    description = "Homeboard Service";
    wantedBy = [ "default.target" ];
    after = [ "network.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.homeboard}/bin/homeboard -d /home/bora/Documents";
      Restart = "always";
      RestartSec = "10s";
    };
  };
}
