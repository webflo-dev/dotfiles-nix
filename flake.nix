{
  description = "home manager and NixOS configuration (webflo edition)";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware/master";
  };


  outputs = { nixpkgs, home-manager, ... } @ inputs:
  {
    nixosConfigurations = {
      xps13 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [
          ./hosts/xps13/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = {
                inherit inputs;
                username = "florent";
              };
              useGlobalPkgs = true;
              useUserPackages = true;
              users."xps13" = {
                imports = [ 
                  ./hosts/xps13/home.nix
                ];
              };
            };
          }
        ];
      };
    };

    homeConfigurations = {
       "florent@xps13" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
        };
        extraSpecialArgs = { 
          inherit inputs;
          username = "florent"; 
        };
        modules = [ ./hosts/xps13/home.nix ];
      };
    };
  };
}
