{ pkgs, lib, ... }:
let
  bashpkgs = import ../../modules/programs/bashpkgs { inherit pkgs lib; };
in
{
  config.fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
    cascadia-code
  ];

  config.environment.systemPackages =
    (with bashpkgs; [
      asusctl-white-keys
      chrome-gpu
      nrs
      nvidia-offload
      home-manager-log
      code
    ])
    ++ (with pkgs; [
      nixos-option

      mesa-demos
      asusctl

      nvim
      wget
      lazygit

      qass

      librewolf
      tor
      tor-browser-bundle-bin
      chromium
      # google-chrome

      claude-desktop

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

      foliate
    ]);
}
