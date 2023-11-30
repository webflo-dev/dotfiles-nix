{
  description = "home manager and NixOS configuration (webflo edition)";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware/master";
  };


  outputs = { nixpkgs, home-manager, nixos-hardware,  ... } @ inputs:
  let 
    hostname = "xps13";
    system = "x86_64-linux";
    username = "florent";
  in 
  {
    nixosConfigurations = {
      "${hostname}" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs system hostname username;};
        modules = [
          ./hosts/${hostname}/configuration.nix
          nixos-hardware.nixosModules.dell-xps-13-9300
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = { inherit inputs username; };
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${username} = {
                imports = [ 
                  ./hosts/${hostname}/home.nix
                ];
              };
            };
          }
        ];
      };
    };

   homeConfigurations = {
      "${username}@${hostname}" = home-manager.lib.homeManagerConfiguration {
       pkgs = import nixpkgs { inherit system; };
       extraSpecialArgs = { inherit inputs system hostname username; };
       modules = [ ./hosts/${hostname}/home.nix ];
     };
   };
  };
}