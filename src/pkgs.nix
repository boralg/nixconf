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
    vscodeExtensions = with vscode-extensions; [
      jnoortheen.nix-ide
      ms-python.python
      ms-python.vscode-pylance
      rust-analyzer-nightly-vscode
    ];
  })
  rust-analyzer-nightly
  rnix-lsp

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
  pinentry-curses
  qbittorrent
  obs-studio
  file
  aseprite
]
