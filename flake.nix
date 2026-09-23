{
  description = "Junos16's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs = {
    nixosConfiguration.iitk-lab-pc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./hosts/iitk-lab-pc/configuration.nix
      ];
    };
  };
}
