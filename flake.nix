{
  description = "onix's system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    roc = {
      url = "github:roc-lang/roc/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix.url = "github:nix-community/fenix";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, fenix, ... }@inputs:
    let
      commonArgs = {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
          nvidia.acceptLicense = true;
          permittedInsecurePackages = [
            "nix-2.15.3"
            "electron-25.9.0"
          ];
        };
      };
      pkgs = import nixpkgs commonArgs;
      unstablePkgs = import nixpkgs-unstable commonArgs;
    in
    {
      nixosConfigurations.onix = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        specialArgs = {
          inputs = inputs;
        };
        modules = [
          ./configuration.nix
          {
            nixpkgs.overlays = [
              (final: prev: {
                unstable = unstablePkgs;
                rust-analyzer-nightly = fenix.packages.${commonArgs.system}.latest.rust-analyzer;
                rust-analyzer-nightly-vscode = fenix.packages.${commonArgs.system}.rust-analyzer-vscode-extension;
              })
            ];
          }
        ];
      };
    };
}
