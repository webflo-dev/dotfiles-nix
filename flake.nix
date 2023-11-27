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
      vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [
          ./machines/vm/nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = {
                inherit inputs;
                username = "vm";
              };
              useGlobalPkgs = true;
              useUserPackages = true;
              users.vm = {
                imports = [ 
                  ./machines/vm/home-manager/home.nix
                ];
              };
            };
          }
        ];
      };
    };

    homeConfigurations = {
      vm = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          # config.allowUnfree = true;
        };
        extraSpecialArgs = { 
          inherit inputs;
          username = "vm"; 
        };
        modules = [ ./machines/vm/home-manager/home.nix ];
      };
    };
  };
  
    # let
    #   buildNixosConfig = { machine_name, system, username, extraModules ? [ ], ... }:
    #     nixpkgs.lib.nixosSystem {
    #       inherit system;
    #       specialArgs = { inherit inputs system machine_name username; };
    #       modules = [
    #         ./machines/${machine_name}/nixos/configuration.nix
    #         home-manager.nixosModules.home-manager
    #         {
    #           home-manager.useGlobalPkgs = true;
    #           home-manager.useUserPackages = true;
    #           home-manager.users.${username} = import ./machines/${machine_name}/home-manager/home.nix;
    #         }
    #       ] ++ extraModules;
    #     };

    # in
    # {
    #   nixosConfigurations =
    #     {
    #       vm = buildNixosConfig {
    #         machine_name = "vm";
    #         system = "x86_64-linux";
    #         username = "vm";
    #         extraModules = [ ];
    #       };
    #     };

    #   homeConfigurations = {
    #     vm = home-manager.lib.homeManagerConfiguration {
    #       pkgs = import nixpkgs {
    #         system = "x86_64-linux";
    #         config.allowUnfree = true;
    #       };
    #       extraSpecialArgs = { inherit inputs; } // { username = "vm"; };
    #       modules = [ ./machines/vm/home-manager/home.nix ];
    #     };
    #   };
    # };
}

   
