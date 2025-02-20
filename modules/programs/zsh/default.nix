{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.zsh;
in
{
  options.zsh = {
    enable = lib.mkEnableOption "zsh";
  };

  config = lib.mkIf cfg.enable {
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;

    environment.pathsToLink = [ "/share/zsh" ];
  };
}
