inputs@{
  self,
  nixpkgs,
  nixpkgs-unstable,
  lix-module,
  home-manager,
  plasma-manager,
  fenix,
  vscode-extensions,
  nvf,
  qass,
  zen-browser,
  claude-desktop,
  ...
}:
let
  pkgs = import nixpkgs commonArgs;
  unstablePkgs = import nixpkgs-unstable commonArgs;

  commonArgs = {
    system = "x86_64-linux";
    config = {
      allowUnfreePredicate =
        pkg:
        builtins.elem (pkgs.lib.getName pkg) [
          "nvidia-x11"
          "nvidia-settings"
          "spotify"
          "obsidian"
          "android-studio-stable"
        ];
      nvidia.acceptLicense = true;
      permittedInsecurePackages = [
      ];
    };
  };

  commonModules = [
    lix-module.nixosModules.default
    ./configuration.nix
    home-manager.nixosModules.home-manager
    {
      nixpkgs.overlays = [
        (final: prev: {
          unstable = unstablePkgs;
        })
      ];
    }
  ];
in
{
  onix = nixpkgs.lib.nixosSystem {
    inherit pkgs;
    specialArgs = {
      inherit inputs;
    };
    modules = commonModules ++ [
      ./onix/configuration.nix
      { home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ]; }
      {
        nixpkgs.overlays = [
          (final: prev: {
            rust-analyzer = fenix.packages.${commonArgs.system}.stable.rust-analyzer;
            rust-analyzer-vscode = fenix.packages.${commonArgs.system}.rust-analyzer-vscode-extension;
            vscode-extensions = vscode-extensions.extensions.${commonArgs.system};
            nvim = self.packages.${pkgs.stdenv.system}.neovim;
            qass = qass.packages.${commonArgs.system}.default;
            zen-browser = zen-browser.packages.${commonArgs.system}.default;
            claude-desktop = claude-desktop.packages.${commonArgs.system}.claude-desktop-with-fhs;
          })
        ];
      }
      # TODO: move this away
    ];
  };
}
