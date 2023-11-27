{ nixpkgs, inputs, home-manager, ... }:

{
  buildNixosConfigBis = (machine_name: { system, username, extraModules ? [ ], ... }:
    nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./machines/${machine_name}/nixos/configuration.nix
        # home-manager.nixosModules.home-manager
        # {
        #   home-manager.useGlobalPkgs = true;
        #   home-manager.useUserPackages = true;
        #   home-manager.users.${username} = import ./machines/${machine_name}/home-manager/home.nix;
        # }
      ] ++ extraModules;
      specialArgs = { inherit inputs system machine_name username; };
    }
  );


  buildHomeConfig = { machine_name, username, system, ... }: {
    homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
      inherit system;
      extraSpecialArgs = { inherit inputs username system; };
      modules = [ ./machines/${machine_name}/home-manager/home.nix ];
    };
  };
}
