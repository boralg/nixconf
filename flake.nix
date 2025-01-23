{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    roc = {
      url = "github:roc-lang/roc/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix.url = "github:nix-community/fenix";
    vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };

  outputs =
    inputs@{
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      plasma-manager,
      fenix,
      vscode-extensions,
      zen-browser,
      ...
    }:
    {
      nixosConfigurations = import ./hosts inputs;
    };
}
