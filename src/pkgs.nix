pkgs: inputs: with pkgs;
[
  nixos-option

  mesa-demos
  asusctl

  vim
  kate
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
      rust-analyzer-nightly-vscode
      wgsl-analyzer.wgsl-analyzer
      wholroyd.jinja
    ];
  })
  rust-analyzer-nightly
  nil
  nixpkgs-fmt

  spotify
  obsidian
  jetbrains.idea-community

  tree
  git
  git-lfs

  kolourpaint
  vlc
  kdenlive
  caffeine-ng
  ffmpeg
  gimp
  wl-clipboard
  discord
  qbittorrent
  obs-studio
  file
  aseprite
]
