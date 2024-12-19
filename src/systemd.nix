{
  systemd.services = {
    key-lights-wake = {
      description = "Set Asus keyboard white keys on resume";
      wantedBy = [ "suspend.target" ];
      after = [ "suspend.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "/run/current-system/sw/bin/asusctl-white-keys";
      };
    };
  };
}
