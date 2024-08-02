pkgs: inputs: with pkgs;
[
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
    ];
  })
  rust-analyzer
  nil
  nixpkgs-fmt

  spotify
  obsidian
  jetbrains.idea-community

  tree
  git
  git-lfs

  kdePackages.kdenlive
  kdePackages.kolourpaint
  vlc
  caffeine-ng
  ffmpeg
  gimp
  wl-clipboard
  webcord
  qbittorrent
  obs-studio
  file
  aseprite
]
