{
  description = "home manager and NixOS configuration (webflo edition)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs = { self, home-manager, nixpkgs, ... }@inputs:
    let
      username = "vm";
      system = "x86_64-linux";
    in
    {
      packages.${system}.default = home-manager.defaultPackage.${system};
      # packages.${system}.default = self.packages.${system};

      nixosConfigurations = {
        "${username}" = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs username system; };
          modules = [ ./nixos/configuration.nix ];
        };
      };


      # homeConfigurations = {
      #   "${username}" = home-manager.lib.homeManagerConfiguration {
      #     pkgs = import nixpkgs {
      #       inherit system;
      #       config.allowUnfree = true;
      #     };
      #     extraSpecialArgs = {
      #       inherit inputs username;
      #     };
      #     modules = [ ./home-manager/home.nix ];
      #   };
      # };
    };
}




