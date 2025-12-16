inputs@{
  self,
  nixpkgs,
  nixpkgs-unstable,
  home-manager,
  plasma-manager,
  impermanence,
  fenix,
  vscode-extensions,
  nvf,
  shader-language-server,
  qass,
  ...
}:
let
  pkgs = import nixpkgs commonArgs;
  unstablePkgs = import nixpkgs-unstable commonArgs;

  commonArgs = {
    system = "x86_64-linux";
    config = {
      # TODO: make this host specific
      allowUnfreePredicate =
        pkg:
        builtins.elem (pkgs.lib.getName pkg) [
          "nvidia-x11"
          "nvidia-settings"
          "spotify"
          "obsidian"
          "android-studio-stable"
          "claude-code"
        ];
      nvidia.acceptLicense = true;
      permittedInsecurePackages = [
      ];
    };
  };

  commonModules = [
    ./configuration.nix
    {
      nixpkgs.overlays = [
        (final: prev: {
          unstable = unstablePkgs;
        })
      ];
    }
    home-manager.nixosModules.home-manager
    { home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ]; }
    {
      nixpkgs.overlays = [
        (final: prev: {
          rust-analyzer = fenix.packages.${commonArgs.system}.stable.rust-analyzer;
          rust-analyzer-vscode = fenix.packages.${commonArgs.system}.rust-analyzer-vscode-extension;
          vscode-extensions = vscode-extensions.extensions.${commonArgs.system};
          # nvim = self.packages.${pkgs.stdenv.system}.neovim;
          qass = qass.packages.${commonArgs.system}.default;
          shader-language-server = shader-language-server.packages.${commonArgs.system}.default;
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
    ];
  };
  dark = nixpkgs.lib.nixosSystem {
    inherit pkgs;
    specialArgs = {
      inherit inputs;
    };
    modules = commonModules ++ [
      ./dark/configuration.nix
      impermanence.nixosModules.impermanence
    ];
  };
}
