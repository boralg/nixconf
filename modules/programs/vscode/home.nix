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
        "shader-validator.serverPath" = "${pkgs.shader-language-server}/bin/shader-language-server";
        "claudeCode.claudeProcessWrapper" = "${pkgs.claude-code}/bin/claude";
      };

      extensions = (
        with pkgs.vscode-extensions.vscode-marketplace;
        [
          jnoortheen.nix-ide
          ms-python.python
          (ms-python.vscode-pylance.override { meta.license = [ ]; })
          rust-lang.rust-analyzer
          wgsl-analyzer.wgsl-analyzer
          wholroyd.jinja
          mtxr.sqltools
          bradlc.vscode-tailwindcss

          antaalt.shader-validator

          mkhl.direnv
          editorconfig.editorconfig

          (anthropic.claude-code.override { meta.license = [ ]; })
        ]
      );
    };
  };
}
