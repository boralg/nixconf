{
  description = "onix's system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    roc = {
      url = "github:roc-lang/roc/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, disko, ... }@inputs:
    let
      config = {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
        ];
      };
    in
    {
      nixosConfigurations = {
        onix = nixpkgs.lib.nixosSystem config;

        install = nixpkgs.lib.nixosSystem (config // {
          modules = config.modules ++ [
            disko.nixosModules.disko
            {
              disko.devices = {
                disk = {
                  main = {
                    type = "disk";
                    device = ""; # Replaced by disko-install's argument
                    content = {
                      type = "gpt";
                      partitions = {
                        ESP = {
                          priority = 1;
                          name = "ESP";
                          start = "1M";
                          end = "128M";
                          type = "EF00";
                          content = {
                            type = "filesystem";
                            format = "vfat";
                            mountpoint = "/boot";
                          };
                        };
                        root = {
                          size = "100%";
                          content = {
                            type = "btrfs";
                            extraArgs = [ "-f" ]; # Override existing partition
                            mountpoint = "/";
                            mountOptions = [ "compress=zstd" "noatime" ];
                          };
                        };
                      };
                    };
                  };
                };
              };
            }
          ];
        });
      };
    };
}
