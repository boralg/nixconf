{
  description = "onix's partition configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, disko, ... }@inputs:
    {
      nixosConfigurations = {
        install = nixpkgs.lib.nixosSystem ({
          system = "x86_64-linux";
          modules = [
            ./configuration.nix

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
