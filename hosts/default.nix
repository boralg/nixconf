inputs@{
  self,
  nixpkgs,
  nixpkgs-unstable,
  home-manager,
  plasma-manager,
  fenix,
  vscode-extensions,
  nvf,
  zen-browser,
  ...
}:
let
  commonArgs = {
    system = "x86_64-linux";
    config = {
      allowUnfree = true;
      nvidia.acceptLicense = true;
      permittedInsecurePackages = [
      ];
    };
  };
  pkgs = import nixpkgs commonArgs;
  unstablePkgs = import nixpkgs-unstable commonArgs;

  commonModules = [
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
            zen-browser = zen-browser.packages.${commonArgs.system}.default;
          })
        ];
      }
      # TODO: move this away
    ];
  };
}
