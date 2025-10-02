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
        "glsld.binaryPath" = "${pkgs.glsld}/bin/glsld";
        # "glsl-analyzer.path" = "${pkgs.glsl_analyzer}/bin/glsl_analyzer";
        # "glsllint.glslangValidatorPath" = "${pkgs.glslang}/bin/glslangValidator";
      };

      extensions =
        (with pkgs.vscode-extensions.vscode-marketplace; [
          jnoortheen.nix-ide
          ms-python.python
          (ms-python.vscode-pylance.override { meta.license = [ ]; })
          rust-lang.rust-analyzer
          wgsl-analyzer.wgsl-analyzer
          wholroyd.jinja
          mtxr.sqltools
          bradlc.vscode-tailwindcss

          # nolanderc.glsl-analyzer

          # kuba-p.glsl-lsp

          # dtoplak.vscode-glsllint
          # slevesque.shader

          # jsdf.glsl-lsp-jsdf

          daiyousei-qz.glsld-vscode

          mkhl.direnv
          editorconfig.editorconfig
        ]);
    };
  };
}
