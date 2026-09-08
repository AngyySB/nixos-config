{
  description = "jonas NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    stylix.url = "github:danth/stylix";
    home-manager = {
	url = "github:nix-community/home-manager";
	inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs = {nixpkgs, home-manager, ...} @ inputs: {
	nixosConfigurations = {
		nix-laptop = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = {inherit inputs;};
			modules = [
				./configuration.nix
				home-manager.nixosModules.default {
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						extraSpecialArgs = {inherit inputs;};
						users.jonas = import ./home;
					};
				}
			];
		};
	}; 
  };
}
