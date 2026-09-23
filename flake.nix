{
  description = "Junos16's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }: {
    nixosConfigurations.iitk-lab = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./hosts/iitk-lab/configuration.nix
	
	home-manager.nixosModules.home-manager

	{
	  home-manager.useGlobalPkgs = true;
	  home-manager.users.hriddhit = 
	    import ./home/hriddhit/home.nix;
	}
      ];
    };
  };
}
