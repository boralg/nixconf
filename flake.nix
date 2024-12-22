{
  description = "onix's system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    roc = {
      url = "github:roc-lang/roc/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix.url = "github:nix-community/fenix";
    vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      fenix,
      vscode-extensions,
      ...
    }@inputs:
    let
      commonArgs = {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
          nvidia.acceptLicense = true;
          permittedInsecurePackages =
            [
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
          inherit inputs;
        };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = [
              (final: prev: {
                unstable = unstablePkgs;
                rust-analyzer = fenix.packages.${commonArgs.system}.stable.rust-analyzer;
                rust-analyzer-vscode = fenix.packages.${commonArgs.system}.rust-analyzer-vscode-extension;
                vscode-extensions = vscode-extensions.extensions.${commonArgs.system};
              })
            ];
          }
        ];
      };
    };
}
