{ pkgs, lib, ... }:
let
  bashpkgs = import ./bashpkgs.nix {
    inherit pkgs lib;
    path = ./bashpkgs;
  };
  purr = import ./pypkgs/purr/default.nix { inherit pkgs; };
in
{
  config.environment.systemPackages =
    [
      purr
    ]
    ++ bashpkgs
    ++ (with pkgs; [
      nixos-option

      mesa-demos
      asusctl

      vim
      wget

      firefox
      tor
      tor-browser-bundle-bin
      chromium
      google-chrome

      (unstable.vscode-with-extensions.override {
        vscodeExtensions = with vscode-extensions.vscode-marketplace; [
          jnoortheen.nix-ide
          ms-python.python
          ms-python.vscode-pylance
          rust-analyzer-vscode
          wgsl-analyzer.wgsl-analyzer
          wholroyd.jinja

          mkhl.direnv
          editorconfig.editorconfig

          haskell.haskell
          justusadam.language-haskell

        ];
      })
      rust-analyzer
      nil
      nixfmt-rfc-style

      spotify
      obsidian
      jetbrains.idea-community
      android-studio

      jdk17

      tree
      git-lfs

      kdePackages.kdenlive
      kdePackages.kolourpaint
      vlc
      ffmpeg
      gimp
      wl-clipboard
      webcord
      obs-studio
      file
      aseprite

      foliate
    ]);
}
