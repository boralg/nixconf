{ pkgs, ... }:
{
  services.fprintd.enable = true;

  security.pam.services = {
    sddm.fprintAuth = false;
    login.fprintAuth = false;
  };
}
