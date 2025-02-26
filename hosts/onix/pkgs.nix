{ pkgs, lib, ... }:
let
  bashpkgs = import ../../modules/programs/bashpkgs { inherit pkgs lib; };
  purr = import ../../modules/programs/purr { inherit pkgs; };
in
{
  config.fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
    cascadia-code
  ];

  config.environment.systemPackages =
    [
      purr
    ]
    ++ (with bashpkgs; [
      asusctl-white-keys
      chrome-gpu
      nrs
      nvidia-offload
      home-manager-log
    ])
    ++ (with pkgs; [
      nixos-option

      mesa-demos
      asusctl

      nvim
      wget
      lazygit

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
        ];
      })
      rust-analyzer
      nixd
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
