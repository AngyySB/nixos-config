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
    openconnect-sso.url = "github:active-group/openconnect-sso";
  };
  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;

      # Shared modules + home-manager, plus the host's own directory
      mkHost =
        hostDir:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            hostDir
            ./modules
            home-manager.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
                users.jonas = import ./home;
              };
            }
          ];
        };
    in
    {
      devShells.x86_64-linux = {
        opengl = import ./shells/opengl.nix { inherit pkgs; };
      };
      nixosConfigurations = {
        nix-desktop = mkHost ./hosts/desktop;
        nix-laptop = mkHost ./hosts/laptop;
      };
    };
}
