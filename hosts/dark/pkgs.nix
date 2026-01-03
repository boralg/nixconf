{ pkgs, lib, ... }:
let
  bashpkgs = import ../../modules/programs/bashpkgs { inherit pkgs lib; };
in
{
  config.fonts.packages = with pkgs; [
    cascadia-code
  ];

  config.environment.systemPackages =
    (with bashpkgs; [
      nrs
      home-manager-log
      code
    ])
    ++ (with pkgs; [
      nixos-option

      wget

      qass
      homeboard

      librewolf
      chromium
      # google-chrome

      rust-analyzer
      nixd
      nixfmt-rfc-style

      spotify
      obsidian
      jetbrains.idea-community

      jdk17

      file
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

      claude-code
      claude-desktop
    ]);
}
