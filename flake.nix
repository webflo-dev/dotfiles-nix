{
  description = "NixOS & Home manager (webflo edition)";

  inputs = {

    # nixpkgs.url = "github:nixos/nixpkgs";
    nixpkgs.url = "github:nixos/nixpkgs/release-23.11";

    home-manager = {
      # url = "github:nix-community/home-manager";
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware";

    hyprland.url = "github:hyprwm/Hyprland";
    ags.url = "github:Aylur/ags";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs = { nixpkgs, home-manager, nixos-hardware, hyprland, ... } @ inputs:
    let
      defaultHomeManagerModules = [
        home-manager.nixosModules.home-manager
        {
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
      ];
    in
    {
      nixosConfigurations = {
        xps13 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules =
            defaultHomeManagerModules
            ++ [
              ./hosts/common.nix
              nixos-hardware.nixosModules.dell-xps-13-9300
              ./hosts/xps13/nixos
              { home-manager.users.florent = import ./hosts/xps13/home-manager; }
            ];
        };
      };

      homeConfigurations = {
        "florent@xps13" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "x86_64-linux"; };
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./hosts/xps13/home-manager ];
        };
      };

    };
}
