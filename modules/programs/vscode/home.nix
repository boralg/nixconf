{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;

    package = pkgs.unstable.vscodium;

    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;

      userSettings = builtins.fromJSON (builtins.readFile ./settings.json) // {
        "rust-analyzer.server.path" = "${pkgs.rust-analyzer}/bin/rust-analyzer";
      };

      extensions = with pkgs.vscode-extensions.vscode-marketplace; [
        jnoortheen.nix-ide
        ms-python.python
        (ms-python.vscode-pylance.override { meta.license = [ ]; })
        rust-lang.rust-analyzer
        wgsl-analyzer.wgsl-analyzer
        wholroyd.jinja

        mkhl.direnv
        editorconfig.editorconfig
      ];
    };
  };
}
